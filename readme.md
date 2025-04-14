STMF401RE : 512KByte flash

0x0     +---------------------+
        |                     |
        |      Bootloader     |
        |                     |
0x4000  +---------------------+
        |                     |
        |                     |
        |      Application    |
        |                     |
        |                     |
0x30000 +---------------------+

Dependencies
    sudo apt install cmake make gcc g++ libusb-1.0-0-dev pkg-config
    sudo apt-get install stlink-tools

The startup script does four essential things:
    - Define the vector table (interrupt pointers)
    - Set the stack pointer
    - Initialize memory (copy .data, zero .bss)
    - Call SystemInit() → main()

Group those into sections: .text, .data, .bss, .rodata, etc.
Assign each section to a memory region (Flash, RAM)
Resolve addresses so everything can run on hardware

.text stored in flash : flash is larger, persistent, and executes directly on Cortex-M cores.


