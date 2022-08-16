#!/bin/bash

sudo reflector \
    -l 50 \
    -f 10 \
    --sort rate \
    --save /etc/pacman.d/mirrorlist