EESchema Schematic File Version 4
LIBS:pcb-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "ilo nanpa"
Date "2019-01-10"
Rev "1"
Comp "https://sadale.net"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L STM8S001J3:STM8S001J3 lawa1
U 1 1 5BF44A42
P 5850 3250
F 0 "lawa1" H 5850 3767 50  0000 C CNN
F 1 "STM8S001J3" H 5850 3676 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 5900 3850 50  0001 L CNN
F 3 "http://www.st.com/resource/en/datasheet/stm8af6223.pdf" H 5550 3450 50  0001 C CNN
	1    5850 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:C wawa2
U 1 1 5BF44AD2
P 4900 3150
F 0 "wawa2" H 4950 3250 50  0000 L CNN
F 1 "2u2" H 4950 3050 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 4938 3000 50  0001 C CNN
F 3 "~" H 4900 3150 50  0001 C CNN
	1    4900 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:C wawa1
U 1 1 5BF44B10
P 4550 3150
F 0 "wawa1" H 4600 3250 50  0000 L CNN
F 1 "100n" H 4600 3050 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 4588 3000 50  0001 C CNN
F 3 "~" H 4550 3150 50  0001 C CNN
	1    4550 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 3200 5250 3300
Wire Wire Line
	4300 3000 4300 3150
Wire Wire Line
	4300 3000 4550 3000
$Comp
L power:GND #PWR02
U 1 1 5BF44D93
P 4300 3150
F 0 "#PWR02" H 4300 2900 50  0001 C CNN
F 1 "GND" H 4305 2977 50  0000 C CNN
F 2 "" H 4300 3150 50  0001 C CNN
F 3 "" H 4300 3150 50  0001 C CNN
	1    4300 3150
	1    0    0    -1  
$EndComp
Connection ~ 4550 3000
Wire Wire Line
	4550 3000 4900 3000
Wire Wire Line
	4550 3400 4550 3300
Wire Wire Line
	4550 3400 5250 3400
Connection ~ 4900 3000
Wire Wire Line
	4900 3000 5250 3000
Wire Wire Line
	4900 3300 5250 3300
$Comp
L Device:R awen7
U 1 1 5BF6EF54
P 6650 2600
F 0 "awen7" V 6550 2600 50  0000 C CNN
F 1 "120" V 6750 2600 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6580 2600 50  0001 C CNN
F 3 "~" H 6650 2600 50  0001 C CNN
	1    6650 2600
	0    1    1    0   
$EndComp
Wire Wire Line
	6500 2600 6450 2600
Wire Wire Line
	6450 2600 6450 3000
$Comp
L Device:R awen8
U 1 1 5BF6FD3A
P 6650 2900
F 0 "awen8" V 6550 2900 50  0000 C CNN
F 1 "120" V 6750 2900 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6580 2900 50  0001 C CNN
F 3 "~" H 6650 2900 50  0001 C CNN
	1    6650 2900
	0    1    1    0   
$EndComp
Wire Wire Line
	6500 2900 6500 3100
Wire Wire Line
	6500 3100 6450 3100
$Comp
L Device:R awen9
U 1 1 5BF70C00
P 6650 3200
F 0 "awen9" V 6550 3200 50  0000 C CNN
F 1 "120" V 6750 3200 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6580 3200 50  0001 C CNN
F 3 "~" H 6650 3200 50  0001 C CNN
	1    6650 3200
	0    1    1    0   
$EndComp
Wire Wire Line
	6500 3200 6450 3200
$Comp
L Device:R awen10
U 1 1 5BF71BA9
P 6650 3500
F 0 "awen10" V 6550 3500 50  0000 C CNN
F 1 "120" V 6750 3500 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6580 3500 50  0001 C CNN
F 3 "~" H 6650 3500 50  0001 C CNN
	1    6650 3500
	0    1    1    0   
$EndComp
Wire Wire Line
	6450 3300 6500 3300
Wire Wire Line
	6500 3300 6500 3500
$Comp
L Device:R awen11
U 1 1 5BF72BA6
P 6650 3800
F 0 "awen11" V 6550 3800 50  0000 C CNN
F 1 "120" V 6750 3800 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6580 3800 50  0001 C CNN
F 3 "~" H 6650 3800 50  0001 C CNN
	1    6650 3800
	0    1    1    0   
$EndComp
Wire Wire Line
	6450 3400 6450 3800
Wire Wire Line
	6450 3800 6500 3800
$Comp
L power:VDD #PWR01
U 1 1 5BF74961
P 4100 3250
F 0 "#PWR01" H 4100 3100 50  0001 C CNN
F 1 "VDD" H 4117 3423 50  0000 C CNN
F 2 "" H 4100 3250 50  0001 C CNN
F 3 "" H 4100 3250 50  0001 C CNN
	1    4100 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 3400 4100 3400
Connection ~ 4550 3400
Wire Wire Line
	4100 3250 4100 3400
$Comp
L Switch:SW_SPDT nena-awen2
U 1 1 5BF7966E
P 9700 1000
F 0 "nena-awen2" H 9700 850 50  0000 C CNN
F 1 "ante wawa" H 9750 1200 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPDT_PCM12" H 9700 1000 50  0001 C CNN
F 3 "" H 9700 1000 50  0001 C CNN
	1    9700 1000
	-1   0    0    1   
$EndComp
$Comp
L Device:C wawa3
U 1 1 5BF7C036
P 9950 1150
F 0 "wawa3" H 10065 1196 50  0000 L CNN
F 1 "10u" H 10000 1050 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9988 1000 50  0001 C CNN
F 3 "~" H 9950 1150 50  0001 C CNN
	1    9950 1150
	1    0    0    -1  
$EndComp
Wire Wire Line
	9900 1000 9950 1000
Wire Wire Line
	9950 1000 10100 1000
