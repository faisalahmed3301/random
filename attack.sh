#!/bin/bash

# Configuration
URL="https://shop.bongodigitalbd.com/"
THREADS=4
CONNECTIONS=275
DURATION="15s"
COOLDOWN=10 # Seconds to wait between rounds

# Prompt the user for the number of rounds
read -p "Enter the number of benchmark rounds you want to execute: " ROUNDS

# Validate that the input is a valid positive integer
if ! [[ "$ROUNDS" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: Please enter a valid positive number."
    exit 1
fi

echo "Starting $ROUNDS-round benchmark test for $URL..."

for ((i=1; i<=ROUNDS; i++))
do
    echo "========================================"
    echo "Round $i of $ROUNDS running..."
    echo "========================================"

    # Run wrk with the multi-page Lua script
    wrk -t$THREADS -c$CONNECTIONS -d$DURATION --latency -s multi-pages.lua "$URL"

    if [ $i -lt $ROUNDS ]; then
        echo "Cooling down for ${COOLDOWN}s before next round..."
        sleep $COOLDOWN
    fi
done

echo "All $ROUNDS benchmark rounds completed successfully!"