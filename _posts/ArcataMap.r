library(htmlwidgets)
library(leaflet)

m <- leaflet() %>%
  addTiles() %>%
  addMarkers(lng=-124.083, lat=40.866, popup="Home town") %>%
  setView(lng = -124,lat = 41, zoom = 8)
saveWidget(m, file="ArcataMap.html", selfcontained = TRUE)