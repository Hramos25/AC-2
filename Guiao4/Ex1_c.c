#include <detpic32.h>

void delay(unsigned int ms){

    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}


int main(void){

    TRISEbits.TRISE6 = 0;
    TRISEbits.TRISE5 = 0;
    TRISEbits.TRISE4 = 0;
    TRISEbits.TRISE3 = 0;

/*  Alternativa

    // Configure RE6 to R3 as inputs
    TRISE = TRISE & 0xFF87; // 1111 1111 1000 0111
*/
    int counter = 10;

    while(1){

        LATE = (LATE & 0xFF87) | counter << 3;

        delay(500);

       // counter = (counter + 9) % 10;        

        counter--;
        // Reset if it reaches 10
        if (counter == 0) { counter = 10; }


    }
    return 0;

}