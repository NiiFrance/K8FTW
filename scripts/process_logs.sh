#!/bin/bash

# Extract ERROR logs, format output, and sort by date
awk '/\[ERROR\]/ {print $1, $4}' sample.log | \
sed 's/\[ERROR\]//' | \
sort