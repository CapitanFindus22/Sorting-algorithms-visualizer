#ifndef SCREEN
#define SCREEN

#include <SDL2/SDL.h>
#include <stdio.h>

/// Encapsulation of a window
typedef struct
{

    SDL_Window *window;
    SDL_Renderer *renderer;
    SDL_Event event;
    int height;
    int width;

} Window;

// Start and end functions
void StartSDL();
void CloseSDL();

// Create the window
void CreateWindow(Window *, int, int);

// Draw functions
void clear(Window *);
void drawLine(Window *, int, int);
void drawLines(Window *, int *);

// Start the library
inline void StartSDL()
{

    if (SDL_Init(SDL_INIT_VIDEO) < 0)
    {
        fprintf(stderr, "%s\n", SDL_GetError());
        exit(-1);
    }

    return;
}

// Create a new window
inline void CreateWindow(Window *window, int width, int height)
{
    SDL_CreateWindowAndRenderer(width, height, 0, &window->window, &window->renderer);

    if (window->window == NULL || window->renderer == NULL)
    {
        fprintf(stderr, "%s\n", SDL_GetError());
        exit(-1);
    }

    window->height = height;
    window->width = width;
}

// Close the library
inline void CloseSDL()
{

    SDL_Quit();
}

// Clear the Window
inline void clear(Window *window)
{

    SDL_SetRenderDrawColor(window->renderer, 0, 0, 0, 255);
    SDL_RenderClear(window->renderer);
}

// Draw the lines in arr
void drawLines(Window *window, int *arr)
{

    clear(window);

    SDL_SetRenderDrawColor(window->renderer, 255, 255, 255, 255);

    for (size_t i = 0; i < window->width; i++)
    {

        SDL_RenderDrawLine(window->renderer, i, window->height, i, window->height - arr[i]);
    }

    SDL_RenderPresent(window->renderer);
}

// Draw a line from the bottom to the pixel equal to the value of array[x]
void drawLine(Window *window, int x, int y)
{

    SDL_SetRenderDrawColor(window->renderer, 255, 255, 255, 255);

    SDL_RenderDrawLine(window->renderer, x, window->height, x, window->height - y);

    SDL_RenderPresent(window->renderer);
}

#endif