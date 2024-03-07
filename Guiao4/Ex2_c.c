#include <detpic32.h>

void delay(unsigned int ms){

    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}

int main(void){

    unsigned char segment;

    TRISB = TRISB & 0x80FF; // 1000 0000 1111 1111
    TRISD = TRISD & 0xFF9F; // 1111 1111 1001 1111

    LATD = (LATD & 0xFF9F) | 0x0020; // ---- ---- -01- ----

    while(1){

        segment = 1;
        int i = 0;
        for (i = 0; i < 7; i++){
            LATB = (LATB & 0x80FF) | (segment << 8);
            delay(500);

            segment = segment << 1;

        }

        LATD = LATD^0x0060; // ---- ---- -11- ----

    }
    return 0;
}