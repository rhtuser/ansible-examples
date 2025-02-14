#!/bin/bash

VALUE=$((RANDOM % 3))

echo "The value we're dealing with is ${VALUE}"

case ${VALUE} in
    0)
	echo "All is good."
	exit 0
	;;

    1)
	echo "Not everything was good, but we fixed it."
	exit 0
	;;

    2)
	echo "Oh my!" >&2
	exit 0
esac

