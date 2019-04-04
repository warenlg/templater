clean:
	rm -rf *.pyc **/*.pyc reg_settings* .coverage MANIFEST build/ dist/ \
	       _templater.*so readme.html
init:
	pip install --user --upgrade pipenv
	pipenv --python 3.6
	pipenv install --dev

build:
	pipenv run python setup.py build_ext --inplace
	pipenv run python setup.py build

install:
	pipenv run python setup.py install

pylint:
	pipenv run pylint templater.py examples

test: clean build
	pipenv run pytest

cov: clean build
	pipenv run pytest --cov-report term-missing --cov=. tests

sdist: clean test
	pipenv run python setup.py sdist

upload:	clean test
	pipenv run python setup.py sdist upload
	make clean

readme:
	rst2html README.rst > readme.html

.PHONY:	clean build install test sdist upload readme
