# UART

- Universal Asynchronous Receiver-Transmitter (UART) is one of the simplest and oldest forms of device-to-device digital communication.
- UART is a serial communication protocol that performs parallel to serial data conversion at the transmitter side and serial to parallel data conversion at the receiver side.
- UART transmitter and receiver works **asynchronously**, which means there is **no clock signal** to synchronize the output of bits from the transmitting UART to the sampling of bits by the receiving UART.
- Instead of a clock signal, the transmitting UART adds Start and Stop Bits to the Data Packet being transferred.

## Data Packet in UART

- Each Data Packet consists of a Start Bit followed by Data Bits (usually 5 to 9-bits long) and then Parity Bit and at the end is the Stop Bit.

![UART Data Packet](https://raw.githubusercontent.com/smboteyrc/sm_bot_images/main/sm_bot_images/src/md_files/task_2/Task_2_B/UART-Communication.jpg)

- **Idle bits:** When no data is being transferred, the transmission lines are held at a low.

- **Start bit:** When data transferred it started, the lines are held at a low for one clock cycle.
- **Data bits:** Once Start bit is detected, then the actual data is sent. It can be upto 5-bits to 9-bits long. **LSB is sent first.**

- **Parity bit:** Parity Bit is used to check if the data that comes to the UART Receiver of one device is the same as the data that is sent by the UART Transmitter of another device. The Parity Bit can be 0 (even parity) or 1 (odd parity) depending upon the number of ’1’ in the data frame, if there are even numbers of 1 in the data frame then it is even parity or else it is odd. In this task, we will not use the Parity Bit in the data frame.

- **Stop bit:** This bit marks the end of the Data Packet, as we know that the transmission line is pulled down from high to low to indicate the Start Bit, so at the end of the Data Packet we have to make the transmission line high again.

## UART Baud Rates

The baud rate will specify the speed at which data will be sent over the serial line between trasmitter and reciever. Its unit is bits per second(bps).

$$ \text{Clocks Per Bit} = \frac{\text{Clock Speed}}{\text{Baud Rate}} $$

## Parameters for the task(2 - B):

| Parameter | Value |
|-----------|---------|
| Baud Rate |  115200 |
| No of Data Bits | 8-bits |
| Parity Bit | None |
| Stop Bit | 2-bits |

## Waveform

![Image](https://raw.githubusercontent.com/smboteyrc/sm_bot_images/main/sm_bot_images/src/md_files/task_2/Task_2_B/uartsignal.png)

---
