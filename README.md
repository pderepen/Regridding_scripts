# Regridding Scripts

This repository contains Jupyter Notebooks that are used to regrid CESM data between different grids.

## Instructions

TBD

## Python environment

To be able to run the different Python scripts in this repository, you'll need to install a few packages. I recommend creating a new, clean environment to avoid any dependency issues.

To do so using Conda:

   * Create a new envrionment (in this case named regrid_env) 
      ```
      conda create -n regrid_env python=3.7
      ```
   * Activate your new environment
      ```
      conda activate regrid_env
      ```
   * Install the xESMF package
      ```
      conda install -c conda-forge xesmf
      ```
   * Install dask and netCDF4 to support all features in xESMF
      ```
      conda install -c conda-forge dask netCDF4
      ```
   * Install plotting and notebook dependencies (optional)
      ```
      conda install -c conda-forge matplotlib cartopy jupyterlab
      ```

For more information, check out the xESMF installation webpage: <https://xesmf.readthedocs.io/en/latest/installation.html>

Alternatively, you can download the environment file regrid_env.yml from this repository and create a new environment from that file directly.

```
conda env create -f regrid_env.yml
```

## Installing Python on your local machine

Python is usually already installed on your machine. To check, type `python --version` in a terminal.

Here are 3 different methods to install Python:

1. Instally Python manually (<https://www.python.org/downloads/>):

   * This will get you the latest version of Python3
   * You will now need to use the command `python3` instead of `python` (unless you create an alias by adding the line `alias python=python3` in your .bash_profile)

2. Installing Python using Anaconda (<https://www.anaconda.com/products/individual>):

   * Anaconda is a data science platform by Continuum Analytics that comes with a lot of useful features right out of the box
   * Many people find that installing Python through Anaconda is much easier than doing so manually (see method #1 above)
   * Anaconda comes with Conda, which is Continuum's package, dependency and environment manager (analogous to pip for Python)
   * The libraries and packages included in Anaconda are usually related to data science (numpy, scipy, jupyter notebooks, etc.)
   * Benefits:
       + Simplify common problems
       + Great for use in the classroom as it provides each student with the same setup

3. Installing Python using Miniconda (<https://docs.conda.io/en/latest/miniconda.html>):

   * Miniconda is a free minimal installer for conda
   * Good if hard drive space is an issue for you
   * It is a small bootstrapped version of Anaconda that comes with the Python distribution, essential packages, and conda.
