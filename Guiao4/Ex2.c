#include <detpic32.h>


int main(void){

    TRISD = TRISD & 0xFF9F;  // 1111 1111 1001 1111
    TRISB = TRISB & 0x80FF; // 1000 0000 1111 1111

    LATDbits.LATD5 = 0; // Enable LO-D
    LATDbits.LATD6 = 1; // Disable HI-D
    

    while(1){

        char read = getChar();
        if ((read >= 'a' && read <= 'g') || (read >= 'A' && read <= 'G')){
            if (read == 'a' || read == 'A') LATB = (LATB & 0x80FF) | 0x0100;
            else if (read == 'b' || read == 'B') LATB = (LATB & 0x80FF) | 0x0200;
            else if (read == 'c' || read == 'C') LATB = (LATB & 0x80FF) | 0x0400;
            else if (read == 'd' || read == 'D') LATB = (LATB & 0x80FF) | 0x0800;
            else if (read == 'e' || read == 'E') LATB = (LATB & 0x80FF) | 0x1000;
            else if (read == 'f' || read == 'F') LATB = (LATB & 0x80FF) | 0x2000;
            else if (read == 'g' || read == 'G') LATB = (LATB & 0x80FF) | 0x4000;
        }

    }
    return 0;
}