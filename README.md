# Microprocessor-and-Embedded-systems


## MCU
This describes about the fully functional 8-bit microcontroller unit with 4 pipeline stages, its components, their functionality, and program execution. This MCU model has 3 main submodules – data memory, instruction memory and CPU.
<br/>
<br/>

### Data Memory
The Data Memory in a microcontroller refers to the memory used to store data and variables that change dynamically during execution. In this project, we’ve used Verilog HDL to design a data memory which is a RAM with 8-bit data_in input bus that can be used to write data into the memory and 8-bit data_out output bus that is used to read the value out from the given memory location. We also have a 1-bit wr_rd_en input signal which helps to understand whether we want a write operation (write data into the specified address location) or a read operation (read data out from the specified address location).
<br/>
<br/>

### Instruction Memory 
The instruction memory stores the instructions to be implemented by the processor. It is usually ROM or flash memory and ensures the instructions are not lost or overwritten during runtime. In this project, we've used Verilog HDL to design an instruction memory with 8-bit addr_in bus input and 17-bit data_out bus. It has a memory capacity of 256*17 bits. It gets address from program counter and outputs the corresponding 17-bit instruction from memory for decoding.
<br/>
<br/>

### Central Processing Unit 
The CPU several submodules that complete the ALU operation. The CPU has the following submodules 
<br/>

- #### ALU
  ALU performs the arithmetic and logic operations in MCU. We have a pure combinational ALU in this design. The instruction is decoded based on the opcode and the operands are used for data interpretation. We have 5 status signals that output from ALU and provide the status of carry, negative result, zero result, etc.
<br/>

- #### Multiplexors
    In this project, we have 4 multiplexers, MUXA, MUXB, MUXC, MUXD. MUX A and MUX B have 2 input ports each and each input port is 8 bits wide. MUXC has 4 input ports with 8 bits each and MUXD has 3 input ports and 2 select lines. In an MCU, the multiplexer selects one of several input signals and routes it to a single output line, which can then be processed by other components in the system.
<br/>

- #### Registers
    In this project we have eight 8-bit registers that store the data required for MCU operation. Data can be read and stored into these registers
<br/>

- #### Instruction Decoder
    The instruction decoder decodes the instruction received from instruction register and generates the necessary control signals to other components of MCU. Based on the type of instruction received, the instruction decoder asserts the conditional outputs that perform the required operation. We have 17-bit instructions as input to the decoder.
<br/>

- #### Constant Unit
    A constant unit is responsible for generating constant values that are necessary for program execution. In our design, constant unit performs the extension of bits from 6 to 8 for immediate values in 2 register type instructions.
<br/>

- #### Data Hazard
    Data hazard is an error which occurs due to the pipeline mode of execution. When different stages of pipeline want to work on the same data entity, data hazard occurs
<br/>

- #### Branch Hazards
    A branch hazard occurs when an instruction has jump and branch operations associated with it.
<br/>
<br/>

### Testing the MCU

We've created a Verilog testbench to check the working of the MCU module. We've simulated our Verilog design using Xilinx ISE and synthesized to generate the bit file to program the FPGA. This bit file contains the configuration information necessary to program an FPGA
<br/>

Here is a [video](https://www.youtube.com/watch?v=5iiKaj72Tj8&list=PLEQhs3QersfUM1hBywhXNjxLwTM_AZS5l "Video") summarizing 
<br/>
<br/>

<div style="page-break-after: always;"></div>

## MSP Microcontroller
After Installing [energia](https://energia.nu/download/ "energia") and connecting to MSP432P4111 Launchpad. Here are detailed [instructions](https://github.com/Nived151/Microprocessors/blob/main/MSP%20Microcontrollers/MSP432%20Quickstart%20Guide.pdf "instructions") to install and setup device
<br/>

- #### Seven Segment Display
    The goal of this project is to convert the analog input using joystick (range 0 to 99) and display it on the LCD screen within seven segments. Run the [ino](https://github.com/Nived151/Microprocessors/blob/main/MSP%20Microcontrollers/Seven%20segment%20Display.ino "file") file and refer to [pdf](https://github.com/Nived151/Microprocessors/blob/main/MSP%20Microcontrollers/Seven%20Segment%20Display.pdf "pdf")
<br/>

- #### Accelerometer
     In this experiment, we tilt the MKII and display the acceleration values in xyz axes on 
matlab. Run both [ino](https://github.com/Nived151/Microprocessors/blob/main/MSP%20Microcontrollers/Accelerometer.ino "ino") and [matlab](https://github.com/Nived151/Microprocessors/blob/main/MSP%20Microcontrollers/Accelerometer_matlab.m "matlab") files, refer to [pdf](https://github.com/Nived151/Microprocessors/blob/main/MSP%20Microcontrollers/Accelerometer.pdf "pdf") 
<br/>
<br/>

<div style="page-break-after: always;"></div>

## TinyML
Install [python](python.org/downloads/ "python"), [nodejs](nodejs.org/en/download "nodejs"), [Ti uniflash](www.ti.com/tool/UNIFLASH#downloads "Ti uniflash") add it to PATH & [update](https://cdn.edgeimpulse.com/firmware/ti-launchxl.zip "update") firmware by following this [tutorial](https://www.youtube.com/watch?v=NWkdxFhzwxI "tutorial") and check [drivers](https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers?tab=downloads "check")  for ports
<br/>

- After installing nodeJS run the following command

    ```
    npm install -g edge-impulse-cli --force
    ```
<br/>

- After installing python run the following command

    ```
    pip install esptool
    ```

