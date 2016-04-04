# RMG-fireworks
Fireworks workflows for RMG-Py testing

Install Fireworks (and its dependencies); visit https://pythonhosted.org/FireWorks/ for
more information.

Some instructions:

## Generate the RMG-fireworks workflow input file
`python generate_yaml.py --wd=working_dir --fw=/path/to/RMG-fireworks`

This will generate `rmg.yaml`.

## Add the RMG-fireworks workflow:
`lpad rmg.yaml`

## Run all the FireWorks:
`rlaunch rapidfire`

## Results will be printed to `working_dir`.




