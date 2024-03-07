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

    // Configure RE6 to RE3 as outputs
    TRISE = TRISE & 0xFF87; // 1111 1111 1000 0111
*/
    int counter = 0;

    while(1){

        LATE = (LATE & 0xFF87) | counter << 3;

        delay(500);

      //  counter = (counter + 1) % 10;        

        counter++;
        // Reset if it reaches 10
        if (counter == 10) { counter = 0; }

    }
    return 0;

}