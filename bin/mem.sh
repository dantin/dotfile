#!/usr/bin/env bash

# $ free -m
#              total       used       free     shared    buffers     cached
# Mem:          7976       6459       1517          0        865       2248
# -/+ buffers/cache:       3344       4631
# Swap:         1951          0       1951

free | grep Mem | awk '{ printf("use: %.4f %, free: %.4f %\n", $3/$2 * 100.0, $4/$2 * 100.0) }'
