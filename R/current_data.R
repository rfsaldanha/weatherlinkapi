#' Retrieve current data
#'
#' @param station_id integer. Station identification code (id).
#' @param api_key character. Start date. Use the format `day/month/year`. Example: `20/09/2024`
#' @param x_api_secret character. End date. Use the format `day/month/year`. Example: `20/09/2024`
#' @param as_list logical. If `TRUE` the function will return a list of lists, otherwise, a list with tibbles.
#'
#' @return a list of lists or a list of tibbles, depending on the `as_list` argument.
#' @export
current_data <- function(station_id, api_key = NULL, x_api_secret = NULL, as_list = FALSE){
  # Try to get API key and secret from renviron
  if(any(is.null(api_key), is.null(x_api_secret))){
    access_info <- get_login_info_renviron()
    api_key <- access_info$api_key
    x_api_secret <- access_info$x_api_secret
  }

  # Request specification
  req <- httr2::request(base_url = server_url) |>
    httr2::req_url_path("v2/current") |>
    httr2::req_url_path_append(station_id) |>
    httr2::req_headers("x-api-secret" = x_api_secret) |>
    httr2::req_url_query("api-key" = api_key) |>
    httr2::req_throttle(rate = throttle_rate, realm = server_url) |>
    httr2::req_retry(max_tries = retry_max_tries)

  # Request perform
  resp <- req |>
    httr2::req_perform()

  # Response to list
  res <- resp |>
    httr2::resp_body_json()

  # List or data frame
  if(as_list){
    # Return list
    return(res)
  } else {
    # Return data frame

    # List to data frame
    res2 <- purrr::map(res$sensors, parse_sensor)

    return(res2)
  }
}
