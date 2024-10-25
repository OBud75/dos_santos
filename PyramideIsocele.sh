#!/bin/bash

echo -n "Entrez un nombre : "
read nombre

for ((i = 0; i < nombre; i++)); do 
    for ((j = 0; j < nombre - i - 1; j++)); do
        echo -n " "
    done
    for ((k = 0; k < (i + 1); k++)); do
        echo -n "* "
    done
    echo
done
