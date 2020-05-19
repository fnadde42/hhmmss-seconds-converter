#!/bin/bash

source hhmmss.sh >/dev/null 2>&1

function test_application
{
    assertEquals '300 seconds returns 00:05:00' "00:05:00" "$(./hhmmss.sh "300")"
    assertEquals '1 second returns 00:00:01' "00:00:01" "$(./hhmmss.sh "1")"
    assertEquals '0 seconds returns 00:00:00' "00:00:00" "$(./hhmmss.sh "0")"
    assertEquals '3600 seconds returns 01:00:00' "01:00:00" "$(./hhmmss.sh "3600")"
    assertEquals '1.5 seconds returns 00:00:01.5' "00:00:01.5" "$(./hhmmss.sh "1.5")"
    assertEquals '1234.56789 seconds returns 00:20:34.56789' "00:20:34.56789" "$(./hhmmss.sh "1234.56789")"
    assertEquals '1234567890 seconds returns 342935:31:30' "342935:31:30" "$(./hhmmss.sh "1234567890")"

    assertEquals '00:05:00 seconds returns 300' "300" "$(./hhmmss.sh "00:05:00")"
    assertEquals '00:00:01 second returns 1' "1" "$(./hhmmss.sh "00:00:01")"
    assertEquals '00:00:00 seconds returns 0' "0" "$(./hhmmss.sh "00:00:00")"
    assertEquals '01:00:00 seconds returns 3600' "3600" "$(./hhmmss.sh "01:00:00")"
    assertEquals '00:00:01.5 seconds returns 1.5' "1.5" "$(./hhmmss.sh "00:00:01.5")"
    assertEquals '00:20:34.56789 seconds returns 1234.56789' "1234.56789" "$(./hhmmss.sh "00:20:34.56789")"
    assertEquals '342935:31:30 seconds returns 1234567890' "1234567890" "$(./hhmmss.sh "342935:31:30")"

    assertEquals '05:00 seconds returns 300' "300" "$(./hhmmss.sh "05:00")"
    assertEquals '00:01 second returns 1' "1" "$(./hhmmss.sh "00:01")"
    assertEquals '00:00 seconds returns 0' "0" "$(./hhmmss.sh "00:00")"
    assertEquals '60:00 seconds returns 3600' "3600" "$(./hhmmss.sh "60:00")"
    assertEquals '99:00 seconds returns 5940' "5940" "$(./hhmmss.sh "99:00")"
    assertEquals '00:01.5 seconds returns 1.5' "1.5" "$(./hhmmss.sh "00:01.5")"
    assertEquals '20:34.56789 seconds returns 1234.56789' "1234.56789" "$(./hhmmss.sh "20:34.56789")"
}

function test_seconds_to_hh_mm_ss
{
    assertEquals '300 seconds returns 00:05:00' "00:05:00" "$(seconds_to_hh_mm_ss "300")"
    assertEquals '1 second returns 00:00:01' "00:00:01" "$(seconds_to_hh_mm_ss "1")"
    assertEquals '0 seconds returns 00:00:00' "00:00:00" "$(seconds_to_hh_mm_ss "0")"
    assertEquals '3600 seconds returns 01:00:00' "01:00:00" "$(seconds_to_hh_mm_ss "3600")"
    assertEquals '1.5 seconds returns 00:00:01.5' "00:00:01.5" "$(seconds_to_hh_mm_ss "1.5")"
    assertEquals '1234.56789 seconds returns 00:20:34.56789' "00:20:34.56789" "$(seconds_to_hh_mm_ss "1234.56789")"
    assertEquals '1234567890 seconds returns 342935:31:30' "342935:31:30" "$(seconds_to_hh_mm_ss "1234567890")"
}

function test_hh_mm_ss_to_seconds
{
    assertEquals '00:05:00 seconds returns 300' "300" "$(hh_mm_ss_to_seconds 00 05 00)"
    assertEquals '00:00:01 second returns 1' "1" "$(hh_mm_ss_to_seconds 00 00 01)"
    assertEquals '00:00:00 seconds returns 0' "0" "$(hh_mm_ss_to_seconds 00 00 00)"
    assertEquals '01:00:00 seconds returns 3600' "3600" "$(hh_mm_ss_to_seconds 01 00 00)"
    assertEquals '00:00:01.5 seconds returns 1.5' "1.5" "$(hh_mm_ss_to_seconds 00 00 01.5)"
    assertEquals '00:20:34.56789 seconds returns 1234.56789' "1234.56789" "$(hh_mm_ss_to_seconds 00 20 34.56789)"
    assertEquals '342935:31:30 seconds returns 1234567890' "1234567890" "$(hh_mm_ss_to_seconds 342935 31 30)"
}

function test_mm_ss_to_seconds
{
    assertEquals '05:00 seconds returns 300' "300" "$(mm_ss_to_seconds 05 00)"
    assertEquals '00:01 second returns 1' "1" "$(mm_ss_to_seconds 00 01)"
    assertEquals '00:00 seconds returns 0' "0" "$(mm_ss_to_seconds 00 00)"
    assertEquals '60:00 seconds returns 3600' "3600" "$(mm_ss_to_seconds 60 00)"
    assertEquals '99:00 seconds returns 5940' "5940" "$(mm_ss_to_seconds 99 00)"
    assertEquals '00:01.5 seconds returns 1.5' "1.5" "$(mm_ss_to_seconds 00 01.5)"
    assertEquals '20:34.56789 seconds returns 1234.56789' "1234.56789" "$(mm_ss_to_seconds 20 34.56789)"
}

source lib/shunit2