Connection ~ 9950 1000
$Comp
L power:GND #PWR015
U 1 1 5BF7E7BE
P 9950 1300
F 0 "#PWR015" H 9950 1050 50  0001 C CNN
F 1 "GND" H 9955 1127 50  0000 C CNN
F 2 "" H 9950 1300 50  0001 C CNN
F 3 "" H 9950 1300 50  0001 C CNN
	1    9950 1300
	1    0    0    -1  
$EndComp
$Comp
L Connector:USB_B_Micro lupa-wawa1
U 1 1 5BF7EAEA
P 8700 1400
F 0 "lupa-wawa1" H 8755 1867 50  0000 C CNN
F 1 "USB_B_Micro" H 8755 1776 50  0000 C CNN
F 2 "USB_Micro_B:USB_Micro-B_A01SB141B1-067" H 8850 1350 50  0001 C CNN
F 3 "~" H 8850 1350 50  0001 C CNN
	1    8700 1400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR011
U 1 1 5BF7EB5A
P 8600 1800
F 0 "#PWR011" H 8600 1550 50  0001 C CNN
F 1 "GND" H 8605 1627 50  0000 C CNN
F 2 "" H 8600 1800 50  0001 C CNN
F 3 "" H 8600 1800 50  0001 C CNN
	1    8600 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8700 1800 8600 1800
Connection ~ 8600 1800
NoConn ~ 9000 1600
NoConn ~ 9000 1500
NoConn ~ 9000 1400
Wire Wire Line
	9500 1100 9200 1100
$Comp
L Device:Battery poki-pi-palisa-wawa1
U 1 1 5BF88B08
P 9200 1600
F 0 "poki-pi-palisa-wawa1" H 9308 1646 50  0000 L CNN
F 1 "wawa palisa \"AAA\" tu wan" H 9308 1555 50  0000 L CNN
F 2 "Connector_PinHeader_1.27mm:PinHeader_1x02_P1.27mm_Vertical" V 9200 1660 50  0001 C CNN
F 3 "~" V 9200 1660 50  0001 C CNN
	1    9200 1600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR014
U 1 1 5BF88BC2
P 9200 1800
F 0 "#PWR014" H 9200 1550 50  0001 C CNN
F 1 "GND" H 9205 1627 50  0000 C CNN
F 2 "" H 9200 1800 50  0001 C CNN
F 3 "" H 9200 1800 50  0001 C CNN
	1    9200 1800
	1    0    0    -1  
$EndComp
$Comp
L Device:LED suno2
U 1 1 5BF93E05
P 7300 2900
F 0 "suno2" V 7338 2782 50  0000 R CNN
F 1 "wan" V 7247 2782 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7300 2900 50  0001 C CNN
F 3 "~" H 7300 2900 50  0001 C CNN
	1    7300 2900
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED suno1
U 1 1 5BF93EC3
P 6900 2750
F 0 "suno1" V 6938 2633 50  0000 R CNN
F 1 "weka anu ala" V 6847 2633 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6900 2750 50  0001 C CNN
F 3 "~" H 6900 2750 50  0001 C CNN
	1    6900 2750
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7300 2750 7300 2600
Wire Wire Line
	7300 2600 6900 2600
Wire Wire Line
	6800 2600 6900 2600
Connection ~ 6900 2600
Wire Wire Line
	6800 2900 6900 2900
Wire Wire Line
	7300 3050 7300 3200
$Comp
L Device:LED suno3
U 1 1 5BF9A573
P 7700 3100
F 0 "suno3" V 7738 2983 50  0000 R CNN
F 1 "tu" V 7647 2983 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7700 3100 50  0001 C CNN
F 3 "~" H 7700 3100 50  0001 C CNN
	1    7700 3100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7300 2600 7700 2600
Wire Wire Line
	7700 2600 7700 2950
Connection ~ 7300 2600
$Comp
L Device:LED suno4
U 1 1 5BF9FBD2
P 8100 3200
F 0 "suno4" V 8138 3083 50  0000 R CNN
F 1 "tu" V 8047 3083 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 8100 3200 50  0001 C CNN
F 3 "~" H 8100 3200 50  0001 C CNN
	1    8100 3200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7700 2600 8100 2600
Connection ~ 7700 2600
Wire Wire Line
	8100 3350 8100 3800
Wire Wire Line
	6900 2900 8550 2900
Connection ~ 6900 2900
Connection ~ 8100 3800
Wire Wire Line
	8100 2600 8100 3050
$Comp
L Device:LED suno5
U 1 1 5BFC8840
P 8550 2750
F 0 "suno5" V 8495 2828 50  0000 L CNN
F 1 "luka" V 8586 2828 50  0000 L CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 8550 2750 50  0001 C CNN
F 3 "~" H 8550 2750 50  0001 C CNN
	1    8550 2750
	0    1    1    0   
$EndComp
Wire Wire Line
	8550 2600 8100 2600
Connection ~ 8100 2600
$Comp
L Device:LED suno6
U 1 1 5BFCAAD6
P 6900 3050
F 0 "suno6" V 6938 2933 50  0000 R CNN
F 1 "luka" V 6847 2933 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6900 3050 50  0001 C CNN
F 3 "~" H 6900 3050 50  0001 C CNN
	1    6900 3050
	0    -1   -1   0   
$EndComp
Connection ~ 6900 3200
Wire Wire Line
	6900 3200 6800 3200
Wire Wire Line
	7300 3200 6900 3200
Wire Wire Line
	8550 2900 8900 2900
Connection ~ 8550 2900
$Comp
L Device:LED suno7
U 1 1 5BFD15BA
P 8550 3200
F 0 "suno7" V 8588 3083 50  0000 R CNN
F 1 "luka" V 8497 3083 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 8550 3200 50  0001 C CNN
F 3 "~" H 8550 3200 50  0001 C CNN
	1    8550 3200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8550 2900 8550 3050
Wire Wire Line
	8550 3350 8550 3500
