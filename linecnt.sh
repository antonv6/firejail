#!/bin/bash

gcov_init() {
	USER=`whoami`
	firejail --help > /dev/null
	firemon --help > /dev/null
	/usr/lib/firejail/fnet --help > /dev/null
	/usr/lib/firejail/fseccomp --help > /dev/null
	firecfg --help > /dev/null

	/usr/lib/firejail/fnetfilter --help > /dev/null
	/usr/lib/firejail/fsec-print --help > /dev/null
	/usr/lib/firejail/fsec-optimize --help > /dev/null

	sudo chown $USER:$USER `find .`
}

rm -fr gcov-dir
gcov_init
lcov -q --capture -d src/firejail -d src/firemon \
	-d  src/fnetfilter -d src/fsec-print -d src/fsec-optimize -d src/fseccomp \
	-d src/fnet -d src/lib -d src/firecfg --output-file gcov-file
genhtml -q gcov-file --output-directory gcov-dir
