library(dplyr)
library(purrr)
library(ggplot2)
library(forcats)
source('R/gh_auth.R')

#' @export
user_preferences <- function(id){
  #The function reads in the ID of a user and returns the a dataframe and ggplot item of the languages used by the user.
  gtoken <- gh_auth()
  url <- 'https://api.github.com/users/'
  a <- GET(paste(url,id,"/repos", sep=""), gtoken)
  text <- content(a)
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