Connection ~ 8550 3500
$Comp
L Device:LED suno8
U 1 1 5BFD8304
P 8900 3400
F 0 "suno8" V 8938 3283 50  0000 R CNN
F 1 "mute" V 8847 3283 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 8900 3400 50  0001 C CNN
F 3 "~" H 8900 3400 50  0001 C CNN
	1    8900 3400
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8900 3550 8900 3800
Wire Wire Line
	8100 3800 8900 3800
Connection ~ 8900 2900
$Comp
L Device:LED suno11
U 1 1 5BFE475A
P 6900 3350
F 0 "suno11" V 6845 3429 50  0000 L CNN
F 1 "mute" V 6936 3429 50  0000 L CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6900 3350 50  0001 C CNN
F 3 "~" H 6900 3350 50  0001 C CNN
	1    6900 3350
	0    1    1    0   
$EndComp
Connection ~ 6900 3500
Wire Wire Line
	6900 3500 6800 3500
$Comp
L Device:LED suno12
U 1 1 5BFE481A
P 6900 3650
F 0 "suno12" V 6938 3532 50  0000 R CNN
F 1 "ali" V 6847 3532 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6900 3650 50  0001 C CNN
F 3 "~" H 6900 3650 50  0001 C CNN
	1    6900 3650
	0    -1   -1   0   
$EndComp
Connection ~ 6900 3800
Wire Wire Line
	6900 3800 6800 3800
$Comp
L Device:LED suno9
U 1 1 5BFE9C9F
P 9250 2950
F 0 "suno9" V 9195 3029 50  0000 L CNN
F 1 "mute" V 9286 3029 50  0000 L CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9250 2950 50  0001 C CNN
F 3 "~" H 9250 2950 50  0001 C CNN
	1    9250 2950
	0    1    1    0   
$EndComp
$Comp
L Device:LED suno10
U 1 1 5BFE9D0B
P 9650 3200
F 0 "suno10" V 9595 3279 50  0000 L CNN
F 1 "mute" V 9686 3279 50  0000 L CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9650 3200 50  0001 C CNN
F 3 "~" H 9650 3200 50  0001 C CNN
	1    9650 3200
	0    1    1    0   
$EndComp
Wire Wire Line
	9650 3500 9650 3350
Wire Wire Line
	8550 3500 9250 3500
Wire Wire Line
	9650 3050 9650 2900
Wire Wire Line
	8900 2900 9650 2900
Wire Wire Line
	9250 2800 9250 2600
Wire Wire Line
	9250 2600 8550 2600
Connection ~ 8550 2600
Wire Wire Line
	9250 3100 9250 3500
Connection ~ 9250 3500
Wire Wire Line
	9250 3500 9650 3500
$Comp
L Device:LED suno15
U 1 1 5BFF9EA9
P 7300 3500
F 0 "suno15" V 7245 3579 50  0000 L CNN
F 1 "ali ali ali ali ali" V 7336 3579 50  0000 L CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7300 3500 50  0001 C CNN
F 3 "~" H 7300 3500 50  0001 C CNN
	1    7300 3500
	0    1    1    0   
$EndComp
$Comp
L Device:LED suno16
U 1 1 5BFF9F15
P 9650 3650
F 0 "suno16" V 9595 3729 50  0000 L CNN
F 1 "ali ali ali ali ali" V 9686 3729 50  0000 L CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9650 3650 50  0001 C CNN
F 3 "~" H 9650 3650 50  0001 C CNN
	1    9650 3650
	0    1    1    0   
$EndComp
Wire Wire Line
	7300 3650 7300 3800
Wire Wire Line
	8900 2900 8900 3250
Connection ~ 7300 3800
Wire Wire Line
	7300 3800 6900 3800
Wire Wire Line
	7300 3350 7300 3200
Connection ~ 7300 3200
$Comp
L Device:LED suno14
U 1 1 5BFFF9CB
P 10050 3200
F 0 "suno14" V 9995 3279 50  0000 L CNN
F 1 "ali ali" V 10086 3279 50  0000 L CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 10050 3200 50  0001 C CNN
F 3 "~" H 10050 3200 50  0001 C CNN
	1    10050 3200
	0    1    1    0   
$EndComp
Wire Wire Line
	9650 2900 10050 2900
Wire Wire Line
	10050 2900 10050 3050
Connection ~ 9650 2900
Wire Wire Line
	10050 3350 10050 3800
Wire Wire Line
	10050 3800 9650 3800
Connection ~ 8900 3800
$Comp
L Device:LED suno13
U 1 1 5C005AA0
P 10400 3200
F 0 "suno13" V 10345 3279 50  0000 L CNN
F 1 "ali ali" V 10436 3279 50  0000 L CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 10400 3200 50  0001 C CNN
F 3 "~" H 10400 3200 50  0001 C CNN
	1    10400 3200
	0    1    1    0   
$EndComp
Wire Wire Line
	10400 3350 10400 3800
Wire Wire Line
	10400 3800 10050 3800
Connection ~ 10050 3800
Wire Wire Line
	10400 3050 10400 2600
Wire Wire Line
	10400 2600 9250 2600
Connection ~ 9250 2600
Connection ~ 9650 3500
Connection ~ 9650 3800
Wire Wire Line
	9650 3800 8900 3800
Wire Wire Line
	6900 3500 7700 3500
Wire Wire Line
	7300 3800 8100 3800
Wire Wire Line
	7700 3250 7700 3500
Connection ~ 7700 3500
Wire Wire Line
	7700 3500 8550 3500
Wire Wire Line
	9200 1100 9200 1200
