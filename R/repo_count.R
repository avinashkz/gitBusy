#' @export
library(httr)
source('R/gh_auth.R')

repo_count <- function(id){
  #Return the number of Pulic Repositories for an ID
  gtoken <- gh_auth()
  url <- 'https://api.github.com/users/'
  a <- GET(paste(url,id,sep=""), gtoken)
  text <- content(a, "parsed")
  if(is.null(text$public_repos)){
    stop(paste('User', paste('"', id, '"', sep = ""), 'Not Found on GitHub'))
  } else {
    return(text$public_repos)
  }
}
