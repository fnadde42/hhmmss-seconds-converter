#!/bin/bash

source hhmmss.sh >/dev/null 2>&1

function test_seconds_to_hh_mm_ss {
    assertEquals '300 seconds returns 00:05:00' "00:05:00" "$(seconds2hhmmss "300")"
    assertEquals '1 second returns 00:00:01' "00:00:01" "$(seconds2hhmmss "1")"
    assertEquals '0 seconds returns 00:00:00' "00:00:00" "$(seconds2hhmmss "0")"
    assertEquals '3600 seconds returns 01:00:00' "01:00:00" "$(seconds2hhmmss "3600")"
    assertEquals '1.5 seconds returns 00:00:01.5' "00:00:01.5" "$(seconds2hhmmss "1.5")"
    assertEquals '1234.56789 seconds returns 00:20:34.56789' "00:20:34.56789" "$(seconds2hhmmss "1234.56789")"
    assertEquals '1234567890 seconds returns 342935:31:30' "342935:31:30" "$(seconds2hhmmss "1234567890")"
}

function test_application {
    assertEquals '300 seconds returns 00:05:00' "00:05:00" "$(./hhmmss.sh "300")"
    assertEquals '1 second returns 00:00:01' "00:00:01" "$(./hhmmss.sh "1")"
    assertEquals '0 seconds returns 00:00:00' "00:00:00" "$(./hhmmss.sh "0")"
    assertEquals '3600 seconds returns 01:00:00' "01:00:00" "$(./hhmmss.sh "3600")"
    assertEquals '1.5 seconds returns 00:00:01.5' "00:00:01.5" "$(./hhmmss.sh "1.5")"
    assertEquals '1234.56789 seconds returns 00:20:34.56789' "00:20:34.56789" "$(./hhmmss.sh "1234.56789")"
    assertEquals '1234567890 seconds returns 342935:31:30' "342935:31:30" "$(./hhmmss.sh "1234567890")"
}
source lib/shunit2
