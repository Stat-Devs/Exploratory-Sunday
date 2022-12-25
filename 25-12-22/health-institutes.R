library(readxl)
library(tidyverse)


health_institutes <- read_excel("Exploratory-Sunday/25-12-22/health-institutes.xlsx")
View(health_institutes)


health_institutes |> 
  
  ggplot(aes(y=Institute, x=Quantity)) +
  geom_bar(stat="Identity") +
  facet_wrap("Province",  ncol = 1)
  