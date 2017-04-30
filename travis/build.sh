#!/bin/bash

case "$TRAVIS_OS_NAME" in
  linux)
    export CC=/usr/bin/gcc-6
    export CXX=/usr/bin/g++-6
    
    QT_ENV_SCRIPT=$(find /opt -name 'qt*-env.sh')
    source $QT_ENV_SCRIPT
    export LD_LIBRARY_PATH="/usr/lib64:$LD_LIBRARY_PATH"
   
    qmake 
    make -j2
  ;;

  osx)
    export PATH=$PATH:$(dirname $(find /usr/local/Cellar/qt5 -name qmake) )

    qmake
    make -j2
  ;;
esac
