library(htmlwidgets)
library(leaflet)

m <- leaflet() %>% addProviderTiles(providers$Stamen.Toner) %>%
  #addTiles() %>%
  addMarkers(lng=-124.083, lat=40.866, popup="Home town") %>%
  setView(lng = -124,lat = 40.8, zoom = 11)
saveWidget(m, file="D:/adamcummings.net repo/adamkc.github.io/scripts/ArcataMap.html", selfcontained = TRUE)