
# remotes::install_github('PEDSnet/argos')
# install.packages('srcr')
# remotes::install_github('ssdqa/squba.gen')
# remotes::install_github('ssdqa/expectedvariablespresent')
library(argos)
library(srcr)
library(squba.gen)
library(expectedvariablespresent)
library(dplyr)
library(duckdb)

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

# source helper files
source('helper_functions/duckdb_setup.R')
source('helper_functions/argos_setup.R')

#' `DuckDB Database Setup & Connection`
db_conn <- mk_testdb_omop()

test_session <- argos$new('test_session')$init_session(db_src = db_conn,
                                                       cdm_schema = NA,
                                                       base_dir = getwd(),
                                                       subdirs = list('specs' = 'synthea_specs'))

set_argos_default(test_session)

#' `Local Database Setup & Connection`

db_conn <- 'path to your json file' #or a DBI connection object

test_session <- argos$new('test_session')$init_session(db_src = db_conn,
                                                       cdm_schema = 'my_CDM_schema', # the name of the schema on your DB where the CDM data is located
                                                       results_schema = 'my_results_schema',
                                                       base_dir = getwd(),
                                                       subdirs = list('specs' = 'synthea_specs'))

set_argos_default(test_session)
