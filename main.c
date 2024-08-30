#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>

#include "Screen.h"
#include "Sort.h"

int main(int argc, char **argv)
{

    // Window size
    const int width = 1500;
    const int height = 800;

    // Initialize library and create window
    StartSDL();
    Window *sort_vis = (Window *)malloc(sizeof(Window));
    CreateWindow(sort_vis, width, height);

    // Create a random array
    int *arr = (int *)malloc(sizeof(int) * width);
    for (size_t i = 0; i < width; i++)
    {
        arr[i] = rand() % (height - 10);
        drawLine(sort_vis, i, arr[i]);
    }

    // Struct to pass the array to the thread
    Arguments *arg;
    arg = (Arguments *)malloc(sizeof(Arguments));
    arg->array = arr;
    arg->size = width;

    // The sorting function to use
    void *(*Sortfunction)(void *);
    Sortfunction = SelectionSort;

    // Create the thread and make it "indipendent"
    pthread_t thread_id;
    pthread_create(&thread_id, NULL, Sortfunction, (void *)arg);
    pthread_detach(thread_id);

    // Display loop
    while (1)
    {

        // Close on X pressed
        while (SDL_PollEvent(&sort_vis->event))
        {

            switch (sort_vis->event.type)
            {

            case SDL_QUIT:
                goto end;
            }
        }

        // If the array has changed draw the differences
        if (draw)
        {

            drawLines(sort_vis, arr);
            draw = false;
        }
    }

end:

    // Free the memory
    free(arg);
    free(arr);

    // Close the library
    CloseSDL();

    return 0;
}