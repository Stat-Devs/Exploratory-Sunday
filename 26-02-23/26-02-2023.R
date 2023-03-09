library(haven)
library(tidyverse)




data <- PKSQ7AFL

data$TREGION

data_final <- data |> 
  select(province=TREGION, transport_night = T108, place_treatment = T109, transport_mode = T110, 
         time_to_facility = T111, medicines = T121, districts= TDISTRICT)

data_final

data_sindh <- data_final |> 
  filter(province==2)

View(data_sindh)

place_of_treatment <- ggplot(data_sindh) +
  geom_bar(aes(x=place_treatment))

transport_available_at_night <- ggplot(data_sindh) +
  geom_bar(aes(x=transport_night))

transport_mode <- ggplot(data_sindh) +
  geom_bar(aes(x=transport_mode))

data_sindh$medicines <- as.character(data_sindh$medicines)
data_sindh$medicines[data_sindh$medicines == 1] <- "Easily Available"
data_sindh$medicines[data_sindh$medicines == 2] <- "Sometime Available"
data_sindh$medicines[data_sindh$medicines == 3] <- "Never Available"

data_sindh$medicines <- factor(data_sindh$medicines, 
                               levels = c("Sometime Available", "Easily Available", "Never Available"))



ggplot(data_sindh, aes(x=medicines)) +
  geom_bar(fill=c("#984464","#e6a176","#56641a")) +
  ggtitle("Are Medicines Easily Available in Sindh") +
  annotate("text", x="Sometime Available", y=11, label="8", size=10) +
  annotate("text", x="Easily Available", y=18, label="15", size=10) +
  annotate("text", x="Never Available", y=115, label="112", size=10) +
  xlab("") +
  ylab("No. of Respondents") +
  labs(
    caption = "Pakistan Demographic & Health Survey 2019"
  ) +
 
  theme_classic() +
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
      
    ),
    axis.title.y = element_text(
      size = 20,
      color = "black",
      
    ),
    plot.title = element_text(
      
      size =22,
      color = "black",
      face = "bold",
      
    ),
    
    plot.caption = element_text(
      
      size = 18,
      color = "black",
      
    ),
    panel.background = element_rect(fill = "#FFF4D2"),
    panel.grid.major = element_line(colour = 'white', linewidth = 1 ),
    
    
  )

ggsave(
  "Exploratory-Sunday/26-02-23/medicines.png",
  width = 6741,
  height = 3792,
  dpi = 320,
  units = "px"
)    


