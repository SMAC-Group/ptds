library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R") %>% 
  addCircles(lng=174,lat = -36)
m  # Print the map

# add some circles to a map
df = data.frame(Lat = 174, Long = -40)
leaflet(df) %>% addCircles()

leaflet() %>% addTiles() %>% setView(-93.65, 42.0285, zoom = 4) %>%
  addWMSTiles(
    "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
    layers = "nexrad-n0r-900913",
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "Weather data © 2012 IEM Nexrad"
  )

leaflet() %>% setView(lng = 5.3, lat = 50.9, zoom = 17) %>% addTiles() %>%
  addWMSTiles(
    "ch.swisstopo-vd.geometa-standav",
    layers = "GRB_BSK_GRIJS",
    options = WMSTileOptions(format = "image/png", transparent = F)
  )
