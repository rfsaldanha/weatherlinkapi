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

  if("rain_storm_last_start_at" %in% names(out)){
    out <- out |>
      dplyr::mutate(rain_storm_last_start_at = lubridate::as_datetime(.data$rain_storm_last_start_at))
  }

  if("rain_storm_last_end_at" %in% names(out)){
    out <- out |>
      dplyr::mutate(rain_storm_last_end_at = lubridate::as_datetime(.data$rain_storm_last_end_at))
  }

  if("rain_storm_start_time" %in% names(out)){
    out <- out |>
      dplyr::mutate(rain_storm_start_time = lubridate::as_datetime(.data$rain_storm_start_time))
  }


  
  return(out)
}