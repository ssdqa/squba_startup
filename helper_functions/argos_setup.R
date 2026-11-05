
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

argos$public_methods$init_session <-
  function(db_src = NA,
           cdm_schema = NA, vocabulary_schema = NA, results_schema = NA,
           base_dir = .intuit_base_dir(), subdirs = .intuit_subdirs(base_dir),
           cdm = 'OMOP', table_case = 'lower',
           table_names = .intuit_table_names(cdm, table_case),
           results_name_tag = paste0('_',paste0(sample(letters, 5),
                                                collapse = '')),
           local_name_tag = '_loc', results_target = TRUE,
           retain_intermediates = FALSE, db_trace = TRUE, cache_enabled = TRUE,
           execution_mode = 'development',
           ..., .use_db = TRUE) {
    if (.use_db) {
      if (typeof(db_src) == 'character') db_src <- srcr::srcr(db_src)
      if (! is.object(db_src) ||
          # duck type for DBI
          ! methods::is(db_src, "DBIConnection"))
        cli::cli_abort('{.var db_src} must be a DBI connection')
    }
    if (! file.exists(base_dir))
      cli::cli_abort('{.var base_dir} must point to an existing directory')
    
    args <- c(as.list(environment()),
              rlang::dots_list(..., .homonyms. = 'last'))
    purrr::walk2(names(args), args,
                 \(k,v) {
                   if (nchar(k) == 0) {
                     cli::cli_warn('Unnamed argument {.arg v} dropped')
                   } else {
                     self$config(k,v)
                   }
                 })
    private$.setup_pkgs()
    private$.env_setup()
    self
  }
