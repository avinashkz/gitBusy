#' @export
library(httr)
library(glue)
source('R/gh_auth.R')

repo_count <- function(id, auth = TRUE){
  #Return the number of Pulic Repositories for an ID
  url <- 'https://api.github.com/users/'
  if(auth)
  {
    a <- GET(paste(url,id,sep=""))
    }
  else
  {
    gtoken <- gh_auth()
    a <- GET(paste(url,id,sep=""), gtoken)
    }
  text <- content(a, "parsed")
  if(is.null(text$public_repos)){
    stop(glue('User', id, 'Not Found on GitHub', .sep = " "))
  } else {
    return(text$public_repos)
  }
}

