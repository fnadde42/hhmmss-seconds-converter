#!/bin/bash
# -*- coding: utf-8 -*-

function usage {
    echo -e "\
Usage: hhmmss: The converter between hh:mm:ss and seconds.

             Convert 300 seconds to hh:mm:ss (result: 00:05:00)
               hhmmss 300
             Convert 12 minutes and 30 seconds to seconds (result: 750)
               hhmmss 12:30
             Convert 5 hours, 37 minutes, 12 seconds to seconds (result: 20232)
               hhmmss 5:37:12
"
}


function main() {
    case "${#times[@]}" in
        0)
            (>&2 usage)
            ;;
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

    hours="$(echo "scale=0; $seconds / 3600" | bc -l)"
    minutes="$(echo "scale=0; ( $seconds - $hours * 3600 ) / 60" | bc -l)"
    seconds="$(echo "$seconds - (( $hours * 3600 ) + ( $minutes * 60 ))" | bc -l)"

    echo "$(printf "%02g" $hours):$(printf "%02g" $minutes):$(printf "%02g" $seconds)"
}

function mmss2seconds {
    minutes="$1"
    seconds="$2"

    echo "( $minutes * 60 ) + $seconds" | bc -l
}

function hhmmss2seconds {
    hours="$1"
    minutes="$2"
    seconds="$3"

    echo "( $hours * 3600 ) + ( $minutes * 60 ) + $seconds" | bc -l
}

function fatalMessage {
    errorMessage="$1"
    (>&2 echo "FATAL: $errorMessage")
    (>&2 usage)
}

if (( "$#" > 1 )); then
    fatalMessage "Too many arguments!"
fi

IFS=':' read -r -a times <<< "$1"

if (( ${#times[@]} > 3 )); then
    fatalMessage "Malformed time format!"
fi

main