$Comp
L Switch:SW_Push nena1
U 1 1 5C01CB78
P 5550 4800
F 0 "nena1" H 5550 5085 50  0000 C CNN
F 1 "ala" H 5550 4994 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 5550 5000 50  0001 C CNN
F 3 "" H 5550 5000 50  0001 C CNN
	1    5550 4800
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_SPDT nena-awen1
U 1 1 5C01CD5A
P 4750 4900
F 0 "nena-awen1" H 4700 4750 50  0000 C CNN
F 1 "en anu weka" H 4550 5000 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPDT_PCM12" H 4750 4900 50  0001 C CNN
F 3 "" H 4750 4900 50  0001 C CNN
	1    4750 4900
	-1   0    0    1   
$EndComp
$Comp
L Switch:SW_Push nena2
U 1 1 5C01E428
P 6100 4800
F 0 "nena2" H 6100 5085 50  0000 C CNN
F 1 "wan" H 6100 4994 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 6100 5000 50  0001 C CNN
F 3 "" H 6100 5000 50  0001 C CNN
	1    6100 4800
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push nena3
U 1 1 5C01E48C
P 6650 4800
F 0 "nena3" H 6650 5085 50  0000 C CNN
F 1 "tu" H 6650 4994 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 6650 5000 50  0001 C CNN
F 3 "" H 6650 5000 50  0001 C CNN
	1    6650 4800
	1    0    0    -1  
$EndComp
$Comp
L power:VDD #PWR016
U 1 1 5C01E927
P 10100 900
F 0 "#PWR016" H 10100 750 50  0001 C CNN
F 1 "VDD" H 10117 1073 50  0000 C CNN
F 2 "" H 10100 900 50  0001 C CNN
F 3 "" H 10100 900 50  0001 C CNN
	1    10100 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	10100 900  10100 1000
Text Label 7300 3200 0    50   ~ 0
PB4
Text Label 4950 4900 0    50   ~ 0
PB5
Text Label 9650 3500 0    50   ~ 0
AIN2
Text Label 10400 3800 0    50   ~ 0
AIN4,5
Text Label 10400 2600 0    50   ~ 0
AIN6
$Comp
L power:VDD #PWR05
U 1 1 5C029466
P 5050 4350
F 0 "#PWR05" H 5050 4200 50  0001 C CNN
F 1 "VDD" H 5067 4523 50  0000 C CNN
F 2 "" H 5050 4350 50  0001 C CNN
F 3 "" H 5050 4350 50  0001 C CNN
	1    5050 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 4350 5350 4800
Wire Wire Line
	5350 4350 5900 4350
Wire Wire Line
	5900 4350 5900 4800
Connection ~ 5350 4350
Wire Wire Line
	5900 4350 6450 4350
Wire Wire Line
	6450 4350 6450 4800
Connection ~ 5900 4350
$Comp
L Device:R awen5
U 1 1 5C0344F5
P 6050 5100
F 0 "awen5" V 5950 5100 50  0000 C CNN
F 1 "20k" V 6150 5100 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5980 5100 50  0001 C CNN
F 3 "~" H 6050 5100 50  0001 C CNN
	1    6050 5100
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR06
U 1 1 5C039B8B
P 5250 5150
F 0 "#PWR06" H 5250 4900 50  0001 C CNN
F 1 "GND" H 5255 4977 50  0000 C CNN
F 2 "" H 5250 5150 50  0001 C CNN
F 3 "" H 5250 5150 50  0001 C CNN
	1    5250 5150
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push nena4
U 1 1 5C043A32
P 7350 4800
F 0 "nena4" H 7350 5085 50  0000 C CNN
F 1 "luka" H 7350 4994 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 7350 5000 50  0001 C CNN
F 3 "" H 7350 5000 50  0001 C CNN
	1    7350 4800
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push nena5
U 1 1 5C043A39
P 7900 4800
F 0 "nena5" H 7900 5085 50  0000 C CNN
F 1 "mute" H 7900 4994 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 7900 5000 50  0001 C CNN
F 3 "" H 7900 5000 50  0001 C CNN
	1    7900 4800
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push nena6
U 1 1 5C043A40
P 8450 4800
F 0 "nena6" H 8450 5085 50  0000 C CNN
F 1 "ali" H 8450 4994 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 8450 5000 50  0001 C CNN
F 3 "" H 8450 5000 50  0001 C CNN
	1    8450 4800
	1    0    0    -1  
$EndComp
$Comp
L power:VDD #PWR07
U 1 1 5C043A47
P 6850 4350
F 0 "#PWR07" H 6850 4200 50  0001 C CNN
F 1 "VDD" H 6867 4523 50  0000 C CNN
F 2 "" H 6850 4350 50  0001 C CNN
F 3 "" H 6850 4350 50  0001 C CNN
	1    6850 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	7150 4350 7150 4800
Wire Wire Line
	7150 4350 7700 4350
Wire Wire Line
	7700 4350 7700 4800
Connection ~ 7150 4350
Wire Wire Line
	7700 4350 8250 4350
Wire Wire Line
	8250 4350 8250 4800
Connection ~ 7700 4350
$Comp
L Device:R awen14
U 1 1 5C043A64
P 7850 5100
F 0 "awen14" V 7750 5100 50  0000 C CNN
F 1 "20k" V 7950 5100 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 7780 5100 50  0001 C CNN
F 3 "~" H 7850 5100 50  0001 C CNN
	1    7850 5100
	0    -1   -1   0   
$EndComp
$Comp
L Device:R awen13
U 1 1 5C043A6E
P 7300 5100
F 0 "awen13" V 7200 5100 50  0000 C CNN
F 1 "470k" V 7400 5100 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 7230 5100 50  0001 C CNN
F 3 "~" H 7300 5100 50  0001 C CNN
	1    7300 5100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7150 5100 7050 5100
Wire Wire Line
	7050 5100 7050 5150
