# Adapted from https://github.com/basf/rweatherlink/blob/master/R/parsers.R

#' @importFrom rlang .data
parse_sensor <- function(sensor){
  if (length(sensor$data) == 0){
    cli::cli_abort("No data to parse.")
  }
    
  suppressWarnings({
    data <- data.table::setDF(data.table::rbindlist(sensor$data, fill = TRUE))
  })

  out <- tibble::tibble(lsid = sensor$lsid, sensor_type = sensor$sensor_type, data) |>
    dplyr::mutate(ts = lubridate::as_datetime(.data$ts))
  
  return(out)
}