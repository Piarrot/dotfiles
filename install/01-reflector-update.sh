#!/bin/bash

sudo reflector \
    --fastest 30 \
    --latest 10 \
    --score 5 \
    --sort rate \
    --save /etc/pacman.d/mirrorlist