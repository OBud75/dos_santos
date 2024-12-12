#ifndef EXERCICES_H
#define EXERCICES_H

#include <stddef.h>

typedef struct Person {
  int age;
} Person;

int are_persons_equals(Person *p1, Person *p2);

typedef struct Book {
  int pages;
} Book;

int are_books_equals(Book *b1, Book *b2);

int are_equals(void *obj1, void *obj2, int (*compare_fnc)(void *, void *));

int is_in_array(void *obj_to_find,
                void *array,
                int nb_of_elems_in_array,
                size_t elem_size,
                int (*compare_fnc)(void *, void *));

void swap(void *obj1, void *obj2, size_t size);

int is_greater(void *obj1, void *obj2);

void sort(void *array, int nb_of_elems_in_array, size_t elem_size, int (*compare_fnc)(void *, void *), void (*swap_fnc)(void *, void *, size_t));

#endif // EXERCICES_H
