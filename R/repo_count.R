library(httr)
library(glue)
source('R/gh_auth.R')

#' @export
repo_count <- function(id, auth = FALSE){
  #Return the number of Pulic Repositories for an ID
  url <- 'https://api.github.com/users/'
  if(auth)
  {
    gtoken <- gh_auth()
    a <- GET(paste(url,id,sep=""), gtoken)
    }
  else
  {
    a <- GET(paste(url,id,sep=""))
    }
  text <- content(a, "parsed")
  if(is.null(text$public_repos)){
    stop(glue('User', id, 'Not Found on GitHub', .sep = " "))
  } else {
    return(text$public_repos)
  }
}

