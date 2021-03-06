build: clean cudd install test

sdist_test:
	make clean
	python setup.py sdist --cudd --buddy
	cd dist; \
	pip install dd*.tar.gz; \
	tar -zxf dd*.tar.gz
	pip install nose rednose
	rtests.py --rednose

sdist_test_cudd:
	make clean
	pip install cython ply
	python setup.py sdist --cudd --buddy
	yes | pip uninstall cython ply
	cd dist; \
	tar -zxf dd*.tar.gz; \
	cd dd*; \
	python setup.py install --fetch --cudd
	pip install nose rednose
	rtests.py --rednose

install:
	python setup.py install --cudd

reinstall:
	-yes | pip uninstall dd
	python setup.py install --cudd

develop:
	python setup.py develop

test:
	rtests.py

cudd:
	cd cudd-2.5.1; \
	make build XCFLAGS="-fPIC -mtune=native -DHAVE_IEEE_754 -DBSD -DSIZEOF_VOID_P=8 -DSIZEOF_LONG=8"


.PHONY: clean_all clean_cudd clean rm_cudd

clean_all: clean_cudd clean

clean_cudd:
	cd cudd-2.5.1; make distclean

clean:
	-rm -rf build/ dist/ dd.egg-info/ dd/*.so dd/*.c dd/*.pyc

rm_cudd:
	-rm -rf cudd*/ cudd*.tar.gz

