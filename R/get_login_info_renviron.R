get_login_info_renviron <- function(){
  res <- list(
    api_key = Sys.getenv("weatherlink_api_key"),
    x_api_secret = Sys.getenv("weatherlink_x_api_secret")
  )

  if(res$api_key == ""){
    cli::cli_abort("WeatherLink API key not provided and not found on renviron. Please provide it using the weatherlink_api_key and weatherlink_x_api_secret values on environ.")
  }

  if(res$x_api_secret == ""){
    cli::cli_abort("WeatherLink API secret not provided and not found on renviron. Please provide it using the weatherlink_api_key and weatherlink_x_api_secret values on environ.")
  }

  return(res)
}