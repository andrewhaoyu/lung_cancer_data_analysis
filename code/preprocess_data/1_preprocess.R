#goal: read into the ILCCO data on farsrc and see the sample size table
setwd("/n/holystore01/LABS/xlin/Everyone/ILLCO/")
library(data.table)
data = fread("./data/updated_phenotype_MARCH_06_2017.txt",header=T)
covar = fread("./data/OncoArray.covar.txt")

library(dplyr)
library(tidyverse)
library(janitor)
data.sum = data %>% 
  count(disease1,SITE) %>% 
  mutate(disease1 = case_when(
           disease1==-9 ~"unknown",
           disease1==0 ~"control",
           disease1==1~"case"
         ))  %>% 
  spread(key = "disease1",value = n) %>% 
  mutate(case=ifelse(is.na(case),0,case),
         control = ifelse(is.na(control),0,control),
         unknown=ifelse(is.na(unknown),0,unknown)) %>% 
  mutate(total = case + control + unknown) %>% 
  adorn_totals(where = c("row"))



data %>% 
  filter(is.na(SITE))