$Comp
L Switch:SW_Push nena7
U 1 1 5C0496A3
P 9150 4800
F 0 "nena7" H 9150 5085 50  0000 C CNN
F 1 "pana" H 9150 4994 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 9150 5000 50  0001 C CNN
F 3 "" H 9150 5000 50  0001 C CNN
	1    9150 4800
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push nena8
U 1 1 5C0496AA
P 9700 4800
F 0 "nena8" H 9700 5085 50  0000 C CNN
F 1 "kama" H 9700 4994 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 9700 5000 50  0001 C CNN
F 3 "" H 9700 5000 50  0001 C CNN
	1    9700 4800
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push nena9
U 1 1 5C0496B1
P 10250 4800
F 0 "nena9" H 10250 5085 50  0000 C CNN
F 1 "tenpo" H 10250 4994 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_PTS645" H 10250 5000 50  0001 C CNN
F 3 "" H 10250 5000 50  0001 C CNN
	1    10250 4800
	1    0    0    -1  
$EndComp
$Comp
L power:VDD #PWR012
U 1 1 5C0496B8
P 8650 4350
F 0 "#PWR012" H 8650 4200 50  0001 C CNN
F 1 "VDD" H 8667 4523 50  0000 C CNN
F 2 "" H 8650 4350 50  0001 C CNN
F 3 "" H 8650 4350 50  0001 C CNN
	1    8650 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	8950 4350 8950 4800
Wire Wire Line
	8950 4350 9500 4350
Wire Wire Line
	9500 4350 9500 4800
Connection ~ 8950 4350
Wire Wire Line
	9500 4350 10050 4350
Wire Wire Line
	10050 4350 10050 4800
Connection ~ 9500 4350
$Comp
L Device:R awen18
U 1 1 5C0496D5
P 9650 5100
F 0 "awen18" V 9550 5100 50  0000 C CNN
F 1 "20k" V 9750 5100 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9580 5100 50  0001 C CNN
F 3 "~" H 9650 5100 50  0001 C CNN
	1    9650 5100
	0    -1   -1   0   
$EndComp
$Comp
L Device:R awen17
U 1 1 5C0496DF
P 9100 5100
F 0 "awen17" V 9000 5100 50  0000 C CNN
F 1 "470k" V 9200 5100 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9030 5100 50  0001 C CNN
F 3 "~" H 9100 5100 50  0001 C CNN
	1    9100 5100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8950 5100 8850 5100
Wire Wire Line
	8850 5100 8850 5150
Wire Wire Line
	9000 1200 9000 900 
Wire Wire Line
	9000 900  9100 900 
Wire Wire Line
	5750 5100 5750 5300
Text Label 7800 5300 2    50   ~ 0
AIN4,5
Wire Wire Line
	4550 4800 4400 4800
Wire Wire Line
	4550 5000 4400 5000
$Comp
L power:GND #PWR04
U 1 1 5C0266C7
P 4400 5350
F 0 "#PWR04" H 4400 5100 50  0001 C CNN
F 1 "GND" H 4405 5177 50  0000 C CNN
F 2 "" H 4400 5350 50  0001 C CNN
F 3 "" H 4400 5350 50  0001 C CNN
	1    4400 5350
	1    0    0    -1  
$EndComp
$Comp
L power:VDD #PWR03
U 1 1 5C02667C
P 4400 4450
F 0 "#PWR03" H 4400 4300 50  0001 C CNN
F 1 "VDD" H 4417 4623 50  0000 C CNN
F 2 "" H 4400 4450 50  0001 C CNN
F 3 "" H 4400 4450 50  0001 C CNN
	1    4400 4450
	1    0    0    -1  
$EndComp
Text Label 9550 5300 2    50   ~ 0
AIN6
Text Notes 4200 4100 0    50   ~ 0
Although this circuit would cause the state of the analog pins no longer be floating, the pull down resistor is far larger than those LED current limiting resistor.\nSo it does not affect the lighting of LEDs.            sitelen ni li ike. taso suno li ken pali.
Wire Notes Line
	4150 3950 10750 3950
Wire Notes Line
	10750 3950 10750 5700
Wire Notes Line
	10750 5700 4150 5700
Wire Notes Line
	4150 5700 4150 3950
$Comp
L power:GND #PWR013
U 1 1 5BF799BE
P 8850 5150
F 0 "#PWR013" H 8850 4900 50  0001 C CNN
F 1 "GND" H 8855 4977 50  0000 C CNN
F 2 "" H 8850 5150 50  0001 C CNN
F 3 "" H 8850 5150 50  0001 C CNN
	1    8850 5150
	1    0    0    -1  
$EndComp
$Comp
L Device:R awen12
U 1 1 5BF799C4
P 7000 4350
F 0 "awen12" V 6900 4350 50  0000 C CNN
F 1 "10k" V 7100 4350 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6930 4350 50  0001 C CNN
F 3 "~" H 7000 4350 50  0001 C CNN
	1    7000 4350
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR08
U 1 1 5C043A77
P 7050 5150
F 0 "#PWR08" H 7050 4900 50  0001 C CNN
F 1 "GND" H 7055 4977 50  0000 C CNN
F 2 "" H 7050 5150 50  0001 C CNN
F 3 "" H 7050 5150 50  0001 C CNN
	1    7050 5150
	1    0    0    -1  
$EndComp
$Comp
L Device:R awen1
U 1 1 5BF8E00C
P 4400 4600
F 0 "awen1" V 4300 4600 50  0000 C CNN
F 1 "470k" V 4500 4600 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4330 4600 50  0001 C CNN
F 3 "~" H 4400 4600 50  0001 C CNN
	1    4400 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 4750 4400 4800
$Comp
L Device:R awen2
U 1 1 5BF956FC
P 4400 5200
F 0 "awen2" V 4300 5200 50  0000 C CNN
F 1 "470k" V 4500 5200 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4330 5200 50  0001 C CNN
F 3 "~" H 4400 5200 50  0001 C CNN
	1    4400 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 5000 4400 5050
