#!/bin/bash

echo -n "Ecrivez un nombre : "
read nombre

for ((i = 0; i < nombre + 1; i++)); do
	echo $i "x" $i = $((i*nombre))
done 
