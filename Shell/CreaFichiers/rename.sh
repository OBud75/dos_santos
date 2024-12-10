#!/bin/bash

renamefiles() {
	local from="$1"
        local to="$2"

	for i in $(ls | grep "\.$exten$"); do
        mv "$i" "${i%.$exten}.$new_exten";
done
}


echo -n "Quelle extension voulez vous changer ? : "
read exten

echo -n "Quelle extensions vous voulez : "
read new_exten


renamefiles "$exten" "$new_exten" 
