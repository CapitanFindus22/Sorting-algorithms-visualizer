#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>

#include "Screen.h"
#include "Sort.h"

int main(int argc, char **argv) {

    const int width = 200;
    const int height = 200;

    Screen *sort_vis = (Screen*)malloc(sizeof(Screen));
    
    StartSDL();

    InitScreen(sort_vis,width,height);
    
    int *arr = (int*)malloc(sizeof(int)*width);

    for (size_t i = 0; i < width; i++)
    {
        arr[i] = rand() %(height-10);
        drawLine(sort_vis,i,arr[i]);
        SDL_Delay(5);

    }

    Arguments *arg;

    arg = (Arguments*)malloc(sizeof(Arguments));
    arg->array = arr;
    arg->size = width;

    pthread_t thread_id;
    pthread_create(&thread_id, NULL, SelectionSort, (void*)arg);
    pthread_detach(thread_id);

    while(1) {

        while (SDL_PollEvent(&sort_vis->event))
        {

            switch (sort_vis->event.type)
            {

            case SDL_QUIT:
                goto end;
            }
        }

        if(draw) {

            drawLines(sort_vis,arr,width);
            SDL_Delay(10);
            draw = 0;

        }

    }

    end:
    free(arg);
    free(arr);
    CloseScreen();

    return 0;
}