get_login_info_renviron <- function(){
  res <- list(
    key = Sys.getenv("weatherlink_key"),
    secret = Sys.getenv("weatherlink_secret")
  )

  if(res$key == ""){
    cli::cli_abort("WeatherLink API key not provided and not found on renviron. Please provide it using the weatherlink_key and weatherlink_secret values on environ.")
  }

  if(res$secret == ""){
    cli::cli_abort("WeatherLink API secret not provided and not found on renviron. Please provide it using the weatherlink_key and weatherlink_secret values on environ.")
  }

  return(res)
}