#!/bin/bash

for i in file*.txt; do 
	new_name="new_${i}"
	mv "$i" "$new_name"
done