Text Notes 3800 2450 0    50   ~ 0
Assumption: LED forward voltage > 0.95.\nMath: 120R±5% means 108R at minimum.\n5.25 is the max USB voltage. 0.02A is max curent per pin.\nWith (5.25-Vf)/(108*2) = 0.2\nwe get Vf = 0.95\n\nilo awen "120R" li lon la ilo lawa li pana e wawa lili li pakala ala.
$Comp
L Connector:TestPoint oko3
U 1 1 5BFB78A4
P 4300 3000
F 0 "oko3" H 4350 3150 50  0000 L CNN
F 1 "oko" H 4350 3050 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 4500 3000 50  0001 C CNN
F 3 "~" H 4500 3000 50  0001 C CNN
	1    4300 3000
	1    0    0    -1  
$EndComp
Connection ~ 4300 3000
$Comp
L Connector:TestPoint oko1
U 1 1 5BFB7B52
P 3750 3350
F 0 "oko1" H 3800 3500 50  0000 L CNN
F 1 "oko" H 3800 3400 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 3950 3350 50  0001 C CNN
F 3 "~" H 3950 3350 50  0001 C CNN
	1    3750 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 3350 3750 3400
Wire Wire Line
	3750 3400 4100 3400
Connection ~ 4100 3400
$Comp
L Connector:TestPoint oko7
U 1 1 5BFCD8FF
P 5050 3750
F 0 "oko7" H 5100 3900 50  0000 L CNN
F 1 "oko" H 5100 3800 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 5250 3750 50  0001 C CNN
F 3 "~" H 5250 3750 50  0001 C CNN
	1    5050 3750
	1    0    0    -1  
$EndComp
Text Label 6450 3100 0    50   ~ 0
5
Text Label 6450 2900 2    50   ~ 0
1
Text Label 6450 3200 0    50   ~ 0
6
Text Label 6450 3300 0    50   ~ 0
7
Text Label 6450 3400 0    50   ~ 0
8
Text Label 5050 3750 2    50   ~ 0
5
$Comp
L Connector:TestPoint oko8
U 1 1 5BFD6619
P 5400 3750
F 0 "oko8" H 5450 3900 50  0000 L CNN
F 1 "oko" H 5450 3800 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 5600 3750 50  0001 C CNN
F 3 "~" H 5600 3750 50  0001 C CNN
	1    5400 3750
	1    0    0    -1  
$EndComp
Text Label 5400 3750 2    50   ~ 0
6
$Comp
L Connector:TestPoint oko9
U 1 1 5BFDA331
P 5750 3750
F 0 "oko9" H 5800 3900 50  0000 L CNN
F 1 "oko" H 5800 3800 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 5950 3750 50  0001 C CNN
F 3 "~" H 5950 3750 50  0001 C CNN
	1    5750 3750
	1    0    0    -1  
$EndComp
Text Label 5750 3750 2    50   ~ 0
7
$Comp
L Connector:TestPoint oko11
U 1 1 5BFDE033
P 6100 3750
F 0 "oko11" H 6150 3900 50  0000 L CNN
F 1 "oko" H 6150 3800 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 6300 3750 50  0001 C CNN
F 3 "~" H 6300 3750 50  0001 C CNN
	1    6100 3750
	1    0    0    -1  
$EndComp
Text Label 6100 3750 2    50   ~ 0
8
$Comp
L Connector:TestPoint oko5
U 1 1 5BFE1D97
P 4700 3750
F 0 "oko5" H 4750 3900 50  0000 L CNN
F 1 "oko" H 4750 3800 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 4900 3750 50  0001 C CNN
F 3 "~" H 4900 3750 50  0001 C CNN
	1    4700 3750
	1    0    0    -1  
$EndComp
Text Label 4700 3750 2    50   ~ 0
1
$Comp
L Connector:TestPoint oko6
U 1 1 5BFF5C77
P 5050 2850
F 0 "oko6" H 5100 3000 50  0000 L CNN
F 1 "oko" H 5100 2900 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 5250 2850 50  0001 C CNN
F 3 "~" H 5250 2850 50  0001 C CNN
	1    5050 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 2850 5050 2900
Wire Wire Line
	5050 2900 5250 2900
Connection ~ 5250 3200
Wire Wire Line
	5250 2900 5250 3200
$Comp
L Connector:TestPoint oko21
U 1 1 5BFFE90E
P 9100 900
F 0 "oko21" H 9150 1050 50  0000 L CNN
F 1 "oko" H 9150 950 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 9300 900 50  0001 C CNN
F 3 "~" H 9300 900 50  0001 C CNN
	1    9100 900 
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint oko22
U 1 1 5C006E23
P 9200 1200
F 0 "oko22" H 9250 1300 50  0000 L CNN
F 1 "oko" H 9250 1400 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 9400 1200 50  0001 C CNN
F 3 "~" H 9400 1200 50  0001 C CNN
	1    9200 1200
	0    1    1    0   
$EndComp
Connection ~ 9200 1200
Wire Wire Line
	9200 1200 9200 1400
Text Label 6800 2600 0    50   ~ 0
A
Text Label 6800 2900 0    50   ~ 0
B
Text Label 7200 3200 0    50   ~ 0
C
Text Label 6800 3500 0    50   ~ 0
D
Text Label 6800 3800 0    50   ~ 0
E
$Comp
L Connector:TestPoint oko17
U 1 1 5C01D2D1
P 8200 2450
F 0 "oko17" H 8250 2600 50  0000 L CNN
F 1 "oko" H 8250 2500 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 8400 2450 50  0001 C CNN
F 3 "~" H 8400 2450 50  0001 C CNN
	1    8200 2450
	1    0    0    -1  
$EndComp
Text Label 8200 2450 2    50   ~ 0
B
$Comp
L Connector:TestPoint oko18
U 1 1 5C01D2D9
P 8550 2450
F 0 "oko18" H 8600 2600 50  0000 L CNN
F 1 "oko" H 8600 2500 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 8750 2450 50  0001 C CNN
F 3 "~" H 8750 2450 50  0001 C CNN
	1    8550 2450
	1    0    0    -1  
