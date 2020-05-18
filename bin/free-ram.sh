#!/bin/bash

# Flush file system buffers by executing
sync

# Free page cache
sudo sh -c "echo 1 > /proc/sys/vm/drop_caches"

# Free dentries and inodes
sudo sh -c "echo 2 > /proc/sys/vm/drop_caches"

# Free page cache, dentries and inodes
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"

