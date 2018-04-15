library(httr)
library(dplyr)
library(purrr)
source('R/gh_auth.R')

.rogue <- function(x,token) {
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

#' @export

#' Get name, link and language for all the repositories in the organization.
#'
#' @param organization of interest on GitHub
#' @param gtoken currency symbol as a reference base 1, for example "USD"
#' @return the names link and language for all the repositories in the organization
#'
#'
#' @examples
#' organization_members("UBC-MDS", TRUE,token)
#'

org_repos <- function(organization, auth = TRUE, gtoken = FALSE){

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
    a <- GET(paste(url,organization,sep=""))
  }
  else
  {
    a <- GET(paste(url,organization,sep=""),gtoken)
  }

  org <- GET(paste0("https://api.github.com/orgs/", organization, "/repos")
             , gtoken)

  text <- content(org)

  if(is.null(text$message)){
    data <- text %>% map_df(.rogue,gtoken)
    return(data)
  } else {
    stop(paste('User', paste('"', id, '"', sep = ""), 'Not Found on GitHub'))
  }
}
