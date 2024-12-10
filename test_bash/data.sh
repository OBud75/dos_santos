#!/bin/bash

disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [[ $disk_usage -ge 90 ]]; then
	echo -n "Attention espace disque presque plein : ($disk_usage%)"
else
	echo "Tout va bien : ($disk_usage%)"
fi
