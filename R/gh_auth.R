library(httpuv)
library(httr)

#' @export
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
