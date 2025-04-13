#   Assembly Language Assignment 3

##   Description

This repository contains the solutions for Assembly Language (G, H) Assignment 3, Fall 2023. The assignment consists of four assembly language programs that perform screen manipulation and number processing.

##   Questions and Solutions

###   Question 1: Screen Flip Subroutine

* **Description:** The `flip` subroutine creates a flipped image of the upper half of the screen on the lower half. The top-left character of the upper half becomes the bottom-right character of the lower half. The original lower half of the screen is overridden. [cite: 3, 4, 5]
* **File:** `[your_roll_number]_1.asm` (e.g., `20L1234_1.asm`)
* **Key Concepts:**
    * Screen memory addressing
    * Looping and indexing
    * Register manipulation
* **Notes:**
    * The code is generic and works for any screen size.
    * The code does not print any new characters to the screen. [cite: 5, 6]

###   Question 2: Screen Copy Subroutine

* **Description:** A subroutine that copies a specified area of the screen to the center of the screen. The subroutine receives the top, left, bottom, and right coordinates of the area to be copied via the stack. [cite: 8, 9]
* **File:** `[your_roll_number]_2.asm`
* **Key Concepts:**
    * Stack parameter passing
    * Screen coordinate calculations
    * Memory copying
* **Assumptions:**
    * The passed parameters (top, left, bottom, right) are within the valid screen range. [cite: 10]
    * The height of the area to be copied is odd, and the width is even. [cite: 10]

###   Question 3: Screen Swap

* **Description:** This program divides the video screen into four equal parts (12 rows x 40 columns, skipping the last row). When the user presses '1', memory area 1 is swapped with memory area 4. When the user presses '2', memory area 2 is swapped with memory area 3. [cite: 11, 12]
* **File:** `[your_roll_number]_3.asm`
* **Key Concepts:**
    * Screen segmentation
    * Keyboard input
    * String instructions (for efficient memory swapping)
* **Screen Layout:**

    ```
    Memory area 1, Memory area 2
    Memory area 3, Memory area 4
    ```

    [cite: 13]

###   Question 4: Happy Number Determination

* **Description:** An assembly program that takes a 4-digit decimal number as input from the user and determines if it's a happy number. The program displays "Happy" or "UnHappy" on the screen. [cite: 14, 15]
* **File:** `[your_roll_number]_4.asm`
* **Key Concepts:**
    * User input (decimal numbers)
    * Digit extraction
    * Mathematical operations (squaring, summing)
    * Iteration and conditional logic
* **Happy Number Algorithm:**
    * Replace the number with the sum of the squares of its digits.
    * Repeat this process.
    * If the number becomes 1 within 256 iterations, it's a happy number.
    * Otherwise, it's an unhappy number. [cite: 16, 17, 18]

##   Submission

* Four .asm files were submitted to Google Classroom. [cite: 1]
* Files are named according to the format: `[your_roll_number]_[question_number].asm` (e.g., `20L1234_1.asm`). [cite: 2]

##   Author

* Waiz Shabbir
* 22L-6991
