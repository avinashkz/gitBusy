library(httr)
library(glue)
library(testthat)
source('R/gh_auth.R')

#' Get the number of Pulic Repositories for an ID
#'
#' @description
#' The function returns the number of repositories for the given user.
#'
#' @param user GitHub user ID for the target user.
#'
#' @param auth optional argument if authentication needed or not
#'
#' @param gtoken optional argument - user authentication done using gh_auth.
#'
#' @return Returns a number of Public Repos for an ID.
#'
#'
#' @examples
#' organization_members("UBC-MDS", TRUE)
#'
#' @export
#'
repo_count <- function(user, auth = FALSE, gtoken = NULL){

  url <- 'https://api.github.com/users/'

  if (!is.character(user) | is.null(user)){
    stop("User input needs to be a string")
  }
  if(grepl("\\s", user)){
    warning("Found white space in username. Removed spaces to check.")
    user <- gsub(" ", "", user,fixed = TRUE)
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

