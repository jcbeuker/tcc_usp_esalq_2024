#
################################################################################
# LEMATIZACAO
################################################################################
# 
spacy_initialize(entity = FALSE)

tx_df %>% 
  mutate(doc_id = paste0("doc", row_number())) %>% 
  select(doc_id, everything()) %>% 
  spacy_parse() %>% 
  anti_join(get_stopwords(), by = c("lemma" = "word")) %>% 
  count(lemma, sort = TRUE) %>% 
  top_n(20, n) %>% 
  ggplot(aes(n, fct_reorder(lemma, n))) +
  geom_col() +
  labs(x = "Frequency", y = NULL)
