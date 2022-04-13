SHELL := /bin/bash

PYTHON_EXE := env/bin/python

.PHONY: dependencies install-docker clean install install-dev run test build

dependencies:
	@#sripts to install project dependencies
	sudo apt-get update
	sudo apt-get install -y software-properties-common
	sudo add-apt-repository ppa:deadsnakes/ppa
	sudo apt-get update
	sudo apt-get install -y make \
		python3.7-dev \
		python3.7-venv \
		python3-pip \
		build-essential

clean:
	rm -rf env
	rm -rf .pytest_cache
	find . -type d -name  "__pycache__" -exec rm -r {} +

install: clean
	python3.7 -m venv env
	${PYTHON_EXE} -m pip install -r requirements.txt

install-dev: clean
	python3.7 -m venv env
	${PYTHON_EXE} -m pip install -r requirements_dev.txt

run:
	source env/bin/activate \
		&& python src/app.py

test:
	pytest

build: install
	rm -rf .pytest_cache
	rm -rf .git
	rm -rf .env.sample
	rm -rf .gitignore
	rm -rf tests
	rm -rf LICENSE
	rm -rf pytest.ini
	rm -rf README.md
	rm -rf requirements.txt
	rm -rf requirements_dev.txt
	rm -rf setup.py