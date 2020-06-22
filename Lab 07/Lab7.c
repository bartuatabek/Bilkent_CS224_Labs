/* Description:
 * Simple counter with the following functionalities such as
 * inverting the lsb, and changing the counting speed with 
 * total of 3 configurations
 */

unsigned int counter, counter2;

// fliplsb function that changes the position of the least
// significant bit (lsb) on the LEDs. 
int fliplsb(int counter) {
    return ((counter & 0x01) << 7)
    | ((counter & 0x02) << 5)
    | ((counter & 0x04) << 3)
    | ((counter & 0x08) << 1)
    | ((counter & 0x10) >> 1)
    | ((counter & 0x20) >> 3)
    | ((counter & 0x40) >> 5)
    | ((counter & 0x80) >> 7);
}

void main() {
  AD1PCFG = 0xFFFF;      // Configure AN pins as digital I/O
  JTAGEN_bit = 0;        // Disable JTAG

  TRISD = 0;             // output port
  TRISF = 1;             // input port

  LATD = 255;            // LAT registers
  LATF = 255;

  counter = 255;         // internal variables
  counter2 = 255; 

  while(1) {
    // If button 0 is pressed display the counter normally
    if (PORTFbits.RF0 == 0 && PORTFbits.RF1 != 0) {
      counter --;
      PORTD = counter;
    }

    // If button 1 is pressed reverse the lsb of the counter
    else if (PORTFbits.RF0 != 0 && PORTFbits.RF1 == 0) {
      PORTD = fliplsb(counter2);
      counter2--;
    }

    // If both buttons are pressed display nothing (implemented in part2.b)
    else
      PORTD = 255;

    // Accelerated speed control for part2.b
    // If button 2 is pressed counter increments every 750 ms
    if (PORTFbits.RF2 = 0 && PORTFbits.RF3 != 0) {
      Delay_ms(250);
    }

    // If button 3 is pressed counter increments every 750 ms
    else if (PORTFbits.RF2 != 0 && PORTFbits.RF3 == 0) {
      Delay_ms(750);
    }

    // If both buttons are pressed counter increments every 500 ms
    else
      Delay_ms(500); 
  }