#
################################################################################
# TOKENIZACAO             
################################################################################
# 
# Tokenization at the word level
shortDescription_tk <-tokenize_words(x = catalogoVulnerabilidades_treino$shortDescription,
                                     lowercase = TRUE,
                                     stopwords = NULL,
                                     strip_punct = TRUE,
                                     strip_numeric = FALSE)

head(shortDescription_tk) %>% 
  glimpse()


# Tokenization on a tibble
shortDescription_tibble <- tibble(text = shortDescription_tk)


head(shortDescription_tibble) %>% 
  glimpse()


# Tokenization by n-grams
shortDescription_tk_ngram <- tokenize_ngrams(x = catalogoVulnerabilidades_treino$shortDescription,
                                             lowercase = TRUE,
                                             n = 3L,
                                             n_min = 3L,
                                             stopwords = character(),
                                             ngram_delim = " ",
                                             simplify = FALSE)

shortDescription_tk_ngram[[1]]


# Allowing hyphenated words as one token

# Function to extract tokens with hyphenated words
tokenize_hyphenated_words <- function(x, lowercase = TRUE) {
  if (lowercase)
    x <- str_to_lower(x)
  
  str_split(x, "[:space:]") %>% 
    map(~ str_remove_all(.x, "^[:punct:]+|[:punct:]+$"))
}


shortDescription_hyphen <- tokenize_hyphenated_words(catalogoVulnerabilidades_treino$shortDescription)

shortDescription_hyphen[[1]]
