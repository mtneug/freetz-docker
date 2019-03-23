# mtneug/freetz

[![Build Status](https://travis-ci.org/mtneug/freetz-docker.svg?branch=master)](https://travis-ci.org/mtneug/freetz-docker) [![](https://images.microbadger.com/badges/version/mtneug/freetz.svg)](https://hub.docker.com/r/mtneug/freetz/) [![](https://images.microbadger.com/badges/image/mtneug/freetz.svg)](http://microbadger.com/images/mtneug/freetz)

This repository holds files for the `mtneug/freetz` Docker image, a [Freetz](https://freetz.org/) image build environment.

## Usage

To build images you either can interactively use the `menuconfig` or a configuration file. Below you find some examples:

```sh
# Build with menuconfig
$ docker run --rm -it -v $PWD/images:/freetz/images mtneug/freetz

# Build with predefined .config
$ docker run --rm -it -v $PWD/images:/freetz/images -v $PWD/config:/.config mtneug/freetz

# Build with patches
# put your .patch files into $PWD/patches
$ docker run --rm -it -v $PWD/patches:/patches -v $PWD/images:/freetz/images mtneug/freetz

# Build tools
$ docker run --rm -it -v $PWD/tools:/freetz/tools mtneug/freetz tools
```

There are also some other commands:

```sh
$ docker run --rm mtneug/freetz help
Usage:
  build [branch]          Builds a Freetz image from [branch]
    --no-menuconfig         Do not start menuconfig
                            This is only possible if there already
                            exists a .config file in the root directory.
  clean                   Removes build output
  help                    Prints this usage information
  [cmd] [args...]         Runs [cmd] with given arguments
```
