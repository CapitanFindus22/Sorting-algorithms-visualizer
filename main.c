#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>

#include "Screen.h"
#include "Sort.h"

int main(int argc, char **argv) {

    Screen *ptr = (Screen*)malloc(sizeof(Screen));

    int width = 400;
    int height = 500;
    InitScreen(ptr,width,height);

    int *arr = (int*)malloc(sizeof(int)*width);

    for (size_t i = 0; i < width; i++)
    {
        arr[i] = rand() %(height-10);
        drawLine(ptr,i,arr[i]);
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

        while (SDL_PollEvent(&ptr->event))
        {

            switch (ptr->event.type)
            {

            case SDL_QUIT:
                goto end;
            }
        }

        if(draw) {

            drawLines(ptr,arr,width);
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