$EndComp
Text Label 8550 2450 2    50   ~ 0
C
$Comp
L Connector:TestPoint oko20
U 1 1 5C01D2E1
P 8900 2450
F 0 "oko20" H 8950 2600 50  0000 L CNN
F 1 "oko" H 8950 2500 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 9100 2450 50  0001 C CNN
F 3 "~" H 9100 2450 50  0001 C CNN
	1    8900 2450
	1    0    0    -1  
$EndComp
Text Label 8900 2450 2    50   ~ 0
D
$Comp
L Connector:TestPoint oko23
U 1 1 5C01D2E9
P 9250 2450
F 0 "oko23" H 9300 2600 50  0000 L CNN
F 1 "oko" H 9300 2500 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 9450 2450 50  0001 C CNN
F 3 "~" H 9450 2450 50  0001 C CNN
	1    9250 2450
	1    0    0    -1  
$EndComp
Text Label 9250 2450 2    50   ~ 0
E
$Comp
L Connector:TestPoint oko15
U 1 1 5C01D2F1
P 7850 2450
F 0 "oko15" H 7900 2600 50  0000 L CNN
F 1 "oko" H 7900 2500 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 8050 2450 50  0001 C CNN
F 3 "~" H 8050 2450 50  0001 C CNN
	1    7850 2450
	1    0    0    -1  
$EndComp
Text Label 7850 2450 2    50   ~ 0
A
$Comp
L Device:R awen3
U 1 1 5C03310C
P 5200 4350
F 0 "awen3" V 5100 4350 50  0000 C CNN
F 1 "10k" V 5300 4350 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5130 4350 50  0001 C CNN
F 3 "~" H 5200 4350 50  0001 C CNN
	1    5200 4350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6200 5100 6300 5100
Wire Wire Line
	6850 4800 6850 5100
Wire Wire Line
	6300 4800 6300 5100
Connection ~ 6300 5100
Wire Wire Line
	6300 5100 6400 5100
Wire Wire Line
	5750 4800 5750 5100
Connection ~ 5750 5100
Wire Wire Line
	5750 5100 5900 5100
Wire Wire Line
	7450 5100 7550 5100
Wire Wire Line
	8650 4800 8650 5100
Wire Wire Line
	7550 5100 7550 5300
Wire Wire Line
	8100 4800 8100 5100
Wire Wire Line
	8000 5100 8100 5100
Connection ~ 8100 5100
Wire Wire Line
	8100 5100 8200 5100
Wire Wire Line
	7550 4800 7550 5100
Connection ~ 7550 5100
Wire Wire Line
	7550 5100 7700 5100
Wire Wire Line
	10450 5100 10450 4800
Wire Wire Line
	9350 5100 9350 5300
Wire Wire Line
	9800 5100 9900 5100
Wire Wire Line
	9250 5100 9350 5100
$Comp
L Device:R awen16
U 1 1 5C05E239
P 8800 4350
F 0 "awen16" V 8700 4350 50  0000 C CNN
F 1 "10k" V 8900 4350 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 8730 4350 50  0001 C CNN
F 3 "~" H 8800 4350 50  0001 C CNN
	1    8800 4350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9350 4800 9350 5100
Connection ~ 9350 5100
Wire Wire Line
	9350 5100 9500 5100
Wire Wire Line
	9900 5100 9900 4800
Connection ~ 9900 5100
Wire Wire Line
	9900 5100 10000 5100
$Comp
L Device:R awen15
U 1 1 5C066F00
P 8350 5100
F 0 "awen15" V 8250 5100 50  0000 C CNN
F 1 "20k" V 8450 5100 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 8280 5100 50  0001 C CNN
F 3 "~" H 8350 5100 50  0001 C CNN
	1    8350 5100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8500 5100 8650 5100
$Comp
L Device:R awen19
U 1 1 5C0670ED
P 10150 5100
F 0 "awen19" V 10050 5100 50  0000 C CNN
F 1 "20k" V 10250 5100 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 10080 5100 50  0001 C CNN
F 3 "~" H 10150 5100 50  0001 C CNN
	1    10150 5100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10300 5100 10450 5100
$Comp
L Device:R awen6
U 1 1 5C06727D
P 6550 5100
F 0 "awen6" V 6450 5100 50  0000 C CNN
F 1 "20k" V 6650 5100 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6480 5100 50  0001 C CNN
F 3 "~" H 6550 5100 50  0001 C CNN
	1    6550 5100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6700 5100 6850 5100
Text Label 5950 5300 2    50   ~ 0
AIN2
Wire Wire Line
	7800 5300 7550 5300
Wire Wire Line
	9550 5300 9350 5300
$Comp
L Connector:TestPoint oko4
U 1 1 5C089F5D
P 4600 4650
F 0 "oko4" H 4650 4800 50  0000 L CNN
F 1 "oko" H 4650 4700 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 4800 4650 50  0001 C CNN
F 3 "~" H 4800 4650 50  0001 C CNN
	1    4600 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 4800 4550 4650
Wire Wire Line
	4550 4650 4600 4650
Connection ~ 4550 4800
$Comp
L Connector:TestPoint oko2
U 1 1 5C08ED66
P 4250 5000
F 0 "oko2" H 4300 5150 50  0000 L CNN
F 1 "oko" H 4300 5050 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 4450 5000 50  0001 C CNN
F 3 "~" H 4450 5000 50  0001 C CNN
	1    4250 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 5000 4400 5000
