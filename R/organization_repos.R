require(httr)
require(dplyr)
require(purrr)

.rogue <- function(x) {
  #Return the details of all the public repos in an organization
  #Returns repo name + link + language + collaborators
  collab <- GET(x$contributors_url, gtoken)
  text <- content(collab)
  a <- text %>% map_chr(function(z) return(z$login))
  collaborators <- paste(a, collapse = ", ")
  return(bind_cols(name  = x$name, link = x$html_url, language = x$language, collaborators = collaborators))
}

org_repos <- function(id){
  #Function returns the the name, link and language for all the repositories in the organization.
  org <- GET(paste("https://api.github.com/orgs/", id, "/repos", sep = ""), gtoken)
  text <- content(org)
  if(is.null(text$message)){
    data <- text %>% map_df(.rogue)
    return(data)
  } else {
    stop(paste('User', paste('"', id, '"', sep = ""), 'Not Found on GitHub'))
  }
}