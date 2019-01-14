# Ilo Nanpa - Toki Pona Numeral Calculator

(sina sona e toki pona, la o tawa lipu [https://ilonanpa.sadale.net/](https://ilonanpa.sadale.net/). mi kepeken toki ike tan ni: nimi sona "Programming" li ike. toki ike Inli taso li lon lipu ni.)

Ilo Nanpa is a hardware calculator designed for Toki Pona Numeral. [Toki Pona](http://tokipona.org/) is a minimalist constructed language designed by jan Sonja with an obscure, non-base-10 numeral system.

This repository contains the source code of the firmware as well as the source files of hardware design. This readme file mainly describes the procedure of building the firmware as well as working with factory mode. For the usage of this device and other technical details, please refer to [the official English blogpost of Ilo Nanpa on sadale.net](https://sadale.net/58/).

# Repository Structure

* src/ - source code of the firmware
* pcb/ - KiCad hardware design files
* bin/ - Compiled source code (generated after running Makefile)

# Microcontroller

The microcontroller of this project is STM8S001J3.

# Dependencies

* Make (for Makefile)
* Compiler: sdcc
* Firmware uploading tool: stm8flash, to be used with stlinkv2.
* PCB Software: KiCad (for modification of hardware design. It isn't needed for firmware development)

# Building and Flashing the Firmware

* Run `make` to build the firmware.

* Connect stlink with Ilo Nanpa. On the backside of the device, there's a 3-pin male header on the top-left corner. The pin 1 is Vcc, pin 2 is ground and pin 3 is SWIM.

* Run `make flash-opt-bytes` to flash the option bytes (fusebit-like configuration). It maps ADC channel 2 to the ala-wan-tu button group. This operation only need to be performed once for each microcontroller. For some reason, the first run returns me an error. I have to run this command twice to get it work.

* Run `make flash` to upload the firmware to the microcontroller. For some reason, the first run of the command often fails. Perhaps it has something to do with clock configuration. I have to run this command twice to get it uploaded.

# Reprogramming the Device

To reprogram the device, hold the "pana" button before powering up the device. This prevents the device from leaving programming mode. As soon as "pana" is released, the device would leave programming mode and enter normal operation mode.

# Factory Mode

Due to the design of the device, ADC calibration procedure has to be performed for getting the button detection of the device work. This can be performed using factory mode. In addition, factory mode is able to perform key tests and LED brightness adjustment.

** If you're a holder of Ilo Nanpa and you have no idea on what this mode does, please do NOT enter factory mode. This mode would cause your device not to be able to properly detect key presses if it isn't used properly. **

Please ensure that you aren't touching any LEDs or resistors with your fingers during the process.

To enter factory mode:

1. Hold down the "ala" button and power the device on.

2. Wait for 5 seconds. The LEDs suno9,10,11,12 would turn on.

3. Press the buttons in the following sequence. ala, pana, luka, pana, ala, luka, luka, pana. If you press any of them wrong, the firmware would enter normal mode and would not enter factory mode.

4. Slide the en/weka slider switch to `en` position.

5. The LEDs suno1 and suno12 should light up. If suno8 is also lit, you're too slow and you have to slide the en/weka slider to `weka` position and back to `en` position again.

6. You're now in ADC calibration scene. Press the buttons in this sequence for 5 times: ala, wan, tu, luka, mute, ali, pana, kama, tenpo. This calibrates the ADC values when the slider is in `en` position. After this step, the ADC calibration values are saved to the EEPROM.

7. The LEDs suno1,8,12 should be lit. You've entered key test scene. The buttons are grouped as shown below:


	* suno1,2,3,4 <=> RELEASED,ala,wan,tu
	* suno8,9,10,11 <=> RELEASED,luka,mute,ali
	* suno12,13,14,15 <=> RELEASED,pana,kama,tenpo


	For example, when ala is pressed, suno2 would be lit. When wan is pressed, suno3 would be lit. When tu is pressed, suno4 would be lit. When none of ala, wan and tu is pressed, suno1 would be lit.

8. Repeat step 4 to 7, but with slider switch positioned at `weka` instead of `en`.

9. If you're in key test scene, you can enter brightness adjustment scene. To enter brightness adjustment scene, hold ala, luka and tenpo at the same time.

10. The higher the maxActionCount, the lower the brightness. In brightness adjustment scene, press wan to reduce maxActionCount by 10, tu to reduce maxActionCount by 1, mute to increase maxActionCount by 1, ali to increase maxActionCount by 10. The number shown on the LEDs is the current maxActionCount in Toki Pona Numeral.

11. To get back to key test scene from brightness adjustment scene, hold ala, luka and tenpo at the same time. To get back to ADC calibration scene, slide the slider switch in any scene.

# Working with Hardware Design
Just open up `pcb/ilonanpa.pro` with KiCad. The documentation of KiCad can be found on their website.

Please notice that unusual electronic designator is being used. Instead of R1, R2, R3 for resistors, we have awen1, awen2, awen3. It's designed in this way because this device is designed to have Toki Pona culture in mind. In case you're confused, please refer to the electronic symbol.

# License
This project is licensed under BSD 2-clause license.
