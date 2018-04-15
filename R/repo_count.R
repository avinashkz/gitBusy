library(httr)
library(glue)
source('R/gh_auth.R')

#' @export
repo_count <- function(user, auth = TRUE, gtoken = FALSE){
  #Return the number of Pulic Repositories for an ID

  url <- 'https://api.github.com/users/'

  if (!is.character(user) | is.null(user)){
    stop("User input needs to be a string")
  }
  if(grepl("\\s", user)){
    warning("Found white space in organization name. Removed spaces to check.")
    User <- gsub(" ", "", User,fixed = TRUE)
  }
  if(is.null(gtoken) & auth)
  {
    stop("Cannot extract data without authenticating.")
  } else if(!auth){
    a <- GET(paste(url,user,sep=""))
  }
  else
  {
    a <- GET(paste(url,user,sep=""),gtoken)
  }

  text <- content(a, "parsed")

  if(is.null(text$public_repos)){
    stop(glue('User', user, 'Not Found on GitHub', .sep = " "))
  } else {
    return(text$public_repos)
  }
}

