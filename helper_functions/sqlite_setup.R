# Generate a test DB with synthetic omop data
testdb <- NULL

# Function to generate omop test db
mk_testdb_omop <- function(){
  if (! is.null(testdb)) return(testdb)

  # Create an ephemeral in-memory RSQLite database
  testdb <<- DBI::dbConnect(RSQLite::SQLite(), ":memory:", extended_types = T)
  # Read all csv files in testdata folder
  col_type_mapping <- list(
    'condition_occurrence' = 'iiiDTDTiiciiicic',
    'person' = 'iiiiiTiiiiiccicici',
    'visit_occurrence' = 'iiiDTDTiiiciicici',
    'drug_exposure' = 'iiiDTDTDiciiiciiiiiiicc',
    'measurement' = 'iiiDTTiidiiiiiiicicicii',
    'procedure_occurrence' = 'iiiDTDTiiiiiicii',
    'provider' = 'iciiiiDiccici')
  for (file_name in list.files(path='synthea_cdm', pattern = "\\.csv$")) {
    # Get table_name from csv file_name without extension
    table_name <- sub('\\.csv$', '', file_name)
    tbl <- readr::read_csv(
      file = file.path('synthea_cdm', file_name),
      col_types = col_type_mapping[[table_name]],
      show_col_types = FALSE
    )
    # Write to db
    DBI::dbWriteTable(testdb, table_name, tbl)
  }
  testdb
}
