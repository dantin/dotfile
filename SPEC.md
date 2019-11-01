# Specification

_NOTE_: Some of the tools are still under developing.

## Scripts

Scripts contain useful tool which will help you at development.

### bench.sh

The `bench.sh` collects system information, it also support disk speed test, network latency test, neetwork speed test, etc.

```
Usage: bench.sh <option>

Available options:

-sys           : Displays system information, e.g. CPU, RAM, Disk, IPv4, IPv6, etc.
-io            : Runs disk speed test.
-ping          : Runs network latency test.
-speed         : Runs network speed test.
-h             : Shows help.
No option      : Displays system information will be run.
```
