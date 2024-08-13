#ifndef SCREEN
#define SCREEN

#include <SDL2/SDL.h>
#include <stdio.h>

/// @brief Encapsulate a window
typedef struct
{

    SDL_Window *window;
    SDL_Renderer *renderer;
    SDL_Event event;
    int height;

} Screen;

// Start and end functions
void StartSDL();
void InitScreen(Screen *, int, int);
void CloseScreen();

// Draw functions
void clear(Screen*);
void drawLine(Screen*,int,int);
void drawLines(Screen*,int*,size_t);

inline void StartSDL() {

    if (SDL_Init(SDL_INIT_VIDEO) < 0)
    {
        fprintf(stderr, "%s\n", SDL_GetError());
        exit(-1);
    }

    return;
}

/// @brief Initialize the library and create the screen and the renderer
/// @param screen The screen to initialize
/// @param width The width of the screen to create
/// @param height The height of the screen to create
inline void InitScreen(Screen *screen, int width, int height)
{
    SDL_CreateWindowAndRenderer(width, height, 0, &screen->window, &screen->renderer);

    if (screen->window == NULL || screen->renderer == NULL)
    {
        fprintf(stderr, "%s\n", SDL_GetError());
        exit(-1);
    }

    screen->height = height;

}

/// @brief Close the library
inline void CloseScreen()
{

    SDL_Quit();
}

/// @brief Clear the screen
/// @param screen The screen to clear
inline void clear(Screen *screen)
{

    SDL_SetRenderDrawColor(screen->renderer, 0, 0, 0, 255);
    SDL_RenderClear(screen->renderer);
}

void drawLines(Screen *screen,int* arr,size_t size) {

    clear(screen);

    SDL_SetRenderDrawColor(screen->renderer,255,255,255,255);

    for (size_t i = 0; i < size; i++)
    {

        SDL_RenderDrawLine(screen->renderer,i,screen->height,i,screen->height-arr[i]);
    
    }
    
    SDL_RenderPresent(screen->renderer);

}

void drawLine(Screen *screen,int x,int y) {

    SDL_SetRenderDrawColor(screen->renderer,255,255,255,255);

    SDL_RenderDrawLine(screen->renderer,x,screen->height,x,screen->height-y);
    
    SDL_RenderPresent(screen->renderer);

}

#endif