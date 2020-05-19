#!/bin/bash
# -*- coding: utf-8 -*-

echo "Args: $@"
IFS=':' read -r -a times <<< "$1"
echo "Array: ${#times[@]}"

if [[ ${#times[@]} -gt 3 ]]; then
	echo "Too many arguments"
	exit 1
fi

function main() {
	case "${#times[@]}" in
		1)
			seconds2hhmmss "${times[0]}"
			;;
		2)
			mmss2seconds "${times[0]}" "${times[1]}"
			;;
		3)
			hhmmss2seconds "${times[0]}" "${times[1]}" "${times[2]}"
			;;
	esac
}

function seconds2hhmmss {
	seconds="$1"

	echo "seconds2hhmmss $@"
	hours="$(echo "scale=0; $seconds / 3600" | bc -l)"
	minutes="$(echo "scale=0; ( $seconds - $hours * 3600 ) / 60" | bc -l)"
	seconds="$(echo "$seconds - (( $hours * 3600 ) + ( $minutes * 60 ))" | bc -l)"

	echo "Format: $(printf "%02g" $hours):$(printf "%02g" $minutes):$(printf "%02g" $seconds)"
}

function mmss2seconds {
	minutes="$1"
	seconds="$2"

	echo "mmss2seconds $@"
	echo "( $minutes * 60 ) + $seconds" | bc -l
}

function hhmmss2seconds {
	hours="$1"
	minutes="$2"
	seconds="$3"

	echo "hhmmss2seconds $@"
	echo "( $hours * 3600 ) + ( $minutes * 60 ) + $seconds" | bc -l
}

main