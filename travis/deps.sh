#!/bin/bash -eux

case "$TRAVIS_OS_NAME" in
  linux)
    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 1397BC53640DB551
    sudo add-apt-repository --yes ppa:ubuntu-toolchain-r/test
    sudo add-apt-repository --yes ppa:beineri/opt-qt58-trusty
    sudo apt-get update -qq
    sudo apt-get install -qq --yes --force-yes g++-6 qt58-meta-minimal 
  ;;
  osx)
    # work around a homebrew bug
    brew install qt5
    brew link --force qt5
  ;;
esac
