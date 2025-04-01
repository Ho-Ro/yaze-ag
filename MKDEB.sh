#!/bin/sh

make clean \
&& make -j \
&& fakeroot checkinstall --install=no --backup=no --pkggroup=development
