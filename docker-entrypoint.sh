#!/bin/bash

set -e
shopt -s extglob

print_usage() {
  echo "Usage:"
  echo "  build [branch]          Builds a Freetz image from [branch]"
  echo "  clean                   Removes build output"
  echo "  help                    Prints this usage information"
  echo "  [cmd] [args...]         Runs [cmd] with given arguments"
}

error() {
  if test "$#" -eq 1; then
    >&2 echo "$1"
    >&2 echo
  fi
  >&2 print_usage
  exit 1
}

clean() {
  rm -rf !(images)
  rm -rf images/*
}

build() {
  test "$#" -eq 1 || error "no branch specified"

  umask 0022
  svn checkout "http://svn.freetz.org/$1" /freetz
  if test -e /.config; then
    echo "found .config file"
    cp /.config .
    make oldconfig
  else
    echo "no .config file found"
    echo "starting menuconfig"
    make menuconfig
  fi
  make
}

main() {
  test "$#" -ne 0 || error

  case $1 in
    build)
      build "$2"
      ;;
    help)
      print_usage
      ;;
    *)
      exec "$@"
      ;;
  esac
}

main "$@"
