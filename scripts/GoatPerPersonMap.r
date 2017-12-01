install.packages("rgdal")
library(magrittr)
library(dplyr)
library(leaflet)
library(rgdal)
library(htmlwidgets)
library(htmltools)


#setwd("D:/adamcummings.net repo/adamkc.github.io/docs/Goat Analysis/")
counties <- readOGR("cb_2016_us_county_20m/cb_2016_us_county_20m.shp",
                  layer = "cb_2016_us_county_20m", GDAL1_integer64_policy = TRUE)

##Add goat population
goatdf <- read.csv("GoatbyCounty.csv",colClasses = c("factor","factor","factor","factor","numeric"),na.strings = "(D)")
counties@data %<>% left_join(y = goatdf,by = c("GEOID" = "FIPSTEXT") )


##Add Human Population
popdf <- read.csv("CountyPop2.csv")
popdf <- popdf[as.character(popdf$STNAME) != as.character(popdf$CTYNAME),]
popdf %<>% group_by(STNAME,CTYNAME) %>% summarise(POP = sum(POPESTIMATE2016)) %>%
  ungroup %>% transmute(StateName = STNAME,
                        CountyNameLong = CTYNAME,
                        HumanPop = POP)

counties@data$CountyNameLong <- paste(counties@data$CountyName, counties@data$Entity)
counties@data %<>% left_join(y = popdf)

counties@data$Label <- paste0("<b>",counties@data$NAME, "</b>",
                              "<br/>","Goats: ",round(counties@data$Goats*(counties@data$ALAND/404686),0),
                              "<br/>","People: ",counties@data$HumanPop,
                              "<br/>","Goat Per Person: ",round(counties@data$GoatperPerson,3)
                              )



#Calculate goats per human (Goats in per 100acre.  ALAND in meters sq.)
counties@data$GoatperPerson <- counties@data$Goats*(counties@data$ALAND/404686)/counties@data$HumanPop 

pal <- colorNumeric(
  palette = "YlOrRd",
  domain = countiesnoAK$GoatperPerson)


goatmap <- leaflet(counties) %>% setView(lng = -99.744289, lat = 39.138261, zoom=4.5) %>%
  addPolygons(fillColor = ~pal(GoatperPerson), weight = .2,
              opacity = 1.0, fillOpacity = 1,
              label=~lapply(Label,HTML),
              labelOptions= labelOptions(direction = 'auto',textsize = "14px"),
              highlightOptions = highlightOptions(
                color='#ff0000', opacity = 1, weight = 2, fillOpacity = 1,
                bringToFront = TRUE, sendToBack = TRUE)) %>%
  addLegend("bottomright", pal = pal, values = ~GoatperPerson,
            title = "Goats/Person",
            opacity = 1)

goatmap <- leaflet(counties) %>% setView(lng = -99.744289, lat = 39.138261, zoom=4.5) %>%
  addPolygons(fillColor = ~pal(GoatperPerson), weight = .2,
              opacity = 1.0, fillOpacity = 1,
              label=~stringr::str_c(
                CountyNameLong, " -- Goats/Person:  ",
                formatC(GoatperPerson, big.mark = ',', format='f')),
              labelOptions= labelOptions(direction = 'auto',textsize = "14px"),
              highlightOptions = highlightOptions(
                color='#ff0000', opacity = 1, weight = 2, fillOpacity = 1,
                bringToFront = TRUE, sendToBack = TRUE)) %>%
  addLegend("bottomright", pal = pal, values = ~GoatperPerson,
            title = "Goats/Person",
            opacity = 1)
saveWidget(goatmap, file="D:/adamcummings.net repo/adamkc.github.io/docs/Goat Analysis/GoatperPersonMap.html", selfcontained = TRUE)

##Only a few counties have more goats than People...
sum(counties@data$GoatperPerson>1, na.rm=TRUE)  #34 counties
