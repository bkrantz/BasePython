#!/bin/bash

CUR_DIR=$(dirname -- ${BASH_SOURCE[0]})
ROOT_DIR=$(realpath ${CUR_DIR}/..)
TMP_DIR=${ROOT_DIR}/tmp
source ${CUR_DIR}/grab_os.sh

if [[ $OS = Ubuntu && $VER = 16.* ]]; then
	PY_VERS=3.7.13
	PY_FILENAME=Python-${PY_VERS}
	CUR_PY_VERS=$(python3 -V 2>&1 | grep -Po '(?<=Python )(.+)')
	if [[ "$CUR_PY_VERS" != "$PY_VERS" ]]; then
		mkdir -p ${TMP_DIR}
		if [ ! -f ${TMP_DIR}/${PY_FILENAME}.tgz ]; then
			sudo apt-get update
			sudo apt-get install -y software-properties-common
			sudo apt-get update
			wget https://www.python.org/ftp/python/${PY_VERS}/Python-${PY_VERS}.tgz -O ${TMP_DIR}/${PY_FILENAME}.tgz
		fi
		tar -xf ${TMP_DIR}/${PY_FILENAME}.tgz -C tmp
		cd ${TMP_DIR}/${PY_FILENAME}
		./configure --enable-optimization
		sudo make altinstall
		sudo make install
		cd ${ROOT_DIR}
		sudo rm -r ${TMP_DIR}/${PY_FILENAME}
		sudo apt-get install -y make \
			build-essential
	fi
elif [[ $OS = Ubuntu && $VER = 18.* ]]; then
	sudo apt-get update
	sudo apt-get install -y software-properties-common
	sudo apt-get install -y make \
		python3.7 \
		python3.7-dev \
		python3.7-venv \
		python3-pip \
		build-essential
elif [[ $OS = Ubuntu && $VER = 20.* ]]; then
	sudo apt-get update
	sudo apt-get install -y software-properties-common
	sudo add-apt-repository ppa:deadsnakes/ppa
	sudo apt-get update
	sudo apt-get install -y make \
		python3.7-dev \
		python3.7-venv \
		python3-pip \
		build-essential
fi