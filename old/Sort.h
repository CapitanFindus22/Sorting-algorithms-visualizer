#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

#define DELAY 1900

bool draw = false;

//Struct used to pass the array to the functions (as thread)
typedef struct
{
    int *array;
    size_t size;

} Arguments;

void *SelectionSort(void *);
void *Combsort(void *);
static void Delay(int);

//Delay used to make changes visible
static void Delay(int milliseconds)
{
    clock_t start_time = clock();

    // looping till required time is not achieved
    while (clock() < start_time + milliseconds){}
}

void *SelectionSort(void *args)
{

    Arguments *arguments = (Arguments *)args;

    int *array = (int *)arguments->array;
    size_t size = (size_t)arguments->size;

    int temp;

    for (int i = 0; i < size - 1; i++)
    {
        int min = i;
        for (int j = i + 1; j < size; j++)
        {
            if (array[min] > array[j])
            {
                min = j;
            }
        }

        if (min != i)
        {
            temp = array[i];
            array[i] = array[min];
            array[min] = temp;
        }

        draw = true;
        Delay(DELAY);
    }

    return NULL;
}

void *Combsort(void *args)
{

    const float SHRINK = 1.247330950103979;

    Arguments *arguments = (Arguments *)args;

    int *array = (int *)arguments->array;
    size_t size = (size_t)arguments->size;

    int gap = size;

    while (gap > 1) // gap = 1 means that the array is sorted
    {
        gap = gap / SHRINK;
        int i = 0;
        while ((i + gap) < size)
        { // similiar to the Shell Sort
            if (array[i] > array[i + gap])
            {
                int tmp = array[i];
                array[i] = array[i + gap];
                array[i + gap] = tmp;

                draw = true;
                Delay(DELAY);
            }
            i++;
        }
    }

    return NULL;
}