#include <detpic32.h>

void delay(unsigned int ms){

    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}

int main(void){

    TRISB = TRISB & 0x80FF;
    TRISD = TRISD & 0xFF9F;

    LATDbits.LATD5 = 1;
    LATDbits.LATD6 = 0;

    while(1){

        int i = 0;
        for(i = 0; i < 16; i++){
            delay(1000);
            if(i == 0) LATB = (LATB & 0x80FF) | 0x3F00;
            else if(i == 1) LATB = (LATB & 0x80FF) | 0x0600;
            else if(i == 2) LATB = (LATB & 0x80FF) | 0x5B00;
            else if(i == 3) LATB = (LATB & 0x80FF) | 0x4F00;
            else if(i == 4) LATB = (LATB & 0x80FF) | 0x6600;
            else if(i == 5) LATB = (LATB & 0x80FF) | 0x6D00;
            else if(i == 6) LATB = (LATB & 0x80FF) | 0x7D00;
            else if(i == 7) LATB = (LATB & 0x80FF) | 0x0700;
            else if(i == 8) LATB = (LATB & 0x80FF) | 0x7F00;
            else if(i == 9) LATB = (LATB & 0x80FF) | 0x6F00;
            else if(i == 10) LATB = (LATB & 0x80FF) | 0x7700;
            else if(i == 11) LATB = (LATB & 0x80FF) | 0x7C00;
            else if(i == 12) LATB = (LATB & 0x80FF) | 0x3900;
            else if(i == 13) LATB = (LATB & 0x80FF) | 0x5E00;
            else if(i == 14) LATB = (LATB & 0x80FF) | 0x7900;
            else if(i == 15) LATB = (LATB & 0x80FF) | 0x7100;
        }

    }
    return 0;
}