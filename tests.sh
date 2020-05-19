#!/bin/bash

source hhmmss.sh

function test_Equality {
    expected="1"
    actual="1"
    assertEquals "$expected" "$actual"
}

source lib/shunit2
