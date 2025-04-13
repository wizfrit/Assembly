# CatchAlphabets - Assembly Language Game

**Authors:** M. Waiz Shabbir (22L-6991), Ateefa Hafeez (22L-6866)

## Description

CatchAlphabets is a simple game implemented in 16-bit x86 assembly language for DOSBox. [cite: 4] The player controls a box at the bottom of the screen and must catch falling alphabets (A-Z) to gain points. [cite: 5, 6, 7, 13] The game ends when the player misses 10 alphabets. [cite: 15]

## Features

* **Player Control:** The player controls a box at the bottom of the screen using the left and right arrow keys. [cite: 5, 6]
* **Falling Alphabets:** Characters 'A' to 'Z' fall from the top of the screen at varying speeds. [cite: 7, 9, 10, 11, 12]
* **Scoring:** The player earns a point for each alphabet caught by the box. [cite: 13, 14]
* **Game Over:** The game ends after 10 missed alphabets. [cite: 15]
* **Random Alphabet Generation:** Alphabets fall randomly from the top. [cite: 7, 8]

## Instructions

###   **Prerequisites**

* DOSBox emulator must be installed to run this game. [cite: 4]

###   **How to Run**

1.  Assemble the code using an assembler (e.g., NASM or MASM).
2.  Run the executable in DOSBox. [cite: 4]

###   **Gameplay**

* Use the **left arrow key** to move the box left. [cite: 6] (Scan Code: 0x4B)
* Use the **right arrow key** to move the box right. [cite: 6] (Scan Code: 0x4D)
* Catch the falling alphabets with the box. [cite: 13]
* The game continues until 10 alphabets are missed. [cite: 15]

## Implementation Details

* The game is implemented in 16-bit x86 assembly language.
* Keyboard interrupt (INT 9h) is hooked to handle player input (left/right arrow keys). [cite: 7]
* Timer interrupt (INT 8h) is hooked to control the falling speed and movement of the alphabets. [cite: 12]
* A linear congruential generator (LCG) is used to generate random alphabets. [cite: 8]
* The box is represented by ASCII character 0xDC. [cite: 5, 6]

## Code Overview

The code is organized as follows:

* `start`:  The entry point of the program. Initializes interrupts and calls the main game loop.
* `kbisr`:  Keyboard interrupt service routine to handle left/right arrow key presses.
* `timer1`: Timer interrupt service routine to manage falling alphabets and game logic.
* `randG`:  Subroutine to generate random numbers.
* `printstr`:  Subroutine to print strings on the screen.
* `printnum`:  Subroutine to print numbers (score) on the screen.
* `clrscr`:   Subroutine to clear the screen.
* `interface`: Subroutine to draw the static interface
* `unhookkey`: Subroutine to unhook the keyboard interrupt
* `unhooktime`: Subroutine to unhook the timer interrupt
* `delay`: Subroutine to create delay

## Limitations

* This game is designed to run in a DOS environment (DOSBox).
* The graphics are text-based.

## Authors

* M. Waiz Shabbir (22L-6991)
* Ateefa Hafeez (22L-6866)

## Acknowledgements

* The random number generation subroutine (`rand.asm`) was provided. [cite: 8]
