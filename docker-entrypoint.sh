#!/bin/bash

set -e
shopt -s extglob

print_usage() {
  echo "Usage:"
  echo "  build [branch]          Builds a Freetz image from [branch]"
  echo "    --no-menuconfig         Do not start menuconfig"
  echo "                            This is only possible if there already"
  echo "                            exists a .config file in the root directory."
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
  test "$#" -ge 1 || error "no branch specified"
  rev=$1
  shift

  umask 0022
  svn checkout "http://svn.freetz.org/$rev" /freetz

  echo "apply patches..."
  for p in /patches/*.patch; do
    [ -f "$p" ] || continue
    echo "  applying $p"
    patch -p1 < "$p"
  done

  if test -e /.config; then
    echo "found .config file"
    cp /.config .
    make oldconfig
  fi

  menuconfig "$@"
  test -e .config || error "no .config file found"
  make
}

menuconfig() {
  if [[ "$*" == *--no-menuconfig* ]]; then
    echo "skipping menuconfig: --no-menuconfig is set"
    return
  fi
  echo "starting menuconfig"
  make menuconfig
}

main() {
  test "$#" -ne 0 || error
  cmd="$1"
  shift

  case $cmd in
    build)
      build "$@"
      ;;
    help)
      print_usage
      ;;
    *)
      exec "$cmd" "$@"
      ;;
  esac
}

main "$@"
