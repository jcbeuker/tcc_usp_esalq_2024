#
################################################################################
# STOP WORDS
################################################################################
# 
# Using premade stop word lists
#
# Removing stop words
#
# Using the stop word list Snowball
text <- catalogoVulnerabilidades$shortDescription 
#text <- shortDescription_hyphen

nrows_sw <- (nrow(catalogoVulnerabilidades))

tx_df <- tibble(line = 1:nrows_sw, text = text)

# Retira numeros
token_sw <- tx_df %>% 
  unnest_tokens(word, text) %>% filter(!grepl('[0-9]', word))

#Stop Words:
token_sw <- token_sw %>% anti_join(stop_words)

# Snowball:
token_sw <- token_sw %>%
  anti_join(get_stopwords(source = "snowball"))

#Busca palavras mais comuns ante de remover stop words
conta_palavras <- tx_df %>% 
  unnest_tokens(word, text) %>%  count(word, sort = TRUE)

#Busca palavras mais comuns após remover stop words
conta_palavras_sw <- token_sw %>%  count(word, sort = TRUE) 

#Grafico
token_sw %>% 
  count(word, sort = TRUE) %>% 
  mutate(word = reorder(word, n)) %>% 
  ggplot(aes(n, word)) +
  ggtitle("vulnerabilityName") +
  geom_col()


#Define a paleta de cores
pal <- brewer.pal(8, "Dark2")

#Nuvem de palavras antes de remover stop words
conta_palavras %>% 
  with(wordcloud(word, n, random.order = FALSE, 
                 max.words = 100, colors = pal))

#Nuvem de palavras após remover stop words
conta_palavras_sw %>% 
  with(wordcloud(word, n, random.order = FALSE, 
                 max.words = 100, colors = pal))
