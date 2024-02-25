# Coleta de dados, Mineração de Texto e Processamento de Linguagem Natural Aplicados a um 
# Catálogo de Vulnerabilidades Cibernéticas
# 
# Identificar padrões e relacionamentos entre as vulnerabilidades catalogadas para tirar inferências.
# 
# CISA
# https://www.cisa.gov/known-exploited-vulnerabilities-catalog
# Short Description
# Action
# https://www.cisa.gov/news-events/cybersecurity-advisories/aa23-215a

#
################################################################################
# CARREGAMENTO DOS DADOS              
################################################################################

# Convertendo o arquivo para o encoding UFT-8
catalogoVulnerabilidades <- 
  read.csv( "https://www.cisa.gov/sites/default/files/csv/known_exploited_vulnerabilities.csv"
            , sep = ","
            , dec = "."
            , encoding = "UTF-8")

ncols_ctl <- ncol(catalogoVulnerabilidades)
nrows_ctl <- (nrow(catalogoVulnerabilidades))

# Criar coluna booleana state com 0 para Unknown e 1 para Known
catalogoVulnerabilidades <- catalogoVulnerabilidades %>% 
  mutate(codigoKnownRansomwareCampaignUse = if_else(knownRansomwareCampaignUse == "Known", 1, 0))

# Divide em teste/treino e cria resampling folds
set.seed(1234)
catalogoVulnerabilidades_split <- catalogoVulnerabilidades %>% 
  filter(nchar(shortDescription) >= 15) %>% 
  initial_split()

catalogoVulnerabilidades_treino <- training(catalogoVulnerabilidades_split)
catalogoVulnerabilidades_teste <-  testing(catalogoVulnerabilidades_split)

set.seed(123)
catalogoVulnerabilidades_folds <- vfold_cv(catalogoVulnerabilidades_treino)
catalogoVulnerabilidades_folds
