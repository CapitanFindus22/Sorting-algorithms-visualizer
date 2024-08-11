#include <stdlib.h>

char draw = 1;

typedef struct 
{
    int *array;
    size_t size;

}Arguments;

void *SelectionSort(void*);

void *SelectionSort(void *args) {

    Arguments *arguments = (Arguments*)args;

    int *array = (int*)arguments->array;
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

        draw = 1;

        while (draw){}

    }

    return NULL;

}
