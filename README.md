# Brain/Circulation Model Developer Docker

*This repository contains the Dockerfile for the BCMD framework described below. All dependencies etc. are dowloaded by the file and the required BCMD files are cloned from Github as opposed to added via the context of the Docker image. It currently only works via a command line interface, but future adaptations will aim to add te GUI functionality.*

## Docker ##
This version of BCMD uses Docker to wrap and distribute the software for use. This will ensure that on every platform the software is usable and all dependencies are taken care of. In order to use the Docker container, a Dockerfile has been prepared. To build and then use this, you will first need to download and install Docker from [here](https://docs.docker.com/engine/installation/).

Once you have done this, open terminal/Powershell/cmd and navigate to the cloned repository. Then run

```shell
docker build -t bcmd-docker:latest .
```
To save data and use data on the computer, you will need to use the 'working' directory with the following command. Any data you wish to use with the models must be stored in the ../host_data directory. These can be individual files or child directories.
```shell
docker run -it -v /home/user/path/to/host_data:/BCMD/working bcmd-docker
```

> BCMD is a system for defining and solving differential algebraic equation-based models, in particular for the modelling of cerebral physiology. Models are defined in a simple text language, which is then compiled into a commmand-line application using the RADAU5 DAE solver of Hairer & Wanner.

> BCMD is largely written in Python 2.7, but models are translated to C and linked against a Fortran library so compilers for both languages are required, along with a functioning Make system. The software is mainly intended for Unix-like operating systems like Linux and Mac OS X, but it can be run under Microsoft Windows using MinGW and MSYS.

> An extensive, if not necessarily readable, manual can be found in the `doc` directory. There are also possibly-useful README documents in the `examples` and `util` directories.
