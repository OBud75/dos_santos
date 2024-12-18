#include "exercice.h"
#include <stdio.h>
#include <string.h>

int are_persons_equals(Person *p1, Person *p2) {
  return p1->age == p2->age;
}

int are_books_equals(Book *b1, Book *b2) {
  return b1->pages == b2->pages;
}

int are_equals(void *obj1, void *obj2, int (*compare_fnc)(void *, void *)) {
  return compare_fnc(obj1, obj2);
}

int is_in_array(void *obj_to_find, void *array, int nb_of_elems_in_array, size_t elem_size, int (*compare_fnc)(void *, void *)) {
  for (int i = 0; i < nb_of_elems_in_array; i++) {
    if (compare_fnc(obj_to_find, (char *)array + i * elem_size)) {
      return 1;
    }
  }
  return 0;
}

void swap(void *a, void *b, size_t size) {
  char temp[size];
  memcpy(temp, a, size);
  memcpy(a, b, size);
  memcpy(b, temp, size);
}

int is_greater(void *obj1, void *obj2) {
  return *(int *)obj1 > *(int *)obj2;
}

void eq_function() {
  Person person1 = {50};
  Person person2 = {0};
  int same_age = are_equals(
    &person1, &person2,
    (int (*)(void *, void *)) are_persons_equals
  );
  if (same_age == 1) { printf("Same age.\n"); }
  else { printf("Not same age.\n"); }
}

void linear_search() {
  Person person1 = {50};
  Person people[] = {{20}, {50}};
  int person_found = is_in_array(
    &person1, people,
    sizeof(people) / sizeof(Person), sizeof(Person),
    (int (*)(void *, void *)) are_persons_equals
  );
  if (person_found == 1) { printf("P1 is in the array.\n"); }
  else { printf("P1 is not in the array.\n"); }

  Book book1 = {50};
  Book books[] = {{20}, {50}};
  int book_found = is_in_array(
    &book1, books,
    sizeof(books) / sizeof(Book), sizeof(Book),
    (int (*)(void *, void *)) are_books_equals
  );
  if (book_found == 1) { printf("B1 is in the array.\n"); }
  else { printf("B1 is not in the array.\n"); }
}

void generic_swap() {
  Person person1 = {50};
  Person person2 = {25};
  swap(&person1, &person2, sizeof(Person));
  printf("After swap: person1 age %d, person2 age %d\n", person1.age, person2.age);

  Book b1 = {50};
  Book b2 = {25};
  swap(&b1, &b2, sizeof(Book));
  printf("After swap: book1 pages %d, book2 pages %d\n", b1.pages, b2.pages);
}

void sort(void *array, int n, size_t size, int (*compare)(void *, void *), void (*swap)(void *, void *, size_t)) {
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (compare((char *)array + j * size, (char *)array + (j + 1) * size)) {
        swap((char *)array + j * size, (char *)array + (j + 1) * size, size);
      }
    }
  }
}

int main() {
  eq_function();
  linear_search();
  generic_swap();

  Person people[] = {{20}, {50}, {188}, {2}};
  sort(
    people,
    sizeof(people) / sizeof(Person),
    sizeof(Person),
    (int (*)(void *, void *)) is_greater,
    swap
  );

  for (int i = 0; i < sizeof(people) / sizeof(Person); i++) {
    printf("Person %d: age %d\n", i, people[i].age);
  }

  return 0;
}
