# 
##################################################################################
#                  INSTALAÇÃO E CARREGAMENTO DE PACOTES NECESSÁRIOS             #
##################################################################################
#Pacotes utilizados
pacotes <- c("tidytext","ggplot2","dplyr","tibble","wordcloud","stringr",
             "SnowballC","widyr")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

library(tokenizers)
library(tidyverse)
library(tidytext)
library(tidymodels)

library(stopwords)

#devtools::install_github('quanteda/spacyr')
spacy_install()
library(spacyr)

library(tm)
