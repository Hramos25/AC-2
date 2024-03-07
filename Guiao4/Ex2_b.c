#include <detpic32.h>

void delay(unsigned int ms){

    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}

int main(void){

    unsigned char segment;
    // enable display low (RD5) and disable display high (RD6)
    // configure RB8-RB14 as outputs
    // configure RD5-RD6 as outputs

    TRISB = TRISB & 0x80FF;
    TRISD = TRISD & 0xFF9F;

    LATDbits.LATD5 = 1;
    LATDbits.LATD6 = 0;

    while(1){

        segment = 1;
        int i = 0;
        for(i = 0; i < 7 ; i++){
            LATB = (LATB & 0x80FF) | (segment << 8);
            delay(500);

            segment = segment << 1;
        }
        LATDbits.LATD5 = !LATDbits.LATD5;
        LATDbits.LATD6 = !LATDbits.LATD6;   

    }
    return 0;
}