library(sf)
library(spData)
library(ggplot2)
library(cowplot)
library(rcartocolor)
library(raster)
library(RStoolbox)
library(landsat8)
library(ggspatial)
library(leaflet)
library(leaflet.extras)
library(leaflet.extras2)
library(leaflet.providers)
Sent_2016      <- raster("Raster/2016_AV.tif")
Concesion      <- st_read("SHP/Concesion.shp")
Concesio       <- st_transform(Concesion ,crs = st_crs("+proj=longlat +datum=WGS84 +no_defs"))

pal =c("#47A612ff", "#8BC60Aff", "#47A612ff", "#8BC60Aff","#83D216ff", "#8BEE1Dff", "#F1FF32ff", "#EACF87ff", "#FFB1FFff", "#FF98C6ff", "#DA62C3ff", "#4F3667ff")

# raster_colorPal_elev <- colorNumeric(palette = terrain.colors(3000),domain = values(band4$X2016_AV),na.color = NA) # Define palette

leaflet() %>%
  addTiles() %>%
  addPolygons(data = Concesio, opacity = 0.8, group ="Concesion MARIZABETH ") %>%
  addRasterImage(Sent_2016 , project = TRUE,colors = pal, group = "Imagen Sentinel 2")%>%
  addLayersControl(baseGroups = c("Satellite", "OSM","OTM","Toner","Terrain","Terrain.ESRI", "Toner Lite","CartoDB.Positron", "relieve"),
                 overlayGroups = c("Imagen Sentinel 2", "Concesion MARIZABETH"),
                 position = "topright",
                 options = layersControlOptions(collapsed = T))%>%
  addProviderTiles(providers$OpenStreetMap, group = "OSM")%>%
  addProviderTiles(providers$Esri.WorldImagery, group = "Satellite")%>%
  addProviderTiles(providers$OpenTopoMap, group = "OTM")%>%
  addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
  addProviderTiles(providers$Stamen.Terrain, group = "Terrain") %>%
  addProviderTiles(providers$Esri.WorldStreetMap, group = "Terrain.ESRI") %>%
  addProviderTiles(providers$CartoDB.Positron, group ="CartoDB.Positron") %>%
  addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
  addMiniMap(tiles = providers$Esri.WorldImagery,toggleDisplay = TRUE)%>%
  addScaleBar(position = "bottomright",options = scaleBarOptions(maxWidth = 100,
                                                                 metric = TRUE,
                                                                 imperial = TRUE,
                                                                 updateWhenIdle = TRUE)) %>%
  addDrawToolbar(targetGroup = "Graficos",editOptions = editToolbarOptions(selectedPathOptions = selectedPathOptions()))%>%
  addMeasure(position = "topleft",
             primaryLengthUnit = "meters",
             primaryAreaUnit = "sqmeters",
             activeColor = "#3D535D",
             completedColor = "#7D4479")%>% 
  addSearchGoogle() %>% 
  addControlGPS() %>% 
  addResetMapButton()