Connection ~ 4400 5000
$Comp
L Connector:TestPoint oko10
U 1 1 5C093F84
P 5900 4350
F 0 "oko10" H 5950 4500 50  0000 L CNN
F 1 "oko" H 5950 4400 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 6100 4350 50  0001 C CNN
F 3 "~" H 6100 4350 50  0001 C CNN
	1    5900 4350
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint oko14
U 1 1 5C094106
P 7700 4350
F 0 "oko14" H 7750 4500 50  0000 L CNN
F 1 "oko" H 7750 4400 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 7900 4350 50  0001 C CNN
F 3 "~" H 7900 4350 50  0001 C CNN
	1    7700 4350
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint oko24
U 1 1 5C09424E
P 9500 4350
F 0 "oko24" H 9550 4500 50  0000 L CNN
F 1 "oko" H 9550 4400 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 9700 4350 50  0001 C CNN
F 3 "~" H 9700 4350 50  0001 C CNN
	1    9500 4350
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint oko13
U 1 1 5C09464D
P 6850 4800
F 0 "oko13" H 6900 4950 50  0000 L CNN
F 1 "oko" H 6900 4850 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 7050 4800 50  0001 C CNN
F 3 "~" H 7050 4800 50  0001 C CNN
	1    6850 4800
	1    0    0    -1  
$EndComp
Connection ~ 6850 4800
$Comp
L Connector:TestPoint oko19
U 1 1 5C094847
P 8650 4800
F 0 "oko19" H 8700 4950 50  0000 L CNN
F 1 "oko" H 8700 4850 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 8850 4800 50  0001 C CNN
F 3 "~" H 8850 4800 50  0001 C CNN
	1    8650 4800
	1    0    0    -1  
$EndComp
Connection ~ 8650 4800
$Comp
L Connector:TestPoint oko26
U 1 1 5C094925
P 10450 4800
F 0 "oko26" H 10500 4950 50  0000 L CNN
F 1 "oko" H 10500 4850 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 10650 4800 50  0001 C CNN
F 3 "~" H 10650 4800 50  0001 C CNN
	1    10450 4800
	1    0    0    -1  
$EndComp
Connection ~ 10450 4800
$Comp
L Connector:TestPoint oko25
U 1 1 5C0949F5
P 9900 5100
F 0 "oko25" H 9800 5300 50  0000 L CNN
F 1 "oko" H 9850 5400 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 10100 5100 50  0001 C CNN
F 3 "~" H 10100 5100 50  0001 C CNN
	1    9900 5100
	-1   0    0    1   
$EndComp
$Comp
L Connector:TestPoint oko16
U 1 1 5C094EE9
P 8100 5100
F 0 "oko16" H 8000 5300 50  0000 L CNN
F 1 "oko" H 8050 5400 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 8300 5100 50  0001 C CNN
F 3 "~" H 8300 5100 50  0001 C CNN
	1    8100 5100
	-1   0    0    1   
$EndComp
$Comp
L Connector:TestPoint oko12
U 1 1 5C094FC5
P 6300 5100
F 0 "oko12" H 6200 5300 50  0000 L CNN
F 1 "oko" H 6250 5400 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 6500 5100 50  0001 C CNN
F 3 "~" H 6500 5100 50  0001 C CNN
	1    6300 5100
	-1   0    0    1   
$EndComp
Connection ~ 9100 900 
Wire Wire Line
	9100 900  9500 900 
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5C09CFB5
P 10400 1000
F 0 "#FLG01" H 10400 1075 50  0001 C CNN
F 1 "PWR_FLAG" H 10400 1174 50  0000 C CNN
F 2 "" H 10400 1000 50  0001 C CNN
F 3 "~" H 10400 1000 50  0001 C CNN
	1    10400 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	10400 1000 10100 1000
Connection ~ 10100 1000
$Comp
L Connector:Conn_01x03_Male lupa-lawa1
U 1 1 5C0A87CA
P 7350 1300
F 0 "lupa-lawa1" H 7456 1578 50  0000 C CNN
F 1 "lupa lawa" H 7456 1487 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 7350 1300 50  0001 C CNN
F 3 "~" H 7350 1300 50  0001 C CNN
	1    7350 1300
	1    0    0    -1  
$EndComp
$Comp
L power:VDD #PWR09
U 1 1 5C0A8B2A
P 8000 1200
F 0 "#PWR09" H 8000 1050 50  0001 C CNN
F 1 "VDD" H 8017 1373 50  0000 C CNN
F 2 "" H 8000 1200 50  0001 C CNN
F 3 "" H 8000 1200 50  0001 C CNN
	1    8000 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 1200 7550 1200
$Comp
L power:GND #PWR010
U 1 1 5C0ADFD6
P 8000 1300
F 0 "#PWR010" H 8000 1050 50  0001 C CNN
F 1 "GND" H 8005 1127 50  0000 C CNN
F 2 "" H 8000 1300 50  0001 C CNN
F 3 "" H 8000 1300 50  0001 C CNN
	1    8000 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 1300 8000 1300
Text Label 7550 1400 0    50   ~ 0
8
Wire Wire Line
	5750 5300 5950 5300
Wire Wire Line
	5650 5100 5750 5100
Wire Wire Line
	5250 5100 5250 5150
Wire Wire Line
	5350 5100 5250 5100
$Comp
L Device:R awen4
U 1 1 5C037B1A
P 5500 5100
F 0 "awen4" V 5400 5100 50  0000 C CNN
F 1 "470k" V 5600 5100 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5430 5100 50  0001 C CNN
F 3 "~" H 5500 5100 50  0001 C CNN
	1    5500 5100
	0    -1   -1   0   
$EndComp
Text Label 10050 2900 0    50   ~ 0
PB5
Text Notes 4550 5600 0    50   ~ 0
Hold "ala" on power up to enter factory mode.\nsina wile ante e ilo nanpa la o pilin e nena "ala" lon tenpo pi open wawa
Text Notes 7500 5650 0    50   ~ 0
Hold "pana" on power up to enter programming mode\nsina wile ante e lawa pi ilo nanpa la o pilin e nena "ala" lon tenpo pi open wawa
$EndSCHEMATC
