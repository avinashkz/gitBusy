library(dplyr)
library(purrr)
library(ggplot2)
library(forcats)
source('R/gh_auth.R')

#' @export

#' Get programming languages used/forked by a user on Github.
#'
#' @param id username of the GitHub user
#' @param gtoken optional argument - user authentication done using gh_auth.
#' @return a list of: dataframe and ggplot item for the languages used by the user.
#'
#'
#' @examples
#' user_preferences('sarora','') or user_preferences('sarora')
#'



user_preferences <- function(id,gtoken=NULL){
  #The
  url <- 'https://api.github.com/users/'

 if (!is.character(id) | is.null(id)){
    stop("GitHub user Id needs to be a string")
  }

  if(is.null(gtoken)){
    a <- GET(paste0(url,id,"/repos"))
  } else{
    a <- GET(paste0(url,id,"/repos"), gtoken)
  }


  text <- content(a)

  if(!is.null(text$message)){
    stop(paste('User', paste('"', id, '"', sep = ""), 'Not Found on GitHub'))
  }

  my_repo <- map_df(text,
                    function(q) return(bind_cols(name = q$name, language = q$language)))
  lang_agg <- my_repo %>% group_by(language) %>%
    summarise(count = n()) %>% arrange(count)
  lang_plot <- lang_agg %>% ggplot() +
    geom_col(aes(fct_reorder(language, count), as.factor(count))) +
    labs(x = "Language", y = "Number of Repositories",
         title = paste("Languages used by", id)) +
    theme_bw() + theme(plot.title = element_text(hjust = 0.5))
  item <- list(lang_agg, lang_plot)
  return(item)
}
