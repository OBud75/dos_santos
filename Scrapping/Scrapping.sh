#!/bin/bash

curl -s https://readi.fi/sitemap.xml -o Scrapping.txt

if [ -s Scrapping.txt ]; then
	grep -o 'https://readi\.fi/asset[^<]*' Scrapping.txt > Scrap.txt
fi
