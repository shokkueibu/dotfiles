#! /usr/bin/env python
import sys
from subprocess import call, check_output

# File path
nr_hugepages_filepath = '/proc/sys/vm/nr_hugepages'

def get_hugepages():
	return int(check_output(['cat', nr_hugepages_filepath]).decode("utf-8").rstrip())

if __name__ == '__main__':

	# Get the current value
	current = get_hugepages()

	# Get desired ram size
	if len(sys.argv) > 1:
		desired_ram = int(sys.argv[1])
	else:
		desired_ram = 8192 if current == 0 else 0

	# Convert to pages
	desired_pages = int(desired_ram / 2)

	# Check if we already have the RAM set
	if desired_pages == current:
		print('Hugepages already set to %s' % desired_ram)
		sys.exit(1)
	else:
		print('Current: %s MB ; Setting to %s MB (%s pages)' % (current * 2, desired_ram, desired_pages))

	# Try settign the hugepages to the desired value
	with open(nr_hugepages_filepath, 'r+') as nr_hugepages:
		if current == 0:
			call(['echo', '%s' % desired_pages], stdout=nr_hugepages)
		else:
			call(['echo', '0'], stdout=nr_hugepages)

	# Confirm if the changes went through
	current = get_hugepages()
	diff = desired_pages - int(current)

	# Print result
	if diff:
		print("Failed to set hugepages to %s: current is %s (diff: %s)" % (desired_pages, current, diff))
	else:
		print('Hugepages are set to: %s (%s RAM)' % (current, current * 2))

	sys.exit(0)

