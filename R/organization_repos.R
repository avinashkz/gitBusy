library(httr)
library(dplyr)
library(purrr)
library(testthat)
context('R/gh_auth.R')

.rogue <- function(x, gtoken = NULL) {
  #Return the details of all the public repos in an organization
  #Returns repo name + link + language + collaborators

  if(is.null(gtoken)){
    #if token is NULL do not append gtoken to the GET call
    collab <- GET(x$contributors_url)
  } else{
    collab <- GET(x$contributors_url, gtoken)
  }

  text <- content(collab)
  a <- text %>% map_chr(function(z) return(z$login))
  collaborators <- paste(a, collapse = ", ")
  return(bind_cols(name  = x$name, link = x$html_url, language = x$language, collaborators = collaborators))
}



#' Get name, link and language for all the repositories in the organization.
#'
#' @description
#' The function returns the name, link and language used for all the repositories in the organization.
#'
#' @param organization of interest on GitHub
#'
#' @param auth optional argument if authentication needed or not
#'
#' @param gtoken optional argument - user authentication done using gh_auth.
#'
#' @return the names link and language for all the repositories in the organization
#'
#'
#' @examples
#' organization_members(organization = "UBC-MDS", auth = TRUE, gtoken = token)
#'
#' @export
#'
org_repos <- function(organization, auth = TRUE, gtoken = NULL){

  url <- "https://api.github.com/orgs/"

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
    print(paste0(url, organization, "/repos"))
    org <- GET(paste0(url, organization, "/repos"))
  }
  else
  {
    org <- GET(paste0(url, organization, "/repos"),gtoken)
  }

  text <- content(org)

  if(is.null(text$message)){
    data <- text %>% map_df(.rogue, gtoken)
    return(data)
  } else {
    stop(paste('Organization', paste0('"', organization, '"'), 'Not Found on GitHub'))
  }
}
