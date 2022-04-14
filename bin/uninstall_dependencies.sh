#!/bin/bash

CUR_DIR=$(dirname -- ${BASH_SOURCE[0]})
source ${CUR_DIR}/grab_os.sh

PY_VER=3.7
if [[ $OS = Ubuntu && $VER = 16.* ]]; then
	#remove version binaries
	rm -rf /usr/local/bin/python${PY_VER}
	rm -rf /usr/local/bin/python${PY_VER}m
	rm -rf /usr/local/bin/pyvenv-${PY_VER}
	rm -rf /usr/local/bin/2to3-${PY_VER}
	rm -rf /usr/local/bin/idle${PY_VER}
	rm -rf /usr/local/bin/pydoc${PY_VER}
	rm -rf /usr/local/bin/easy_install-${PY_VER}
	rm -rf /usr/local/bin/pip${PY_VER}
	rm -rf /usr/local/bin/python${PY_VER}-config
	rm -rf /usr/local/bin/python${PY_VER}m-config

	#remove symbolicly linked binaries
	rm -rf /usr/local/bin/python3
	rm -rf /usr/local/bin/pyvenv
	rm -rf /usr/local/bin/2to3
	rm -rf /usr/local/bin/idle3
	rm -rf /usr/local/bin/pydoc3
	rm -rf /usr/local/bin/python3-config

	#relink binaraies
	F=$(ls -t /usr/local/bin/python3* 2>/dev/null | head -1)
	if [ ! -z $F ]; then
		ln -s $F /usr/local/bin/python3
	fi
	F=$(ls -t /usr/local/bin/pyenv* 2>/dev/null | head -1)
	if [ ! -z $F ]; then
		ln -s $F /usr/local/bin/pyenv
	fi
	F=$(ls -t /usr/local/bin/2to3-* 2>/dev/null | head -1)
	if [ ! -z $F ]; then
		ln -s $F /usr/local/bin/2to3
	fi
	F=$(ls -t /usr/local/bin/idle3* 2>/dev/null | head -1)
	if [ ! -z $F ]; then
		ln -s $F /usr/local/bin/idle3
	fi
	F=$(ls -t /usr/local/bin/pydoc3* 2>/dev/null | head -1)
	if [ ! -z $F ]; then
		ln -s $F /usr/local/bin/pydoc3
	fi
	F=$(ls -t /usr/local/bin/python3*m-config 2>/dev/null | head -1)
	FALT=$(ls -t /usr/local/bin/python3*-config 2>/dev/null | head -1)
	if [ ! -z $F ]; then
		[[ $F =~ python(3[.][0-9]+)m-config ]]
		FALT=/usr/local/bin/python${BASH_REMATCH[1]}-config
		ln -s $F $FALT
		ln -s $FALT /usr/local/bin/python3-config
	elif [ ! -z $FALT ]; then
		ln -s $FALT /usr/local/bin/python3-config
	fi

	#remove package configs
	rm -rf /usr/local/lib/pkgconfig/python-3.7m.pc
	rm -rf /usr/local/lib/pkgconfig/python-3.7.pc

	#remove symbolicly linked package configs
	rm -rf /usr/local/lib/pkgconfig/python3.pc

	#relink package configs
	F=$(ls -t /usr/local/lib/pkgconfig/python-3*m.pc 2>/dev/null | head -1)
	FALT=$(ls -t /usr/local/lib/pkgconfig/python-3*.pc 2>/dev/null | head -1)
	if [ ! -z $F ]; then
		[[ $F =~ python-(3[.][0-9]+)m.pc ]]
		FALT=/usr/local/bin/python-${BASH_REMATCH[1]}.pc
		ln -s $F $FALT
		ln -s $FALT /usr/local/bin/python3.pc
	elif [ ! -z $FALT ]; then
		ln -s $FALT /usr/local/bin/python3.pc
	fi

	#remove lib
	rm -rf /usr/local/lib/python${PY_VER}
elif [[ $OS = Ubuntu && $VER = 18.* ]]; then
	sudo apt-get remove -y python3.7 \
		python3.7-dev \
		python3.7-venv
	sudo apt-get autoremove
elif [[ $OS = Ubuntu && $VER = 20.* ]]; then
	sudo apt-get remove -y python3.7 \
		python3.7-dev \
		python3.7-venv
	sudo apt-get autoremove
fi