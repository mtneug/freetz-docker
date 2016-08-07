# mtneug/freetz

This repository holds files for the `mtneug/freetz` Docker image, a [Freetz](https://freetz.org/) image build environment.

## Usage

To build images you either can interactively use the `menuconfig` or a configuration file. Below you find some examples:

```sh
# Build with menuconfig
$ docker run --rm -it -v $PWD/images:/freetz/images mtneug/freetz

# Build with predifined config
$ docker run --rm -it -v $PWD/images:/freetz/images -v $PWD/config:/.config mtneug/freetz
```

There are also some other commands:

```sh
$ docker run --rm mtneug/freetz help
Usage:
  build [branch]          Builds a Freetz image from [branch]
  clean                   Removes build output
  help                    Prints this usage information
  [cmd] [args...]         Runs [cmd] with given arguments
```
