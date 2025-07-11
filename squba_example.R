
#' You will first need a cohort of patients to use in the SQUBA modules. This
#' will require the following columns:
#' - `person_id` or `patid`: the unique identifier for the patient
#' - `site`: an identifier for the institution at which the patient is located.
#'           * another variable you may want to group by in a "multi site" analysis 
#'             can also be inserted here, like race or age
#' - `start_date`: the patient's cohort entry date
#' - `end_date`: the patient's cohort exit date
#' 
#' Note that the modules will only look at data in the CDM that falls between 
#' the start and end dates for the patient.

my_cohort <- cdm_tbl('person') %>%
  select(person_id) %>%
  mutate(site = 'my_site',
         start_date = '2000-02-04',
         end_date = '2010-04-07') %>% collect() %>%
  mutate(start_date = as.Date(start_date),
         end_date = as.Date(end_date))

#' Next, you should select the module you would like to execute. All modules and
#' the distinct configurations you could execute are documented in our metadata
#' repository: .
#' 
#' We will use Expected Variables Present as an example here.

#' Each module requires the user to define their input as it relates to their study.
#' You can find an example of the input file within the package, and documentation
#' regarding what each column means, by executing the following command:

## OMOP
expectedvariablespresent::evp_variable_file_omop
?evp_variable_file_omop

## PCORnet
expectedvariablespresent::evp_variable_file_pcornet
?evp_variable_file_pcornet

#' This file can be stored either as an external CSV file and read into the data
#' later, or a tibble / dataframe can be created in the R environment.
#' 
#' Here is an example that will function with the synthetic data in this repository.

my_input_file <- tibble('variable' = c('Blood Pressure', 'Anti-Hypertensive Prescription', 'Echocardiogram'),
                        'domain_tbl' = c('measurement', 'drug_exposure', 'procedure_occurrence'),
                        'concept_field' = c('measurement_concept_id', 'drug_concept_id', 'procedure_concept_id'),
                        'date_field' = c('measurement_date', 'drug_exposure_start_date', 'procedure_date'),
                        'codeset_name' = c('synthea_blood_pressure', 'synthea_antihypertensive', 'synthea_echocardiogram'),
                        'filter_logic' = c(NA, 'drug_type_concept_id == 32838', NA))

#' Now we can use this same input file for any of the configurations that are available for this
#' module. We can now configure the `evp_process` function to execute the configuration that best
#' suits our needs. To see all the available parameters and documentation for the function,
#' run `?evp_process`

evp_singlesite_exploratory <- evp_process(cohort = my_cohort,
                                          omop_or_pcornet = 'omop',
                                          evp_variable_file = my_input_file,
                                          multi_or_single_site = 'single',
                                          anomaly_or_exploratory = 'exploratory',
                                          time = FALSE)

#' If you would like to try another configuration, the only thing you need to do
#' is swap the appropriate parameter and rerun:

evp_singlesite_anomaly <- evp_process(cohort = my_cohort,
                                      omop_or_pcornet = 'omop',
                                      evp_variable_file = my_input_file,
                                      multi_or_single_site = 'single',
                                      anomaly_or_exploratory = 'anomaly', # this is what we changed
                                      time = FALSE)

#' Now that we have our data, we can also use the `evp_output` function to
#' generate a visualization. The `evp_process` function will output a box 
#' in the console that highlights which parameters are necessary based on
#' the configuration you used. Run `?evp_output` to see all available parameters
#' and documentation for each.

## Single Site, Exploratory
ss_exp_graph <- evp_output(process_output = evp_singlesite_exploratory,
                           output_level = 'patient')

ss_exp_graph

## Single Site, Anomaly Detection
ss_anom_graph <- evp_output(process_output = evp_singlesite_anomaly)

ss_anom_graph

#' These plots can also be made interactive:

make_interactive_squba(ss_exp_graph)

make_interactive_squba(ss_anom_graph)
