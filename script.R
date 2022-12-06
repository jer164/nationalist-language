require(ggsci)
require(ggpubr)
require(glue)
require(textcat)
require(tidyverse)
require(stargazer)

freq_rn <- read_csv("data/word_freq_rn.csv", col_types = cols(...1 = col_skip())) %>% 
  mutate(word = as.factor(word)) %>% 
  mutate(word = fct_reorder(word, word_count, .desc = TRUE)) %>% 
  mutate(party = as.factor('National Rally'))
freq_afd <- read_csv("data/word_freq_afd.csv", col_types = cols(...1 = col_skip())) %>% 
  mutate(word = as.factor(word)) %>% 
  mutate(word = fct_reorder(word, word_count, .desc = TRUE)) %>% 
  mutate(party = as.factor('Alternative for Germany'))
freq_sd <- read_csv("data/word_freq_sd.csv", col_types = cols(...1 = col_skip())) %>% 
  mutate(word = as.factor(word)) %>% 
  mutate(word = fct_reorder(word, word_count, .desc = TRUE)) %>% 
  mutate(party = as.factor('Sweden Democrats'))
freq_dpp <- read_csv("data/word_freq_dpp.csv", col_types = cols(...1 = col_skip())) %>% 
  mutate(word = as.factor(word)) %>% 
  mutate(word = fct_reorder(word, word_count, .desc = TRUE)) %>% 
  mutate(party = as.factor("Danish People's Party")) 
freq_vb <- read_csv("data/word_freq_vb.csv", col_types = cols(...1 = col_skip())) %>% 
  mutate(word = as.factor(word)) %>% 
  mutate(word = fct_reorder(word, word_count, .desc = TRUE)) %>% 
  mutate(party = as.factor("Vlaams Belang")) 

summarized_counts <- bind_rows(freq_afd, freq_dpp, freq_rn, freq_sd, freq_vb) %>% 
  group_by(party) %>% 
  mutate(party = as.character.factor(party)) %>% 
  summarise(tokens = sum(word_count),
            unique_tokens = n_distinct(word),
            top_token = as.character.factor(word[which.max(word_count)]))


### Plotting Function

plot_counts <- function(nation, viz = 'navy', n_tokens = 10, figure_no = 1, save = TRUE){

  library(ggpubr)
  
  if (grepl('dpp', substitute(nation)) == TRUE){
    party_name = "Danish People's Party"
  } else if (grepl('rn', substitute(nation)) == TRUE){
    party_name = "National Rally"
  } else if (grepl('sd', substitute(nation)) == TRUE){
    party_name = "Sweden Democrats"
  } else if (grepl('vb', substitute(nation)) == TRUE){
    party_name = "Vlaams Belang"
  } else if (grepl('afd', substitute(nation)) == TRUE){
    party_name = "AfD"
  } else{party_name = 'Undefined Party'}
    
  
  p <- nation %>% 
    slice_head(n = n_tokens) %>%  
    ggbarplot(x = 'word', y = 'word_count', fill = viz,
                       xlab = 'Token', ylab = 'Frequency',
              subtitle = glue('Frequency Plot of {party_name}'),
              title = glue('Figure {figure_no}')) +
    scale_x_discrete(guide = guide_axis(n.dodge=2)) +
    font("title", size = 14, face = "bold")
  
  if (save == TRUE){
    ggsave(glue('figure{figure_no}.png', dpi= 300))
  }
  return(p)
}




