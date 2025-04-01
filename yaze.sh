#!/bin/sh

HOME_CPM="$HOME/cpm"

S_YAZEFILES=/usr/local/lib/yaze
S_CPMDSKS=/usr/local/lib/yaze/disks
S_DOCFILES=/usr/local/lib/yaze/doc
S_DOCFILES_html=/usr/local/lib/yaze/doc_html

if [ ! -f .yazerc ]
then
  if [ ! -d $HOME_CPM ]
  then
    echo
    echo Creating $HOME_CPM ...
    echo
    mkdir $HOME_CPM
    echo "copy $S_CPMDSKS/yazerc  to  $HOME_CPM/.yazerc"
    cp $S_CPMDSKS/yazerc $HOME_CPM/.yazerc
    echo
    echo "copy $S_YAZEFILES/*.ktt  to  $HOME_CPM/"
    echo
    cp -v $S_YAZEFILES/*.ktt $HOME_CPM
    echo
    echo "Install some yaze-disks to run CP/M 3.1 ..."
    echo
    for ydsk in $S_CPMDSKS/*.gz ; do
	echo -n "`basename $ydsk .gz`	<----	"
	gzip -vdc $ydsk >$HOME_CPM/`basename $ydsk .gz`
    done
    cd $HOME_CPM
    tar xf disksort.tar
    rm disksort.tar
    echo
    read -p "Pause press enter to continue ... "
    echo
    echo
    echo "Creating $HOME_CPM/doc ... (Here is the complete documentation)"
    echo
    mkdir $HOME_CPM/doc
    for dfile in $S_DOCFILES/* ; do
	echo "set link for `basename $dfile`"
	# gzip -vdc $dfile >$HOME_CPM/doc/`basename $dfile`
	ln -f -s $dfile $HOME_CPM/doc/`basename $dfile`
    done
    echo
    read -p "Pause press enter to continue ... "
    echo
    echo "Creating $HOME_CPM/doc_html ... (Here is the complete documentation in HTML)"
    echo "............................... (Klick on the file index.html)"
    echo
    mkdir $HOME_CPM/doc_html
    for dfile in $S_DOCFILES_html/* ; do
	echo "set link for `basename $dfile`"
	# gzip -vdc $dfile >$HOME_CPM/doc_html/`basename $dfile`
	ln -f -s $dfile $HOME_CPM/doc_html/`basename $dfile`
    done
    echo
    echo "Have a look also to \"man yaze\" and \"man cdm\""
    echo
    echo -n "syncing..."
    sync
    echo "ok"
    read -p "Pause press enter to continue ... "
  fi
  cd $HOME_CPM
  if [ ! -f .yazerc ]
  then
    echo
    echo "$HOME_CPM exists but"
    echo "$HOME_CPM/.yazerc is not presend --> do not run yaze_bin !!!"
    echo
    echo "Read yaze(1) and yaze.doc and write a .yazerc !!!"
    echo "You can use $S_CPMDSKS/yazerc as a pattern."
    echo
    echo "Or you can remove $HOME_CPM complete and restart with \"yaze\"."
    echo
    exit 1
  fi
fi

echo
echo pwd=`pwd`

if [ -f yaze_bin ]
then
   echo "starting ./yaze_bin $*"
   exec ./yaze_bin $*
else
   echo "starting yaze_bin $*"
   exec yaze_bin $*
fi
