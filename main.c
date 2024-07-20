#include <SDL2/SDL.h>
#include "Screen.h"
#include <stdlib.h>

int main(int argc, char **argv) {

    Screen screen;
    Screen *ptr = &screen;

    SDL_Event PingStop;

    int width = 400;
    int height = 400;
    InitScreen(ptr,width,height);

    int arr[width];

    for (size_t i = 0; i < width; i++)
    {
        arr[i] = rand() %(height-10);
    }
    
    drawLines(ptr,arr,width,-1,-1);

    //Selection sort
    size_t i,j,t;
    int min;
    int temp = 0;

    while (SDL_PollEvent(&PingStop)) { 

        for (i = 0; i < width-1; i++)
        {
            t = i;
            min = arr[i];
            for (j=i+1; j < width; j++)
            {
                if(min > arr[j]) {

                    t=j;
                    min=arr[j];

                }
                SDL_Delay(0);
                drawLines(ptr,arr,width,i,j);
            }

            if(t != i) {
            
                temp = arr[i];
                arr[i] = arr[t];
                arr[t] = temp;

            }

        }

        break;
    }
    
    drawLines(ptr,arr,width,-1,-1);
    SDL_Delay(50);
    CloseScreen();

    return 0;
}