library(tidyverse)
library(foreign)
library(readxl)

health_financing <- read_excel("health-financing.xlsx")
health_financing$`%` <- round(health_financing$`%`,digits = 2)
health_financing$Agents <- c("Government","Out of Pocket","NGOs","Other")

View(health_financing)


ggplot(health_financing, aes(x = "", y = `%`, fill = Agents)) +
  geom_col(color = "white") + geom_text(aes(label = `%`),position = position_stack(vjust = 0.5)) +
  coord_polar("y", start=0) +
  guides(fill = guide_legend(title = "Agents")) +
  scale_fill_brewer() +
  theme_void() # remove background, grid, numeric labels
