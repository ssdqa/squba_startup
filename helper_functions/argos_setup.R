
argos$public_methods$tbl_case_corrector <-
  function(tbl) {
    if (self$config_exists("cdm_case")) {
      if (self$config("cdm_case") == "upper") {
        return(tbl %>% rename_all(~ tolower(.)))
      } else {
        return(tbl)
      }
    } else {
      return(tbl)
    }
  }

argos$public_methods$cdm_tbl <- function(name, db = self$config("db_src")) {
  self$tbl_case_corrector(self$qual_tbl(name, "cdm_schema", db))
}
