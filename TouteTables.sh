#!/bin/bash


for i in {1..10}; do
	for j in {1..10}; do 
	printf "\t%d" $((i * j))
	done
	echo
done
