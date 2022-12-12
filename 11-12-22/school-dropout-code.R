library(tidyverse)
library(foreign)
library(readxl)
library(reactablefmtr)

school_dropouts <- read_excel("Exploratory-Sunday/11-12-22/school_dropouts.xlsx")
View(school_dropouts)

#school_dropouts$male_total <- c(1.8,0.4,7.5,6.3,1.0,10.8,31.9,1.3,0.5,0.1,29.4,7.8,1.3)

#school_dropouts |> summarise(sum(male_total))

#school_dropouts$female_total <- c(9.1,0.8,18.2,7.3,18.4,13.2,16.8,0.9,0.6,0.9,2.0,10.5,1.4)

#school_dropouts |> summarise(sum(female_total))

urban <- school_dropouts |> 
  select(`Reasons for not attending school`,`Male urban`,`Female urban`)
View(urban)
urban <- urban |> 
  rename("Male" = `Male urban`)

urban <- urban |> 
  rename("Female" = `Female urban`)

urban <- urban |> 
  add_row(`Reasons for not attending school`="Total", Male= 100,Female=100)

urban$Male <- urban$Male/100
urban$Female <- urban$Female/100

View(urban)


rural <- school_dropouts |> 
  select(`Reasons for not attending school`,`Male rural`,`Female rural`)
View(rural)
rural <- rural |> 
  rename("Male" = `Male rural`)

rural <- rural |> 
  rename("Female" = `Female rural`)

rural <- rural |> 
  add_row(`Reasons for not attending school`="Total", Male= 100,Female=100)

rural$Male <- rural$Male/100
rural$Female <- rural$Female/100

View(rural)

urban |> 
  reactable(
    theme = nytimes(),
    pagination = FALSE,
    defaultColDef = colDef(
      cell = data_bars(urban,
                       fill_color = c("#FCDEC0","#7D5A50"),
                       fill_gradient = TRUE,
                       background = none,
                       round_edges = TRUE,
                       number_fmt = scales::percent,
                       box_shadow = FALSE,
                       force_outside = c(0,1))
      
                      
    )
            
    
  ) |> 
  add_title("URBAN POPULATION")

rural |> 
  reactable(
    theme = nytimes(),
    pagination = FALSE,
    defaultColDef = colDef(
      cell = data_bars(rural,
                       fill_color = c("#8FE3CF","#002B5B"),
                       fill_gradient = TRUE,
                       background = none,
                       round_edges = TRUE,
                       number_fmt = scales::percent,
                       box_shadow = FALSE,
                       force_outside = c(0,1))
      
      
    )
    
    
  ) |> 
  add_title("PAKISTAN RURAL POPULATION",font_size = 28)



  

