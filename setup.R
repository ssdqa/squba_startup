
library(argos)
library(srcr)
library(squba.gen)
library(squba)
library(dplyr)

#' The first step in using SQUBA is connecting to your database of choice.
#' This repository contains a function that will load the synthetic data into an
#' in-memory SQLite database, or you can load it into your own database.
#' 
#' Please see [documentation/database_connection.R] for more detailed
#' information on how to connect to your database. Sample configuration
#' files for popular database systems are included in the `config_template/`
#' subdirectory.


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
