# Brain/Circulation Model Developer Docker

*This repository contains the Dockerfile for the BCMD framework described below. All dependencies etc. are dowloaded by the file and the required BCMD files are cloned from Github as opposed to added via the context of the Docker image. It currently only works via a command line interface, but future adaptations will aim to add the GUI functionality.*

BCMD is a system for defining and solving differential algebraic equation-based models, in particular for the modelling of cerebral physiology. Models are defined in a simple text language, which is then compiled into a commmand-line application using the RADAU5 DAE solver of Hairer & Wanner.

BCMD is largely written in Python 2.7, but models are translated to C and linked against a Fortran library so compilers for both languages are required, along with a functioning Make system. The software is mainly intended for Unix-like operating systems like Linux and Mac OS X, but it can be run under Microsoft Windows using MinGW and MSYS.

An extensive, if not necessarily readable, manual can be found in the `doc` directory. There are also possibly-useful README documents in the `examples` and `util` directories.
