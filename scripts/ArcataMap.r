library(htmlwidgets)
library(leaflet)

m <- leaflet() %>%
  addTiles() %>%
  addMarkers(lng=-124.083, lat=40.866, popup="Home town") %>%
  setView(lng = -124,lat = 41, zoom = 8)
saveWidget(m, file="D:/adamcummings.net repo/adamkc.github.io/scripts/ArcataMap.html", selfcontained = TRUE)