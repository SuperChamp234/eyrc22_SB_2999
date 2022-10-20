# ADC128S022 (8-Channel, 12 bit ) #

### PIN diagram ###
![image](https://user-images.githubusercontent.com/104309685/197006149-e1dc0387-c5b4-45ee-9ca1-627e66a103a6.png)

### PIN functions ###

|                |PIN number   |DESCRIPTION                                                                                                                                                                                                                                                                            |
|----------------|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|  
|CS              | `1`         |Chip select. On the falling edge of CS, a conversion process begins. Conversions continue CS 1 Digital I/O as long as CS is held low                                                                                                                                            |
|VA              | `2`         |Positive analog supply pin. This voltage is also used as the reference voltage. This pin Power VA 2 should be connected to a quiet +2.7-V to +5.25-V source and bypassed to GND with 1-µF Supply and 0.1-µF monolithic ceramic capacitors located within 1 cm of the power pin. |                                                                                                                                                                |
|AGND            | `3`         |The ground return for the analog supply and signals                                                                                                                                                                                                                             |
|IN0 to IN7      | `4-11`      |Analog inputs. These signals can range from 0 V to VREF                                                                                                                                                                                                                         |                              
|DGND            | `12`        |The ground return for the digital supply and signals                                                                                                                                                                                                                            | 
|VD              | `13`        |Positive digital supply pin. This pin should be connected to a +2.7-V to VA supply, and Power VD 13 bypassed to GND with a 0.1-µF monolithic ceramic capacitor located within 1 cm of the Supply power pin                                                                      |
|DIN             | `14`        |Digital data input. The ADC128S022's Control Register is loaded through this pin on rising DIN 14 Digital I/O edges of the SCLK pin                                                                                                                                             |
|DOUT            | `15`        |Digital data output. The output samples are clocked out of this pin on the falling edges of DOUT 15 Digital I/O the SCLK pin                                                                                                                                                    |
|SCLK            | `16`        |Digital clock input. The specified performance range of frequencies for this input is 0.8 MHz SCLK 16 Digital I/O to 3.2 MHz. This clock directly controls the conversion and readout processes                                                                                 |

### Working of ADC signals and its waveform ###
- It operates in a 16 cycle frame
- The DOUT signal provides the 12-bit converted value of the selected channel
- On power-up, channel 0 is selected by default, while subsequent reads will use the address provided in the previous operational frame
- The data bits are transmitted in descending order, such that the highest-order bit is delivered first
- It is captured by the user on the rising edge of SCLK
- The DIN signal is used to select the channel to be converted in the following frame
- It is delivered in descending order, and is captured by the ADC128S022 on the positive edges of SCLK
- In order to avoid potential race conditions, we should generate DIN on the negative edges of SCLK
- CS should be lowered on the first falling edge of SCLK and raised on the last rising edge of an operational frame
- The SCLK frequency is limited to a range of 0.8 to 3.2 MHz in which the ADC will function correctly

![image](https://user-images.githubusercontent.com/104309685/197005867-2ac1802f-a987-4425-8ec6-9a1243278c46.png)

### INPUT channel selection ### 

|  ADD2  |  ADD1  |  ADD0  |  INPUT CHANNEL |
|--------|--------|--------|----------------|
|   0    |   0    |   0    |  IN0 (Default) |
|   0    |   0    |   1    |  IN1           |
|   0    |   1    |   0    |  IN2           |
|   0    |   1    |   1    |  IN3           |
|   1    |   0    |   0    |  IN4           |
|   1    |   0    |   1    |  IN5           |
|   1    |   1    |   0    |  IN6           |
|   1    |   1    |   1    |  IN7           |