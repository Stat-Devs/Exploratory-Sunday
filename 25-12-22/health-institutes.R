library(readxl)
library(tidyverse)
library(cartography)
library(ragg)
install.packages("extrafont")

library(extrafont)
font_import("C:/Users/sarfa/AppData/Local/Microsoft/Windows/Fonts")


health_institutes <- read_excel("Exploratory-Sunday/25-12-22/health-institutes.xlsx")
View(health_institutes)

white <- "gray97"
  
bg_color <- "#1F2933"
  
txt_col <- "#899CB0"

health_institutes |> 
  filter(Category=="Primary") |> 
  
  ggplot(aes(y=Institute, x=Quantity)) +
  geom_bar(stat="Identity", fill=txt_col, width = 0.75) +
  facet_wrap(~Province, ncol = 1) +
  labs(
    title = "Primary Health Care Facilities in Pakistan",
    caption = "Data Source: Pakistan Statistical Yearbook 2019 & Pakistan Economic Survey 2020-2021"
  ) +
  theme_void() +
  theme (
    panel.grid.major.x = element_line(
      linetype = 3,
      size = 0.25,
      color = txt_col
    ),
    axis.text.x = element_text(
      size = 12,
      color = txt_col
    ),
    axis.text.y = element_text(
      size = 16,
      color = txt_col,
      hjust = 1
    ),
    
    axis.title.x = element_text(
                                size = 10, 
                                color = "white",
                                #  face = "bold",
                                hjust = 1
    ),
    strip.text = element_text(
      face = "bold",
      size = 14,
      color = txt_col,
      hjust = 0
    ),
    plot.title = element_text(

      size = 24,
      color = white,
      face = "bold"
    ),
    
    plot.caption = element_text(
    
      size = 10,
      color = txt_col,
      hjust = 0.5
    ),
    
    
    plot.background = element_rect(fill = bg_color,
                                   color = bg_color)
  )

ggsave(
  "primary_health_facilities.png",
  width = 6741,
  height = 3792,
  dpi = 320,
  units = "px"
)  
