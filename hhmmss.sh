#!/bin/bash
# -*- coding: utf-8 -*-

function usage
{
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


function main
{
    case "${#times[@]}" in
        0)
            (>&2 usage)
            ;;
        1)
            seconds_to_hh_mm_ss "${times[0]}"
            ;;
        2)
            mm_ss_to_seconds "${times[0]}" "${times[1]}"
            ;;
        3)
            hh_mm_ss_to_seconds "${times[0]}" "${times[1]}" "${times[2]}"
            ;;
    esac
}

function seconds_to_hh_mm_ss
{
    seconds="$1"

    hours="$(echo "scale=0; $seconds / 3600" | bc -l)"
    minutes="$(echo "scale=0; ( $seconds - $hours * 3600 ) / 60" | bc -l)"
    seconds="$(echo "$seconds - (( $hours * 3600 ) + ( $minutes * 60 ))" | bc -l)"

    echo -n "$(printf "%02g" $hours):"
    echo -n "$(printf "%02g" $minutes):"
    echo -n "$(printf "%02g" ${seconds%.*})"
    echo    "$(print_decimals $seconds)"
}

function mm_ss_to_seconds
{
    minutes="$1"
    seconds="$2"

    echo "( $minutes * 60 ) + $seconds" | bc -l
}

function hh_mm_ss_to_seconds
{
    hours="$1"
    minutes="$2"
    seconds="$3"

    echo "( $hours * 3600 ) + ( $minutes * 60 ) + $seconds" | bc -l
}

function print_decimals
{
    seconds="$1"
    if [[ $seconds == *"."* ]]; then
         echo ".${seconds#*.}"
    fi
}

function fatal_message
{
    errorMessage="$1"
    (>&2 echo "FATAL: $errorMessage")
    (>&2 usage)
}

if (( "$#" > 1 )); then
    fatal_message "Too many arguments!"
fi

IFS=':' read -r -a times <<< "$1"

if (( ${#times[@]} > 3 )); then
    fatal_message "Malformed time format!"
fi

main
