library(httpuv)
library(httr)

#' Function to authenticate with GitHub
#'
#' @description
#' The function uses the Secret ID and Secret Key generated from GitHub to
#' authenticate user.
#'
#' @param key Client ID from GitHub
#'
#' @param secret Client secret from GitHub
#'
#' @return Authentication token
#'
#' @examples
#' gh_auth(key="xx", secret="yyy")
#'
#' @export
#'
gh_auth <- function(key, secret){
#Function used to authenticate Github
app <- oauth_app("github",
                   key = key,
                   secret = secret)
gh_token <- oauth2.0_token(oauth_endpoints("github"), app)
gtoken <- config(token = gh_token)
options(httr_oauth_cache=T)
return(gtoken)
}
