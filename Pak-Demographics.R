#####################################################################
# Title: Indicator : Demographic Graphs
# Author: Muhammad Uzair Aslam
# Date: 10/16/2022
# Purpose: Analyze Pakistan Population Demographics
# Data Sets : Census 2017
#####################################################################

# Libraries ---- 

library(tidyverse)
library(readxl)
library(cowplot)

# Data ----

pop_data <- read_excel("Census-Data.xlsx", sheet = 1)

pop_data <- select(pop_data ,c(Age_Bracket, M, F))

# Manipulating data ----

data <- pop_data %>%
  pivot_longer(names_to = 'Gender', values_to = 'Population', cols = 2:3) %>%
  mutate(PopPerc = case_when(Gender =='M' ~ round(Population / sum(Population) * 100, 2),
                           TRUE ~ -round(Population / sum(Population) * 100, 2)),
         signal = case_when(Gender == 'M' ~ 1,
                          TRUE ~ -1))

# Make new age variable with factor
data$Age <- as.factor(data$Age_Bracket)

# Make age as ordered factor
data$Age <- factor(data$Age,levels=unique(data$Age), ordered = TRUE)

# Store sum of genders in respective variables
male <- sum(filter(data,Gender == 'M')$Population)
female <- sum(filter(data,Gender == 'F')$Population)

# Plotting ---- 

ggplot(data,aes(x = Age,y = PopPerc))+
  geom_bar(aes(fill= Gender), stat='identity')+
  #geom_text(aes(label=abs(PopPerc)),)+
  geom_label(aes(label=abs(PopPerc)), position = 'identity',stat ='identity')+
  coord_flip()+
  scale_fill_manual(name ='',values = c('darkred','steelblue'),labels = c("Female","Male"))+
  scale_y_continuous(breaks = seq(-20,20,2),
                     labels = function(x){paste(abs(x),'%')})+
  labs(x = '', y = 'Population (%)',
       title = 'Population Pyramid of Pakistan',
       subtitle = paste('Total Population :', format(sum(data$Population), big.mark = ',')),
       caption ='Source: Pakistan Census 2017',)+
  annotate(geom="text", 
           x=6.5, 
           y=12, 
           label= paste('Male Population :', format(male,big.mark=',')),
           color="black") +
  annotate(geom="text", 
           x= 6.5, 
           y= -12, 
           label= paste('Female Population :', format(female,big.mark=',')),
           color="black") +
  cowplot::theme_cowplot()+
  theme(axis.text.x=element_text(vjust=.5),
        panel.grid.major.y = element_line(color='lightgray',linetype='dashed'),
        legend.position = 'top',
        legend.justification = 'center')
