library(tidyverse)
library(readxl)

beds <- read_excel("Exploratory-Sunday/01-01-23/beds.xlsx")
View(beds)


beds |> 
  ggplot(aes(x = fct_reorder(Institutes, Beds), y = Beds)) +
  geom_col(fill = "#B9D9EB") +
  ggtitle("Total No. of Beds in Healthcare Institutes in Pakistan" ) +
  
  xlab("Healthcare Institutes") +
  ylab("No. of Beds") +
  coord_flip() +
  geom_text(aes(label=Beds), hjust=0) +
  theme_bw() +
  theme(
    axis.text.x = element_text(
      size = 15,
      color = "black"
    ),
    axis.text.y = element_text(
      size = 15,
      color = "black"
    ),
    axis.title.x = element_text(
      size = 20,
      color = "black",
      hjust = 0.5
    ),
    axis.title.y = element_text(
      size = 20,
      color = "black",
      vjust = 0.5
    ),
    plot.title = element_text(
      
      size = 18,
      color = "black",
      face = "bold",
      hjust = 0.5
    ),
    
    plot.caption = element_text(
      
      size = 13,
      color = "black",
      hjust = 0.5
    )
    
  )

ggsave(
  "beds.png",
  width = 6741,
  height = 3792,
  dpi = 320,
  units = "px"
)    
