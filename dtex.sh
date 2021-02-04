#! /bin/bash


# DETEX - Text db administrator
#
# Author - Felbs

#  ---------- [ Configuration ] ----------
SEP=:
TEMP=temp.$$
 
#  ---------------------------------------


# first, we need to define a variable called DATA

[ "$DATA" ] || {
	echo "We need data to work with. use the variable DATA"
	return 1
}


# making a function that will check if given key already exists in DATA

has_key() {

grep -i -q "^$1$SEP"  "$DATA"

}

# also a function that returns DATAs fields, usually in the first line of textual database

fields() {

head -n 1 "$DATA" | tr $SEP \\n 

}


# this one will add new data to textual database DATA.

ad() {

	local key=$(echo "$1" | cut -d $SEP -f1)  # defining 'key' for further process.

	if has_key "$key"; then                   # the key has to be unique

		echo "this key already exists"    # if not unique ..
		return 1
	else
		echo "$*" >> "$DATA"              # if unique, append new key into textual database
		echo " key added succesfuly"
	fi

	return 0
}


# a getter function, so we may list textual db content

gd(){

	case $1 in                                                           # defining command line options


		-k | --key) local data=$( grep -i "^$2$SEP" "$DATA" )        # key one, so we can specify or ..

			local i=0

			[ "$data" ] || return

			fields | while read field; do

				i=$((i+1))

				echo -n "$field: "
				echo "$data" | cut -d $SEP -f $i

			done
		;;

		-a | --all) cat "$DATA" | grep -i -v $(head -n 1 "$DATA")    # just give me them all !
		;;

		-c | --collumn)                                               # this option outputs a single column,
                                                                             # just specify index like "gd -c 1"

			n=0

			head_list=$(head -n 1 $DATA | sed "s/$SEP/ /g") # separating fields ..

			headers=($head_list)                            # putting it into a list

			for header in $head_list; do                    # this will count how many fields we have

				n=$((n+1))                              # counting ..
			done

			if [ "$2" ]; then

				cat "$DATA" | cut -d"$SEP" -f"$2"
			else

				echo "we have $n headers, they are ${headers[*]} (you may choose by index starting from 1)"

			fi
		;;

	esac
}


# and a delete one

rd(){

	has_key "$1" || return                  # key exists? if so, go ahead. Otherwise, dont try 

	grep -i -v "^$1$SEP" "$DATA" > "$TEMP"  # getting the one to be deleted
	mv "$TEMP" "$DATA"                      # refresh $DATA
	echo "$1 was deleted succesfuly"

	return 0

}
