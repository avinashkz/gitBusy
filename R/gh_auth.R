library(httpuv)
library(httr)

#' @export
gh_auth <- function(key = "b3a3c2a56274b2c338bd", secret = "220839139fa18e998ef3469da75dde261356ef60"){
#Function used to authenticate Github
app <- oauth_app("github",
                   key = key,
                   secret = secret)
gh_token <- oauth2.0_token(oauth_endpoints("github"), app)
gtoken <- config(token = gh_token)
options(httr_oauth_cache=F)
return(gtoken)
}
