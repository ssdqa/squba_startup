# SQUBA Startup Example Repository

This repository is intended to be a functional example of how to utilize the
SQUBA modules. A synthetic dataset in an OMOP format ([synthea_cdm](synthea_cdm)) and accompanying concept 
sets ([synthea_specs](synthea_specs)) are provided to facilitate the execution of the example code.

After pulling down this repository, make sure to open the [squba_startup.Rproj](squba_startup.Rproj)
file. This will ensure that the working directory is set appropriately.

## Getting Started

Connecting to a database via the [setup.R](setup.R) file is the first step required to 
utilize this repository. For your convenience, we have provided functionality
to load the synthetic CDM data to an in-memory SQLite database. To get started
with this method, load the required packages and execute [lines 22-34](setup.R#L22-L34) of setup.R.

If you would rather connect to your own database, please see the [database
connection documentation](documentation) for a detailed explanation of how you can establish
that connection. There are sample configuration files included in the
[config_templates](config_templates) subdirectory. After deciding on your connection method, [insert the
name](setup.R#L46) of the schema where the CDM data (either synthetic or your own) can be found. Then execute [lines
39-46](setup.R#L39-L46) to establish the connection.

## Sample Module Execution

The [squba_example.R](squba_example.R) file contains a walkthrough of how you can build all of
the appropriate inputs and execute one of the SQUBA modules. This includes
the patient cohort, the study-specific input file, and the parameter
configurations. To learn more about the specific configurations available for
this module and others, please see our [metadata repository](https://pedsnet.org/metadata/handle/20.500.14642/2).

This same process can be followed for the other SQUBA modules, though the 
requirements for the study-specific input file will vary based on the 
analytic requirements of the module. 

## Questions and Feedback 

If you have any questions or feedback about this or any of the other SQUBA materials, please do not hesitate to reach out!
You can submit an issue in this repository or the appropriate module repository, or you can email wieandk@chop.edu.

