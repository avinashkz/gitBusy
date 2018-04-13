require(httr)
require(dplyr)
require(purrr)
source('user_preferences.R')

organization_members <- function(organization){
  #Reads in the Organization name on GitHub
  #Returns a list of all the public users with their most commonly used languages in a dataframe and as a ggplot item.
  data <- GET(paste("https://api.github.com/orgs/", 
                    organization, "/members", sep = ""), gtoken)
  text <- content(data)
  
  if(is.null(text$message)){
    user_ids <- map_chr(text, function(y) return(y$login))
    complete_users <- map(user_ids, user_preferences)
    names(complete_users) <- user_ids
    return(complete_users)
  } else {
    stop(paste('Organization', paste('"', organization, '"', sep = ""), 'Not Found on GitHub'))
  }
}