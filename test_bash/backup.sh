#!/bin/bash

sudo mkdir -p backup
sudo chown gr1nch:gr1nch ./backup

current_date=$(date +%F)


for i in *.txt; do
	if [[ -f "$i" ]]; then
		base_name=$(basename "$i" .txt)
		new_name="${base_name}_${current_date}.txt" 
		mv "$i" "./backup/$new_name"
	fi
done 
