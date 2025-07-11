
# devtools::install_github('PEDSnet/argos')
# install.packages('srcr')
# devtools::install_github('ssdqa/squba.gen')
# devtools::install_github('ssdqa/expectedvariablespresent')
library(argos)
library(srcr)
library(squba.gen)
library(expectedvariablespresent)
library(dplyr)

#' The first step in using SQUBA is connecting to your database of choice.
#' This repository contains a function that will load the synthetic data into an
#' in-memory SQLite database, or you can load it into your own database.
#' 
#' Please see [documentation/database_connection.R] for more detailed
#' information on how to connect to your database. Sample configuration
#' files for popular database systems are included in the `config_template/`
#' subdirectory.

# Unzip compressed CDM files
unzip(zipfile = 'synthea_cdm/synthea_cdm_csvs.zip',
      exdir = 'synthea_cdm/')

#' `SQLite Database Setup & Connection`
source('helper_functions/sqlite_setup.R')
db_conn <- mk_testdb_omop()

initialize_dq_session(session_name = 'squba_test',
                      working_directory = getwd(),
                      db_conn = db_conn,
                      is_json = FALSE,
                      file_subdirectory = 'synthea_specs',
                      cdm_schema = NA)


#' `Local Database Setup & Connection`

db_conn <- 'path to your json file' #or a DBI connection object

initialize_dq_session(session_name = 'squba_test',
                      working_directory = getwd(),
                      db_conn = db_conn,
                      is_json = FALSE,
                      file_subdirectory = 'synthea_specs',
                      cdm_schema = 'my_CDM_schema') # the name of the schema on your DB where the CDM data is located
