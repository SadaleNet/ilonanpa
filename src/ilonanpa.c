/*
Copyright 2019 Wong Cho Ching <https://sadale.net>

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include <stdbool.h>
#include <stdint.h>
#include "stm8.h"

//Addresses of EEPROM values.
//For AWT/LMA/PKT, each of them are array of six values.
//For AWT, The first value is the minimum value of ALA reading at EN position
//The second value is the minimum value of WAN reading at EN position
//The third value is the minimum value of TU reading at EN position
//The next three values are the WEKA position correspondent of the previous three values.
#define EEPROM_AWT_THRESHOLD *(volatile uint16_t *)0x4000
#define EEPROM_LMA_THRESHOLD *(volatile uint16_t *)0x400C
#define EEPROM_PKT_THRESHOLD *(volatile uint16_t *)0x4018
#define EEPROM_SAVED_VALUE *(volatile int16_t *)0x4024
#define EEPROM_BRIGHTNESS *(volatile uint8_t *)0x4026
#define EEPROM_DEBUG *(volatile int16_t *)0x4028

//Timer-related handling
#define TIMER_FREQ 12500
#define MIN_MAX_ACTION_COUNTER 20
#define TIME_TO_ENTER_PASSWORD_MODE 62500 //5 seconds at 12500Hz
#define TIME_FOR_CALIBRATION_TIMEOUT 37500 //3 seconds at 12500Hz

//En/weka detection handling
#define EN_WEKA_DETECTION_FRAME 400 //en/weka should get detected every 0.032 second (at 12500Hz)
#define EN_WEKA_WAIT_FRAME 25 //We have to ensure 0.002s(25 frames) of no LEDs before checking the value of en/weka

//Minimum and maximum value that ilo nanpa can handle.
#define MAX_VALUE 1600
#define MIN_VALUE -1600

//Definition of LED ports and pins
#define LED_A_PORT    PA
#define LED_A_PIN     PIN1
#define LED_B_PORT    PA
#define LED_B_PIN     PIN3
#define LED_C_PORT    PB
#define LED_C_PIN     PIN4
#define LED_D_PORT    PC
#define LED_D_PIN     PIN3
#define LED_E_PORT    PC
#define LED_E_PIN     PIN6

//Port definition of buttons
#define EN_WEKA_PORT	PB
#define EN_WEKA_PIN		PIN5
#define AWT_PORT		PC
#define AWT_PIN			PIN4
#define LMA_PORT		PD
#define LMA_PIN			PIN5
#define PKT_PORT		PD
#define PKT_PIN			PIN6

//ADC channels for button groups
#define BUTTON_AWT_CHANNEL 2 //ala, wan, tu
#define BUTTON_LMA_CHANNEL 5 //luka, mute, ali [shared with debug pin!]
#define BUTTON_PKT_CHANNEL 6 //pana, kama, tenpo

//If the ADC reading is above this value, one of the button in the ADC group is pressed
#define MIN_ANALOG_VALUE 0x300

//For "frame" delay skipping. Used for maintaining the "fps".
uint8_t timer4TriggeredCount = 0;

//Debouncing value. A value is only accepted if the same value is read for 3 times consecutively
struct DebouncedValueU8_3 {
	uint8_t value[3];
	uint8_t offset;
};

//Push a new value to the deboucing ring buffer. Returns the debounced value on success, supplied default value on failure.
uint8_t debounced_value_u8_3_push_value(struct DebouncedValueU8_3* debouncedValueU8_3, uint8_t newValue, uint8_t defaultValue){
	debouncedValueU8_3->value[debouncedValueU8_3->offset++] = newValue;
	if(debouncedValueU8_3->offset>=sizeof(debouncedValueU8_3->value)/sizeof(*(debouncedValueU8_3->value)))
		debouncedValueU8_3->offset = 0;
	for(uint8_t i=1; i<( sizeof(debouncedValueU8_3->value)/sizeof(*(debouncedValueU8_3->value)) ); i++){
		if(debouncedValueU8_3->value[0]!=debouncedValueU8_3->value[i])
			return defaultValue; //Debounce failed. Returning the supplied default value
	}
	return debouncedValueU8_3->value[0]; //Debounce success!
}

uint16_t analog_read(uint8_t);
uint16_t analog_read_with_led_b_on(uint8_t channel);

//Detect which button is pressed based on ADC reading, current en/weka position and the threshold values supplied.
uint8_t button_read(uint16_t adcValue, bool wekaMode, volatile uint16_t *thresholds){
	uint8_t wekaOffset = wekaMode?3:0;
	if(adcValue >= thresholds[0+wekaOffset])
		return 1;
	else if(adcValue >= thresholds[1+wekaOffset])
		return 2;
	else if(adcValue >= thresholds[2+wekaOffset])
		return 3;
	else
		return 0;
}

//Function for litting charlieplex'd LEDs. 0~15: lit one LED. 
//16: lit all group A LEDs. 17: all group B. 18: C. 19: D. 20: all group A except "WEKA ANU ALA".
//16~19 is used for timer reaching minimum value (-1600)
//17~20 is used for timer reaching maximum value (1600)
//By litting 4 LEDs at once, it's brighter than litting up LED 0~15 one by one.
void litLed(int ledId) {
	#define CHARLIEPLEX_LED_OUTPUT(SRC, SINK) \
	/* Set pins to output mode */ \
	PORT(LED_##SRC##_PORT, DDR) |= LED_##SRC##_PIN; \
	PORT(LED_##SINK##_PORT, DDR) |= LED_##SINK##_PIN; \
	/* Set pins to push-pull mode (For open-drain only pins, this bit has no effect) */ \
	PORT(LED_##SRC##_PORT, CR1) |= LED_##SRC##_PIN; \
	PORT(LED_##SINK##_PORT, CR1) |= LED_##SINK##_PIN; \
	/* Set LED outputs */ \
	PORT(LED_##SRC##_PORT, ODR) |= LED_##SRC##_PIN; \
	PORT(LED_##SINK##_PORT, ODR) &= ~LED_##SINK##_PIN

	//LED_A_PIN LED_B_PIN
    PA_DDR &= ~(LED_A_PIN|LED_B_PIN); //Setting the pins to INPUT mode
    PA_CR1 &= ~(LED_A_PIN|LED_B_PIN); //Setting the pins to FLOATING mode. No pull up.
	//LED_C_PIN
    PB_DDR &= ~(LED_C_PIN); //Setting the pins to INPUT mode
    PB_CR1 &= ~(LED_C_PIN); //Setting the pins to FLOATING mode. No pull up.
    //LED_D_PIN LED_E_PIN
    PC_DDR &= ~(LED_D_PIN|LED_E_PIN); //Setting the pins to INPUT mode
    PC_CR1 &= ~(LED_D_PIN|LED_E_PIN); //Setting the pins to FLOATING mode. No pull up.

	switch(ledId){
		case 0:		CHARLIEPLEX_LED_OUTPUT(A, B);	break;
		case 1:		CHARLIEPLEX_LED_OUTPUT(A, C);	break;
		case 2:		CHARLIEPLEX_LED_OUTPUT(A, D);	break;
		case 3:		CHARLIEPLEX_LED_OUTPUT(A, E);	break;
		case 4:		CHARLIEPLEX_LED_OUTPUT(B, A);	break;
		case 5:		CHARLIEPLEX_LED_OUTPUT(B, C);	break;
		case 6:		CHARLIEPLEX_LED_OUTPUT(B, D);	break;
		case 7:		CHARLIEPLEX_LED_OUTPUT(B, E);	break;
		case 8:		CHARLIEPLEX_LED_OUTPUT(D, A);	break;
		case 9:		CHARLIEPLEX_LED_OUTPUT(D, B);	break;
		case 10:	CHARLIEPLEX_LED_OUTPUT(D, C);	break;
		case 11:	CHARLIEPLEX_LED_OUTPUT(D, E);	break;
		case 12:	CHARLIEPLEX_LED_OUTPUT(E, B);	break; //Intentionally swapped with 13 because of hardware LED position
		case 13:	CHARLIEPLEX_LED_OUTPUT(E, A);	break; //Intentionally swapped with 12 because of hardware LED position
		case 14:	CHARLIEPLEX_LED_OUTPUT(E, C);	break;
		case 15:	CHARLIEPLEX_LED_OUTPUT(E, D);	break;
		case 16:
			CHARLIEPLEX_LED_OUTPUT(A, B);
			CHARLIEPLEX_LED_OUTPUT(A, C);
			CHARLIEPLEX_LED_OUTPUT(A, D);
			CHARLIEPLEX_LED_OUTPUT(A, E);
		break;
		case 17:
			CHARLIEPLEX_LED_OUTPUT(B, A);
			CHARLIEPLEX_LED_OUTPUT(B, C);
			CHARLIEPLEX_LED_OUTPUT(B, D);
			CHARLIEPLEX_LED_OUTPUT(B, E);
		break;
		case 18:
			CHARLIEPLEX_LED_OUTPUT(D, A);
			CHARLIEPLEX_LED_OUTPUT(D, B);
			CHARLIEPLEX_LED_OUTPUT(D, C);
			CHARLIEPLEX_LED_OUTPUT(D, E);
		break;
		case 19:
			CHARLIEPLEX_LED_OUTPUT(E, B);
			CHARLIEPLEX_LED_OUTPUT(E, A);
			CHARLIEPLEX_LED_OUTPUT(E, C);
			CHARLIEPLEX_LED_OUTPUT(E, D);
		break;
		case 20:
			CHARLIEPLEX_LED_OUTPUT(A, C);
			CHARLIEPLEX_LED_OUTPUT(A, D);
			CHARLIEPLEX_LED_OUTPUT(A, E);
		break;
		default:
		break;
	}
}

//TIM4 Update/overflow ISR. 12500Hz.
void TIM4_update(void) __interrupt(TIM4_OVR_UIF_IRQ) {
	timer4TriggeredCount++;

    // Clear Timer 4 Status Register 1 Update Interrupt Flag (UIF) (bit 0)
    TIM4_SR &= ~TIM_SR_UIF;
}

//Read ADC value
uint16_t analog_read(uint8_t channel) {
	ADC_CSR = channel; // Select channel 2 (AIN2=PC4)
    ADC_CR1 &= ~ADC_CR1_CONT; // Single conversion mode
    ADC_CR1 |= ADC_CR1_ADON; // Start conversion
    do { nop(); } while ((ADC_CSR >> 7) == 0);
    ADC_CSR &= ~ADC_CSR_EOC; // Clear "End of conversion"-flag
    return (ADC_DRH << 2) | (ADC_DRL >> 6);  // Left aligned
}

//Read ADC value with LED B pin set to HIGH.
//This function exists to reduce the undesirable effect of ADC reading cause by other group of buttons as well as en/weka slider
//Without this function, ALA+LUKA+TENPO buttons combination doesn't work properly
uint16_t analog_read_with_led_b_on(uint8_t channel) {
	uint16_t ret;
	//Set LED B to PUSH-PULL OUTPUT HIGH for measurement
	PORT(LED_B_PORT, DDR) |= LED_B_PIN;
	PORT(LED_B_PORT, CR1) |= LED_B_PIN;
	PORT(LED_B_PORT, ODR) |= LED_B_PIN;
	ret = analog_read(channel);
	//Set LED B to INPUT FLOATING after completion of measurement
	PORT(LED_B_PORT, DDR) &= ~LED_B_PIN;
	PORT(LED_B_PORT, CR1) &= ~LED_B_PIN;
	return ret;
}

//Unlocks the EEPROM to allows writing data onto it.
void eeprom_unlock(void) {
	//Unlock EEPROM if required
	if(!(FLASH_IAPSR&FLASH_IAPSR_DUL)){
		FLASH_DUKR = FLASH_DUKR_KEY_1;
		FLASH_DUKR = FLASH_DUKR_KEY_2;
	}

	//Wait until the EEPROM is unlocked
	while(!(FLASH_IAPSR&FLASH_IAPSR_DUL));
}

//Lock the EEPROM to prevent it from being written.
void eeprom_lock(void) {
	FLASH_IAPSR &= ~FLASH_IAPSR_DUL;
}

//Convert numeric value into LED state.
uint16_t convertValueToLedState(int16_t value){
	//Value to LED mapping
	#define LED_WEKA_ANU_ALA (1 << 0)
	#define LED_WAN (1 << 1)
	#define LED_TU_1 (1 << 2)
	#define LED_TU_2 (1 << 3)
	#define LED_LUKA_1 (1 << 4)
	#define LED_LUKA_2 (1 << 5)
	#define LED_LUKA_3 (1 << 6)
	#define LED_MUTE_1 (1 << 7)
	#define LED_MUTE_2 (1 << 8)
	#define LED_MUTE_3 (1 << 9)
	#define LED_MUTE_4 (1 << 10)
	#define LED_ALI (1 << 11)
	#define LED_ALI_ALI_1 (1 << 12)
	#define LED_ALI_ALI_2 (1 << 13)
	#define LED_ALI_ALI_ALI_ALI_ALI_1 (1 << 14)
	#define LED_ALI_ALI_ALI_ALI_ALI_2 (1 << 15)

	//If the current value is higher than the LED value,
	//lit up the LED and substract the current value by the LED value.
	#define LED_CONVERT_VALUE(RET, VALUE, DEDUCTABLE, LED_VALUE) \
		if(VALUE >= DEDUCTABLE){ \
			RET |= LED_VALUE; \
			VALUE -= DEDUCTABLE; \
		}

	//Lit up the "WEKA ANU ALA" LED for 0 or negative values
	uint16_t ret = 0;
	if(value<=0){
		ret |= LED_WEKA_ANU_ALA;
		value = -value;
	}

	//Perform the value-to-LED conversion for each LED.
	LED_CONVERT_VALUE(ret, value, 500, LED_ALI_ALI_ALI_ALI_ALI_1);
	LED_CONVERT_VALUE(ret, value, 500, LED_ALI_ALI_ALI_ALI_ALI_2);
	LED_CONVERT_VALUE(ret, value, 200, LED_ALI_ALI_1);
	LED_CONVERT_VALUE(ret, value, 200, LED_ALI_ALI_2);
	LED_CONVERT_VALUE(ret, value, 100, LED_ALI);
	LED_CONVERT_VALUE(ret, value, 20, LED_MUTE_1);
	LED_CONVERT_VALUE(ret, value, 20, LED_MUTE_2);
	LED_CONVERT_VALUE(ret, value, 20, LED_MUTE_3);
	LED_CONVERT_VALUE(ret, value, 20, LED_MUTE_4);
	LED_CONVERT_VALUE(ret, value, 5, LED_LUKA_1);
	LED_CONVERT_VALUE(ret, value, 5, LED_LUKA_2);
	LED_CONVERT_VALUE(ret, value, 5, LED_LUKA_3);
	LED_CONVERT_VALUE(ret, value, 2, LED_TU_1);
	LED_CONVERT_VALUE(ret, value, 2, LED_TU_2);
	LED_CONVERT_VALUE(ret, value, 1, LED_WAN);

	return ret;
}

//Disables programming mode and allows the programming pin to be used for ADC conversion
void disable_swim_and_disable_schmitt_trigger(void){
	// Disables SWIM
	CFG_GCR |= CFG_GCR_SWD; //Disables SWIM
	PD_CR1 &= ~PIN1; //Set the SWIM pin to floating mode

	ADC_TDRL |= PIN5; //Disable schmitt triggers for the pin
}

//This is the first mode entered on power up.
//It allows the user to stay in programming mode, or enter factory mode (via password mode)
//Returns true for entering password mode, returns false for normal mode.
//Get stuck here without returning if it's staying in programming mode.
bool programmingMode(void){
	//To enter programming mode, hold both PKT before power on
	//To enter password mode, hold both AWT before power on
	uint16_t passwordModeTimer = 0;

	//If these two buttons are held for 5 seconds, we enter password mode, which can lead to factory mode
	while((analog_read_with_led_b_on(BUTTON_AWT_CHANNEL)>=MIN_ANALOG_VALUE)){
		if(passwordModeTimer++ >= TIME_TO_ENTER_PASSWORD_MODE)
			return true;
		wfi(); //Frame-limiting with TIM4
	}

	//If PKT button is held, we can enter programming mode
	while((analog_read_with_led_b_on(BUTTON_PKT_CHANNEL)>=MIN_ANALOG_VALUE));

	return false;
}

//If the user enters the correct password, it would lead to factory mode.
//Returns true if the password is correct, false else.
bool passwordMode(void){
	wfi(); //Add a delay of 12500Hz before performing next measurement
	bool previousAwtButtonValue = (analog_read_with_led_b_on(BUTTON_AWT_CHANNEL)>=MIN_ANALOG_VALUE);
	wfi(); //Add a delay of 12500Hz before performing next measurement
	bool previousLmaButtonValue = (analog_read_with_led_b_on(BUTTON_LMA_CHANNEL)>=MIN_ANALOG_VALUE);
	wfi(); //Add a delay of 12500Hz before performing next measurement
	bool previousPktButtonValue = (analog_read_with_led_b_on(BUTTON_PKT_CHANNEL)>=MIN_ANALOG_VALUE);
	wfi(); //Add a delay of 12500Hz before performing next measurement
	bool awtButtonValue = false;
	bool lmaButtonValue = false;
	bool pktButtonValue = false;
	struct DebouncedValueU8_3 debouncedValueAwt;
	struct DebouncedValueU8_3 debouncedValueLma;
	struct DebouncedValueU8_3 debouncedValuePkt;
	uint8_t actionCounter = 0;

	bool success = false;
	uint8_t password[] = {1,3,2,3,1,2,2,3};
	uint8_t currentPasswordPos = 0;
	while(true){
		if(actionCounter==0){
			awtButtonValue = debounced_value_u8_3_push_value(&debouncedValueAwt, 
										(analog_read_with_led_b_on(BUTTON_AWT_CHANNEL)>=MIN_ANALOG_VALUE),
										previousAwtButtonValue);
		}else if(actionCounter==1){
			lmaButtonValue = debounced_value_u8_3_push_value(&debouncedValueLma, 
										(analog_read_with_led_b_on(BUTTON_LMA_CHANNEL)>=MIN_ANALOG_VALUE),
										previousLmaButtonValue);
		}else if(actionCounter==2){
			pktButtonValue = debounced_value_u8_3_push_value(&debouncedValuePkt, 
										(analog_read_with_led_b_on(BUTTON_PKT_CHANNEL)>=MIN_ANALOG_VALUE),
										previousPktButtonValue);
		}else if(actionCounter==3){
			int currentKey = 0;
			if(!previousAwtButtonValue && awtButtonValue)
				currentKey = 1;
			else if(!previousLmaButtonValue && lmaButtonValue)
				currentKey = 2;
			else if(!previousPktButtonValue && pktButtonValue)
				currentKey = 3;
			if(currentKey!=0){
				if(currentKey == password[currentPasswordPos]){
					currentPasswordPos++;
					if(currentPasswordPos>=sizeof(password)/sizeof(*password)){
						success = true;
						break;
					}
				}else{
					break; //Wrong password. Going back to normal mode!
				}
			}
			previousAwtButtonValue = awtButtonValue;
			previousLmaButtonValue = lmaButtonValue;
			previousPktButtonValue = pktButtonValue;
		}else if(actionCounter==4){
			litLed(18);
		}else if(actionCounter==5){
			litLed(-1);
		}
		actionCounter++;
		if(actionCounter>=MIN_MAX_ACTION_COUNTER)
			actionCounter = 0;
		wfi(); //Frame-limiting with TIM4
	}
	if(!success)
		return false;

	//Wait until all keys are released
	while((analog_read_with_led_b_on(BUTTON_AWT_CHANNEL)>=MIN_ANALOG_VALUE) ||
		(analog_read_with_led_b_on(BUTTON_LMA_CHANNEL)>=MIN_ANALOG_VALUE) ||
		(analog_read_with_led_b_on(BUTTON_PKT_CHANNEL)>=MIN_ANALOG_VALUE));

	return true;
}

//Allows user to perform ADC value calibration, key testing and brightness adjustment.
//Normal users are not supposed to enter this mode.
//TODO: Substantial code duplication with normalMode(). Please fix that.
void factoryMode(void){
	uint16_t ledState = 0;
	uint8_t actionCounter = 0;
	uint8_t maxActionCounter = 255;

	//en/weka measurement handling
	uint16_t enWekaMeasurementCounter = 0;
	uint16_t enWekaMeasurementWaitCounter = 0;
	bool preventEnWekaMeasurement = false; //Implementation limitation: Doesn't work for non-target button groups for calibration scene.
	bool measuringEnWeka = false;
	bool previousWekaPosition = false;
	bool currentWekaPosition = false;
	struct DebouncedValueU8_3 debouncedValueEnWeka;

	//For calibration scene
	uint16_t recordedValue[5][9];
	uint8_t currentStep = 0;
	uint16_t recordedAnalogValue = 0;
	uint16_t calibrationTimeoutValue = 0;

	//For test scene (Key test/Brightness adjustment)
	uint8_t previousAwtButtonValue = 0;
	uint8_t previousLmaButtonValue = 0;
	uint8_t previousPktButtonValue = 0;
	bool brightnessAdjustmentMode = false;
	bool alaHeld = false; //If ala+lluka+tenpo are held, we toggle between key test and brightness adjustment scene.
	bool lukaHeld = false;
	bool tenpoHeld = false;

	while(true){
		//If there's no input at the first step for a while,
		//we let the user skip to the test scene without performing ADC value calibration
		if(currentStep==0){
			if(calibrationTimeoutValue++ >= TIME_FOR_CALIBRATION_TIMEOUT){
				//Leaves calibration scene and enter test scene.
				currentStep = 255;
				brightnessAdjustmentMode = false;
				maxActionCounter = EEPROM_BRIGHTNESS;
			}
		}

		//Lit up the LEDs
		if(actionCounter<16){
			litLed(((ledState&(1<<actionCounter))!=0)?actionCounter:-1);
		}else if(actionCounter==16){
			preventEnWekaMeasurement = false; //Allows en/weka measurement
			litLed(-1); //Turn off the LEDs so that we can perform input measurement.
		}

		if(currentStep!=255){
			//Analog calibration scene
			if(actionCounter==17){			
				//Reading control values
				uint8_t channels[3] = {BUTTON_AWT_CHANNEL, BUTTON_LMA_CHANNEL, BUTTON_PKT_CHANNEL};

				uint16_t analogValue = analog_read_with_led_b_on(channels[(currentStep%9)/3]);
				if(analogValue<MIN_ANALOG_VALUE){
					analogValue = 0;
					if(recordedAnalogValue!=0){ //It's a button release! We're saving the value and moving on
						//Saves the recorded value
						recordedValue[currentStep/9][currentStep%9] = recordedAnalogValue;
						recordedAnalogValue = 0;
						currentStep++;
						if(currentStep==45){
							//We've done calibrating! Let's do the calculation now!
							volatile uint16_t *eepromAddress[] = {&EEPROM_AWT_THRESHOLD, &EEPROM_LMA_THRESHOLD, &EEPROM_PKT_THRESHOLD};
							//For each of the button group (AWT, LMA, PKT):
							for(int i=0;i<3;i++){
								uint16_t averageValueOfButtons[3];
								//Calculate the average value of each button
								//For example, for AWT, the button would be ALA, WAN and TU.
								for(int k=0; k<3; k++){
									averageValueOfButtons[k] = 0;
									for(int j=0;j<5;j++)
										averageValueOfButtons[k] += recordedValue[j][i*3+k];
									averageValueOfButtons[k] /= 5;
								}

								//Calculate the threshold values based on the three average values.
								//After that, save the threshold values to EEPROM.
								uint8_t wekaOffset = currentWekaPosition?3:0;
								eeprom_unlock();
								//Button A threshold (ALA/LUKA/PANA)
								eepromAddress[i][0+wekaOffset] = (averageValueOfButtons[0]+averageValueOfButtons[1])/2;
								//Button B threshold (WAN/MUTE/KAMA)
								eepromAddress[i][1+wekaOffset] = (averageValueOfButtons[1]+averageValueOfButtons[2])/2;
								//Button C threshold (TU/ALI/TENPO)
								eepromAddress[i][2+wekaOffset] = (averageValueOfButtons[2]+MIN_ANALOG_VALUE)/2;
								eeprom_lock();
							}
							//Leave calibration scene and enter test scene
							currentStep = 255;
							brightnessAdjustmentMode = false;
							maxActionCounter = EEPROM_BRIGHTNESS;
						}
					}
				}else{
					if(recordedAnalogValue==0) //We have recorded a key press!
						recordedAnalogValue = analogValue; //Record the value of key press
					preventEnWekaMeasurement = true; //No measurement of en/weka is allowed while a button is being held
				}
				
				//Determine LED state
				if(currentStep<45){
					ledState = 0;
					ledState |= (1 << (currentStep%9));
					ledState |= (1 << (11 + currentStep/9));
				}
			}
		}else{
			//Test scene
			if(actionCounter==17){
				uint16_t awtValue = analog_read_with_led_b_on(BUTTON_AWT_CHANNEL);
				uint8_t awtState = button_read(awtValue, currentWekaPosition, &EEPROM_AWT_THRESHOLD);

				//Temporarily prevents performing measurement of en/weka if any button is held
				if(awtValue >= MIN_ANALOG_VALUE)
					preventEnWekaMeasurement = true;

				if(!awtState)
					alaHeld = false;
				if(!previousAwtButtonValue && awtState){
					switch(awtState){
						case 1: //ala: If ala, luka and tenpo are held, we toggle between brightness adjustment mode and input test mode
							alaHeld = true;
						break;
						case 2: //wan: -10 cycle period (brighter)
							if(brightnessAdjustmentMode){
								if(maxActionCounter>MIN_MAX_ACTION_COUNTER+10)
									maxActionCounter -= 10;
								else
									maxActionCounter = MIN_MAX_ACTION_COUNTER;
							}
						break;
						case 3: //tu: -1 cycle period (brighter)
							if(brightnessAdjustmentMode){
								if(maxActionCounter>MIN_MAX_ACTION_COUNTER)
									maxActionCounter--;
							}
						break;
					}
				}
				previousAwtButtonValue = awtState;
			}else if(actionCounter==18){
				uint16_t lmaValue = analog_read_with_led_b_on(BUTTON_LMA_CHANNEL);
				uint8_t lmaState = button_read(lmaValue, currentWekaPosition, &EEPROM_LMA_THRESHOLD);

				//Temporarily prevents performing measurement of en/weka if any button is held
				if(lmaValue>=MIN_ANALOG_VALUE)
					preventEnWekaMeasurement = true;

				if(!lmaState)
					lukaHeld = false;
				if(!previousLmaButtonValue && lmaState){
					switch(lmaState){
						case 1: //luka: If ala, luka and tenpo are held, we toggle between brightness adjustment mode and input test mode
							lukaHeld = true;
						break;
						case 2: //mute: +1 cycle period (dimmer)
							if(brightnessAdjustmentMode){
								if(maxActionCounter<255)
									maxActionCounter++;
							}
						break;
						case 3: //tu: +10 cycle period (dimmer)
							if(brightnessAdjustmentMode){
								if(maxActionCounter<255-10)
									maxActionCounter += 10;
								else
									maxActionCounter = 255;
							}
						break;
					}
				}
				previousLmaButtonValue = lmaState;
			}else if(actionCounter==19){
				uint16_t pktValue = analog_read_with_led_b_on(BUTTON_PKT_CHANNEL);
				uint8_t pktState = button_read(pktValue, currentWekaPosition, &EEPROM_PKT_THRESHOLD);
				//Temporarily prevents performing measurement of en/weka if any button is held
				if(pktValue>=MIN_ANALOG_VALUE)
					preventEnWekaMeasurement = true;

				if(!pktState)
					tenpoHeld = false;
				if(!previousPktButtonValue && pktState){
					switch(pktState){
						case 1: //pana: save brightness
							eeprom_unlock();
							EEPROM_BRIGHTNESS = maxActionCounter;
							eeprom_lock();
						break;
						case 2: //kama: load brightness
							maxActionCounter = EEPROM_BRIGHTNESS;
						break;
						case 3: //tenpo: If ala, luka and tenpo are held, we toggle between brightness adjustment mode and input test mode
							tenpoHeld = true;
						break;
					}
				}
				previousPktButtonValue = pktState;

				//Mode toggling detection
				if(alaHeld && lukaHeld && tenpoHeld){
					alaHeld = false;
					lukaHeld = false;
					tenpoHeld = false;
					brightnessAdjustmentMode = !brightnessAdjustmentMode;
				}

				//LED state update
				if(brightnessAdjustmentMode){
					ledState = convertValueToLedState(maxActionCounter);
				}else{
					ledState = 0;
					ledState |= (1 << previousAwtButtonValue);
					ledState |= (1 << (7+previousLmaButtonValue));
					ledState |= (1 << (11+previousPktButtonValue));
				}
			}
		}

		//Check if it's time to measure en/weka
		if(actionCounter==MIN_MAX_ACTION_COUNTER-1){
			if(enWekaMeasurementCounter>=EN_WEKA_DETECTION_FRAME){
				enWekaMeasurementCounter -= EN_WEKA_DETECTION_FRAME;
				enWekaMeasurementWaitCounter = 0;
				//Only perform the actual measurement if no button is being held
				if(!preventEnWekaMeasurement)
					measuringEnWeka = true;
			}
		}

		//Record the current weka position
		enWekaMeasurementCounter++;
		enWekaMeasurementWaitCounter++;
		if(actionCounter == maxActionCounter-1){
			//We have waited enough. Let's perform the measurement.
			if(measuringEnWeka && enWekaMeasurementWaitCounter>=EN_WEKA_WAIT_FRAME){
				currentWekaPosition = debounced_value_u8_3_push_value(&debouncedValueEnWeka, 
										!!(PORT(EN_WEKA_PORT, IDR)&EN_WEKA_PIN),
										previousWekaPosition);
				//en/weka slider had changed. We're going back to step 0.
				if(previousWekaPosition != currentWekaPosition){
					maxActionCounter = 255;
					recordedAnalogValue = 0;
					currentStep = 0;
					calibrationTimeoutValue = 0;
				}
				previousWekaPosition = currentWekaPosition;
				measuringEnWeka = false;
			}
		}

		//In case maxActionCounter (loaded from EEPROM_BRIGHTNESS) is too small,
		//we set it to MIN_MAX_ACTION_COUNTER so that our program won't break
		if(maxActionCounter < MIN_MAX_ACTION_COUNTER)
			maxActionCounter = MIN_MAX_ACTION_COUNTER;

		//actionCounter handling.
		actionCounter++;
		if(actionCounter>=maxActionCounter)
			actionCounter = 0;

		wfi(); //Frame-limiting
	}

}

//This mode contains the main loop.
//It contains everything during the normal operation
void normalMode(void){
	//State variables
	uint8_t actionCounter = 0; //determines if it's time to lit LED or handle input or idle
	uint8_t maxActionCounter = EEPROM_BRIGHTNESS; //Minimum value: MIN_MAX_ACTION_COUNTER (20)

	//LED variables
	uint16_t ledState = 0;
	int16_t currentValue = 0; //Current value shown on the calculator
	uint16_t blinkCounter = 0;

	//timer-related variables
	uint16_t timingCounter = 0;
	uint16_t maxTimingCounter = 0;
	int16_t timerStartValue = 0;
	bool timerEnded = false; //true if the timer has stopped. e.g. finished counting to 0, or the counter had reached the max value.
	int8_t timingMode = 0; //+1: count up mode; -1: count down mode

	//en/weka measurement handling
	uint16_t enWekaMeasurementCounter = 0; //determine when to detect "en/weka"
	uint16_t enWekaMeasurementWaitCounter = 0;
	bool preventEnWekaMeasurement = true; //If any button is held, temporarily prevent en/weka measurement
	bool measuringEnWeka = false; //If true, the entire actionCounter~maxActionCounter period would not do anything so that en/weka can be accurately measured. If we lit the LEDs in the same period as measurement of en/weka, it will cause problem when the supply voltage is high enough (e.g. 4.5V)
	bool previousWekaPosition = false;
	bool currentWekaPosition = false;
	struct DebouncedValueU8_3 debouncedValueEnWeka;

	//Variables for storing the state of the pressed AWT, LMA and PKT buttons.
	uint8_t previousAwtButtonValue = 0;
	uint8_t previousLmaButtonValue = 0;
	uint8_t previousPktButtonValue = 0;
	struct DebouncedValueU8_3 debouncedValueAwt;
	struct DebouncedValueU8_3 debouncedValueLma;
	struct DebouncedValueU8_3 debouncedValuePkt;

	//In case EEPROM_BRIGHTNESS is too small, we set it to MIN_MAX_ACTION_COUNTER so that our program won't break
	if(maxActionCounter<MIN_MAX_ACTION_COUNTER)
		maxActionCounter = MIN_MAX_ACTION_COUNTER;

	timer4TriggeredCount = 0;
    while(1) {
		//Sleep only if we have completed processing all "frames"
		if(timer4TriggeredCount==0)
			wfi();

		timer4TriggeredCount--;

		if(!measuringEnWeka){
			if(actionCounter<16){
				if(timerEnded&&(currentValue==MIN_VALUE||currentValue==MAX_VALUE))
					//Range: 17~20 for all lights up without "weka anu ala". Range 16~19 with "weka anu ala"
					litLed(blinkCounter>=TIMER_FREQ/2 ? -1 : (currentValue>0?17:16)+(actionCounter%4));
				else if(timerEnded&&currentValue==0)
					litLed(blinkCounter>=TIMER_FREQ/2 ? -1 : 0);
				else
					litLed(((ledState&(1<<actionCounter))!=0)?actionCounter:-1);
			}else if(actionCounter==16){
				preventEnWekaMeasurement = false; //Allows en/weka measurement
				litLed(-1); //Turn off the LEDs so that we can perform input measurement.
			}else if(actionCounter==17){
				uint16_t adcValue = analog_read_with_led_b_on(BUTTON_AWT_CHANNEL);
				uint8_t awtState = debounced_value_u8_3_push_value(&debouncedValueAwt, 
										button_read(adcValue, currentWekaPosition, &EEPROM_AWT_THRESHOLD),
										previousAwtButtonValue);

				//Temporarily prevents performing measurement of en/weka if any button is held
				if(adcValue>=MIN_ANALOG_VALUE)
					preventEnWekaMeasurement = true;

				if(!previousAwtButtonValue && awtState){
					switch(awtState){
						case 1: //ala: clear the value
							currentValue = 0;
							if(timingMode){
								timingMode = 0;
								timerEnded = false;
								currentValue = timerStartValue;
							}
						break;
						case 2: //wan
							if(!timingMode)
								currentValue += currentWekaPosition?-1:1;
						break;
						case 3: //tu
							if(!timingMode)
								currentValue += currentWekaPosition?-2:2;
						break;
					}
				}
				previousAwtButtonValue = awtState;
			}else if(actionCounter==18){
				uint16_t adcValue = analog_read_with_led_b_on(BUTTON_LMA_CHANNEL);
				uint8_t lmaState = debounced_value_u8_3_push_value(&debouncedValueLma, 
										button_read(adcValue, currentWekaPosition, &EEPROM_LMA_THRESHOLD),
										previousLmaButtonValue);

				//Temporarily prevents performing measurement of en/weka if any button is held
				if(adcValue>=MIN_ANALOG_VALUE)
					preventEnWekaMeasurement = true;

				if(!previousLmaButtonValue && lmaState){
					switch(lmaState){
						case 1: //luka
							if(!timingMode)
								currentValue += currentWekaPosition?-5:5;
						break;
						case 2: //mute
							if(!timingMode)
								currentValue += currentWekaPosition?-20:20;
						break;
						case 3: //ali
							if(!timingMode)
								currentValue += currentWekaPosition?-100:100;
						break;
					}
				}
				previousLmaButtonValue = lmaState;
			}else if(actionCounter==19){
				uint16_t adcValue = analog_read_with_led_b_on(BUTTON_PKT_CHANNEL);
				uint8_t pktState = debounced_value_u8_3_push_value(&debouncedValuePkt, 
										button_read(adcValue, currentWekaPosition, &EEPROM_PKT_THRESHOLD),
										previousPktButtonValue);

				//Temporarily prevents performing measurement of en/weka if any button is held
				if(adcValue>=MIN_ANALOG_VALUE)
					preventEnWekaMeasurement = true;

				if(!previousPktButtonValue && pktState){
					switch(pktState){
						case 1: //pana
							eeprom_unlock();
							EEPROM_SAVED_VALUE = currentValue;
							eeprom_lock();
						break;
						case 2: //kama: load saved value and add it the current value
							if(!timingMode)
								currentValue += currentWekaPosition?-EEPROM_SAVED_VALUE:EEPROM_SAVED_VALUE;
						break;
						case 3:
							timingCounter = 0;
							if(!timingMode){
								timerStartValue = currentValue;
								timingMode = currentWekaPosition?-1:1;
								
								//If we started counting at the min/max value, we stop the counting immediately
								if((timingMode<0 && timerStartValue==MIN_VALUE)
									|| timingMode>0 && timerStartValue==MAX_VALUE){
									timerEnded = true;
								}

								//We counts 20x faster if we're counting using negative number range
								if((timerStartValue<=0 && timingMode<0)
									|| (timerStartValue<0 && timingMode>0)){
									maxTimingCounter = TIMER_FREQ/20;
								}else{ //(timerStartValue>=0 && timingMode>0) || (timerStartValue>0 && timingMode<0)
									maxTimingCounter = TIMER_FREQ;
								}
							}else{
								if(currentValue==0)
									currentValue = timerStartValue;
								timingMode = 0;
								timerEnded = false;
							}
						break;
					}
				}
				previousPktButtonValue = pktState;

			}
		}

		//Check if it's time to measure en/weka
		if(actionCounter==MIN_MAX_ACTION_COUNTER-1){
			if(enWekaMeasurementCounter>=EN_WEKA_DETECTION_FRAME){
				enWekaMeasurementCounter -= EN_WEKA_DETECTION_FRAME;
				enWekaMeasurementWaitCounter = 0;
				//Only perform the actual measurement if no button is being held
				if(!preventEnWekaMeasurement)
					measuringEnWeka = true;
			}
		}

		//Record the current weka position
		enWekaMeasurementCounter++;
		enWekaMeasurementWaitCounter++;
		if(actionCounter == (timerEnded?MIN_MAX_ACTION_COUNTER:maxActionCounter)-1){
			//We have waited enough. Let's perform the measurement.
			if(measuringEnWeka && enWekaMeasurementWaitCounter>=EN_WEKA_WAIT_FRAME){
				currentWekaPosition = debounced_value_u8_3_push_value(&debouncedValueEnWeka, 
										!!(PORT(EN_WEKA_PORT, IDR)&EN_WEKA_PIN),
										previousWekaPosition);
				previousWekaPosition = currentWekaPosition;
				measuringEnWeka = false;
			}
		}

		//Handle timer modifying the time value
		if(timingMode && !timerEnded){
			timingCounter++;
			if(timingCounter>=maxTimingCounter){
				timingCounter = 0;
				currentValue += timingMode;
			}
			if(timerStartValue!=currentValue){
				if(currentValue==0||currentValue==MIN_VALUE||currentValue==MAX_VALUE)
					timerEnded = true;
			}
		}

		//Clamp the value of the calculation result
		if(currentValue>MAX_VALUE)
			currentValue = MAX_VALUE;
		if(currentValue<MIN_VALUE)
			currentValue = MIN_VALUE;

		//Perform conversion of value to LED state
		ledState = convertValueToLedState(currentValue);

		//actionCounter handling.
		actionCounter++;
		if((!timerEnded && actionCounter>=maxActionCounter)
			|| (timerEnded && actionCounter>=MIN_MAX_ACTION_COUNTER))
			actionCounter = 0;

		//blinkCounter handling (for blinking when the timer had finished counting)
		blinkCounter++;
		if(blinkCounter>=TIMER_FREQ)
			blinkCounter = 0;
    }
}

void safetyDelay(){
	for(uint8_t i=0; i<8; i++)
		for(uint8_t j=0; j<255; j++)
			for(uint8_t k=0; k<255; k++)
				nop();
}

void adc_init(void){
	// ADC initialization
    ADC_CSR = 0;
    ADC_CR1 = 0;
    ADC_CR2 = 0;
    ADC_CR3 = 0;

	ADC_TDRL = PIN2|PIN6; //Disable Schmitt triggers of channels to be used as recommended by the reference manual.
    ADC_CR1 |= 7<<4; //Sets SPSEL. Divides the ADC clock by 18.
    ADC_CR1 |= ADC_CR1_ADON; // Turn on the ADC
}

int main(void)
{
	//safetyDelay(); //Prevents SWIM pin lock-up
	

	//Setting the HSI clock to 16Mhz. 2Mhz simply isn't sufficient for our main loop!
    CLK_CKDIVR = 0;

    //Setup timer 4
    TIM4_PSCR = 7; // 16e6/(2**7)== 125000 Hz
    TIM4_ARR = 9; // TIM4_ARR=49. 125000/(9+1) = 12500Hz
    // TIM4_IER (Interrupt Enable Register), Update interrupt (UIE) (bit 0)
    TIM4_IER |= TIM_IER_UIE;
    // TIM4_CR1 – Timer 4 Control Register 1, Counter ENable bit (CEN) (bit 0)
    TIM4_CR1 |= TIM_CR1_CEN;

	adc_init();
	if(programmingMode()){
		disable_swim_and_disable_schmitt_trigger();
		if(passwordMode())
			factoryMode();
	}else{
		disable_swim_and_disable_schmitt_trigger();
	}

	normalMode();

	return 0; //Should never reach here.
}
