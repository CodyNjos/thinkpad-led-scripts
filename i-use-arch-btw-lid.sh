#!/bin/bash
# Morse code: "i use arch btw" on the ThinkPad logo LED

LED="/sys/class/leds/tpacpi::lid_logo_dot/brightness"

function off {
    echo 0 | sudo tee $LED > /dev/null
}

function on {
    echo 255 | sudo tee $LED > /dev/null
}

function dot {
    on
    sleep 0.2
    off
    sleep 0.2
}

function dash {
    on
    sleep 0.6
    off
    sleep 0.2
}

function letter_gap {
    sleep 0.4  # Total 0.6s with the 0.2s from last dot/dash
}

function word_gap {
    sleep 1.4  # Total 2s with the 0.2s from last dot/dash
}

# I: ..
function i {
    dot
    dot
    letter_gap
}

# U: ..-
function u {
    dot
    dot
    dash
    letter_gap
}

# S: ...
function s {
    dot
    dot
    dot
    letter_gap
}

# E: .
function e {
    dot
    letter_gap
}

# A: .-
function a {
    dot
    dash
    letter_gap
}

# R: .-.
function r {
    dot
    dash
    dot
    letter_gap
}

# C: -.-.
function c {
    dash
    dot
    dash
    dot
    letter_gap
}

# H: ....
function h {
    dot
    dot
    dot
    dot
    letter_gap
}

# B: -...
function b {
    dash
    dot
    dot
    dot
    letter_gap
}

# T: -
function t {
    dash
    letter_gap
}

# W: .--
function w {
    dot
    dash
    dash
    letter_gap
}

# Main sequence
while true; do
    # "i"
    i
    word_gap
    
    # "use"
    u
    s
    e
    word_gap
    
    # "arch"
    a
    r
    c
    h
    word_gap
    
    # "btw"
    b
    t
    w
    word_gap
    
    # Longer pause before repeating
    sleep 3
done