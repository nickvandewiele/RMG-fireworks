# RMG-fireworks
Fireworks workflows for RMG-Py testing

Install Fireworks (and its dependencies); visit https://pythonhosted.org/FireWorks/ for
more information.

Some instructions:

1. Update the path to the RMG-fireworks directory in the `rmg.yaml` file.

Replace:
`/path/to/RMG-fireworks`

2. Add the RMG-fireworks workflow:
`lpad rmg.yaml`

3. Run all the FireWorks:
`rlaunch rapidfire`

4. Results will be printed to `~/fw_sims/`. Change it in the `rmg.yaml` file.




