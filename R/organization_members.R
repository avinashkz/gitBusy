library(httr)
library(dplyr)
library(purrr)
library(testthat)
source('R/user_preferences.R')
source('R/gh_auth.R')

#' Get programming languages used/forked by a user on Github.
#'
#' @description
#' The function returns a list of all the public user in an Organization
#'
#' @param organization of the interest
#'
#' @param auth optional argument if authentication needed or not
#'
#' @param gtoken optional argument - user authentication done using gh_auth.
#'
#' @return Returns a list of all the public users with their most commonly used languages in a dataframe and as a ggplot item.
#'
#'
#' @examples
#' organization_members("UBC-MDS", TRUE)
#'
#' @export
#'
organization_members <- function(organization, auth = FALSE ,gtoken = NULL){
  #Reads in the Organization name on GitHub
  #Returns a list of all the public users with their most commonly used languages in a dataframe and as a ggplot item.

  url <- 'https://api.github.com/orgs/'


  if (!is.character(organization) | is.null(organization)){
    stop("Organization input needs to be a string")
  }
  if(grepl("\\s", organization)){
    warning("Found white space in organization name. Removed spaces to check.")
    organization <- gsub(" ", "", organization,fixed = TRUE)
  }
  if(is.null(gtoken) & auth)
  {
    stop("Cannot extract data without authenticating.")
  } else if(!auth){
    a <- GET(paste0(url,organization))
  }
  else
  {
    a <- GET(paste0(url,organization),gtoken)
  }

  data <- GET(paste0(url,
                    organization,
                    "/members"), gtoken)
  text <- content(data)

  if(is.null(text$message)){
    user_ids <- map_chr(text, function(y) return(y$login))
    complete_users <- map(user_ids, user_preferences,gtoken)
    names(complete_users) <- user_ids
    return(complete_users)
  } else {
    stop(paste('Organization', paste0('"', organization, '"'), 'Not Found on GitHub'))
  }
}
