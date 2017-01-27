## README for the Functional Activation tests using BSX

After downloading and running the Dockerfile the following commands can be used in order to fun optimisation tests on the BSX model.
0. Build the docker image using
```shell
docker build --rm --no-cache -t bcmd-docker:latest .
```
1. Make sure that the required datafiles are all present in a folder you can navigate to easily from the command line - from now called `data_files`.
2. Having done this run the following command to start the docker container, linking the directory containing the datafiles on your computer to the `working` directory within the container.
```shell
docker run -it -v /home/user/path/to/data_files:/BCMD/working bcmd-docker
```
3. With a command line interface open to the container, you must make a number of small changes in order to use the files present. (Note: The following commands assume you are at the base `BCMD` directory.)
  a) We begin by moving the parameters list to the batch directory
  ```shell
  cp batch/bsx/bsx_pdist.txt batch
  ```
  b) We then move `bsx.modeldef` to the `examples` directory in order to easily build the model.
  ```shell
  cp examples/bsx/models/bsx.modeldef examples/
  ```
  c) We must then build the bsx model.
  ```
  make build/bsx.model
  ```
4. We now run the `optim_demand.py` file which is able to process a directory of input datafiles using the same `.optjob` specification.
```shell
cd batch
python optim_demand.py bsx/bsxFuncAct.optjob ../working
```
If you have stored the data files in separate directories e.g. by patient or demand magnitude, then the following command changes to
```shell
cd batch
python optim_demand.py bsx/bsxFuncAct.optjob ../working/child_directory
``` 
where `child_directory` is the specific directory of interest.

The above command will attempt to run a global optimisation for all parameters specified within `bsx_pdist.txt`. If you wish to change any of the parameter distributions or the optjob file, nano is installed in the container for simple text editing purposes.
It is used by simply typing `nano path/to/file`. More information on how to use nano can be found [here](https://wiki.gentoo.org/wiki/Nano/Basics_Guide).
The most obvious change would be to the parameters you wish to optimise. This is done by changing the `param_select` field within the `bsxFuncAct.optjob` file from '*' to the names of the parameters of interest.
