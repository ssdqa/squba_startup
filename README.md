# SQUBA Startup Example Repository

This repository is intended to be a functional example of how to utilize the
SQUBA modules. A synthetic dataset in an OMOP format and accompanying concept 
sets are provided to facilitate the execution of the example code.

After pulling down this repository, make sure to open the squba_startup.Rproj
file. This will ensure that the working directory is set appropriately.

## Getting Started

Connecting to a database via the setup.R file is the first step required to 
utilize this repository. For your convenience, we have provided functionality
to load the synthetic CDM data to an in-memory SQLite database. To get started
with this method, load the required packages and execute lines 22-34 of setup.R.

If you would rather connect to your own database, please see the database
connection documentation for a detailed explanation of how you can establish
that connection. There are sample configuration files included in the
config_templates subdirectory.

## Sample Module

The squba_example.R file contains a walkthrough of how you can build all of
the appropriate inputs and execute one of the SQUBA modules. This includes
the patient cohort, the study-specific input file, and the parameter
configurations. To learn more about the specific configurations available for
this module and others, please see our metadata repository.

This same process can be followed for the other SQUBA modules, though the 
requirements for the study-specific input file will vary based on the 
analytic requirements of the module.

