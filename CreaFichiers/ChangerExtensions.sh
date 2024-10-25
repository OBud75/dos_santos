#!/bin/bash

for file in *.txt; do 
    base="${file%.txt}"
    mv "$file" "${base}.jpg"
done
