SHELL := /bin/bash

PYTHON_EXE := env/bin/python

.PHONY: clean deep-clean install-dependencies uninstall-dependencies install install-dev run test distclean build

clean:
	rm -rf env
	rm -rf .pytest_cache
	find . -type d -name  "__pycache__" -exec rm -r {} +

deep-clean: clean
	rm -rf tmp

install-dependencies:
	bin/install_dependencies.sh

uninstall-dependencies: clean
	bin/uninstall_dependencies.sh

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
	source env/bin/activate \
		&& pytest

distclean: 
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
	rm -rf tmp

build: install-dependencies clean install distclean