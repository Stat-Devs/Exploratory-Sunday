library(haven)
library(tidyverse)

PKSQ7AFL <- read_sav("Exploratory-Sunday/06-03-23/PKSQ7ASV/PKSQ7AFL.SAV")


data <- PKSQ7AFL

data$TREGION

data_final <- data |> 
  select(province=TREGION, transport_night = T108, place_treatment = T109, transport_mode = T110, 
         time_to_facility = T111, medicines = T121, districts= TDISTRICT)

data_final

data_balochistan <- data_final |> 
  filter(province==4)

View(data_balochistan)

place_of_treatment <- ggplot(data_balochistan) +
  geom_bar(aes(x=place_treatment))

transport_available_at_night <- ggplot(data_balochistan) +
  geom_bar(aes(x=transport_night))

transport_mode <- ggplot(data_balochistan) +
  geom_bar(aes(x=transport_mode))

data_balochistan$medicines <- as.character(data_balochistan$medicines)
data_balochistan$medicines[data_balochistan$medicines == 1] <- "Easily Available"
data_balochistan$medicines[data_balochistan$medicines == 2] <- "Sometime Available"
data_balochistan$medicines[data_balochistan$medicines == 3] <- "Never Available"
data_balochistan$medicines[is.na(data_balochistan$medicines)] <- "Data Missing"
data_balochistan$medicines <- factor(data_balochistan$medicines, 
                               levels = c("Never Available","Sometime Available", "Easily Available","Data Missing"))

data_balochistan |> 
  group_by(medicines) |> 
  summarise(n())


ggplot(data_balochistan, aes(x=medicines)) +
  geom_bar(fill=c("#984464","#e6a176","#56641a","#5664a1")) +
  ggtitle("Are Medicines Easily Available in Balochistan") +
  annotate("text", x="Sometime Available", y=42, label="40", size=10) +
  annotate("text", x="Easily Available", y=8, label="5", size=10) +
  annotate("text", x="Never Available", y=45, label="43", size=10) +
  annotate("text", x="Data Missing", y=5, label="2", size=10) +
  xlab("") +
  ylab("No. of Respondents") +
  labs(
    caption = "Pakistan Maternal Mortality Survey 2019"
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
  "Exploratory-Sunday/06-03-23/medicines.png",
  width = 6741,
  height = 3792,
  dpi = 320,
  units = "px"
)    


