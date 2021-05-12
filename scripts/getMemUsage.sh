#!/bin/bash
top -l 1 | head -n 7 | tail -n 1|awk '{printf "%s\n", $2}'
