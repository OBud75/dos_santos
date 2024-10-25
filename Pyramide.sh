#!/bin/bash

echo -n  "Entrez un nombre : "
read nombre

for ((i = 0; i < $nombre; i++)); do 
	for ((j = 0; j < $i; j++)); do
		echo -n "* "
	done
	echo
done

