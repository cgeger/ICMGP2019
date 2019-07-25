# Part III
# Visualization
FLP2018 <- readRDS("data/FLP2018.Rdata")

# Base plot (super flexible, lots of code)
plot(FLP2018$Site, FLP2018$Temp, 
     xlab = "Site",
     ylab = "Temperature in degrees C")
plot(FLP2018$Depth, FLP2018$Temp, col = FLP2018$Date,
     xlab = "Depth",
     ylab = "Temperature in degrees C")



# package(ggplot), fairly flexible and intuitive, better for beginners
# Scatterplot - geom_point
library(ggplot2)
#samples by depth and site
ggplot(data = FLP2018, aes(x = GreenAlgae, y = Depth, color = Site)) +
  geom_point(alpha = 0.5) + 
  scale_y_reverse( lim=c(11, 0)) +
  theme(legend.position = "none") +
  theme_bw()

ggplot(data = FLP2018, aes(x = Site, y =  Diatoms, color = Site))+
  geom_boxplot(outlier.shape = NA) +
  ylab("Diatoms in ug/L")+
  geom_jitter(alpha = 0.25) +
  theme(legend.position = "none")+ scale_color_viridis_d()
# Boxplot
# line/path
# Linear model + confidence intervals
# Facet_grid, facet_wrap
# Leaflet'
install.packages("leaflet")
library(leaflet)
leaflet(data = na.omit(Hg$)) %>%
  leaflet::addTiles() %>%
  leaflet::addCircles(~lon, ~lat, opacity = 0.5)
leaflet(data = Hg$General_Location) %>%
  addTiles() %>%
  addCircles()
# shapefiles

# Plot a point

# Plot several & colourize

# Plot overlay (polygon)

# gganimate

# Show an example



#boxplots

ggplot(data = FLP2018, aes(x = Site, y =  GreenAlgae, color = Site))+
  geom_boxplot(outlier.shape = NA) +
  ylab("Green Algae in ug/L")+
  geom_jitter(alpha = 0.25, width = 0.3) +
  theme(legend.position = "none")

ggplot(data = FLP2018, aes(x = Site, y =  Bluegreen, color = Site))+
  geom_boxplot(outlier.shape = NA) +
  ylab("Bluegreen in ug/L")+
  geom_jitter(alpha = 0.25) +
  theme(legend.position = "none")
ggplot(data = FLP2018, aes(x = Site, y =  Cryptophyta, color = Site))+
  geom_boxplot(outlier.shape = NA) +
  ylab("Cryptophyta in ug/L")+
  geom_jitter(alpha = 0.25) +
  theme(legend.position = "none")

#save the plot
ggsave("F:/CBFS/fluoroprobe/DATA ANALYSIS/Plots/DiatomBoxplot.jpg")

#faceted samples by depth and site
ggplot(data = FLP2018, aes(x = GreenAlgae, y = Depth, color = Site)) +
  geom_point(alpha = 0.5) + 
  scale_y_reverse( lim=c(11, 0)) +
  theme(legend.position = "none") +
  theme_bw()


ggplot(data = FLP2018, aes(x = GreenAlgae, y = Depth, color = Site)) +
  geom_point(alpha = 0.5) + 
  facet_grid( ~Site) +
  scale_y_reverse( lim=c(15.5, 0)) +
  theme(legend.position = "none") +
  theme_bw()

#sample by date
ggplot(data = FLP2018, aes(x = Date, y = Diatoms, color = Site)) +
  geom_point(alpha = 0.2)+
  theme_bw()

#gganimate depth-site Green Algae facets by sample date
ggplot(data = FLP2018, aes(x = GreenAlgae, y = Depth, color = Site)) +
  geom_point(alpha = 0.5) + 
  facet_grid( ~Site) +
  scale_y_reverse( lim=c(15.5, 0)) +
  theme(legend.position = "none") +
  theme_bw() +
  labs(title = 'Date: {frame_time}', 
       x = 'Green Algae in ug/L', 
       y = 'Depth in m') +
  transition_time(Date) +
  ease_aes('linear')

k <- which.max(FLP2018$GreenAlgae)
FLP2018[k,]

FLP2018 %>% group_by(Site) %>% 
  summarize(maxGA = max(GreenAlgae)) %>%
  select(maxGA) %>% unlist



anim <- ggplot(data = FLP2018, aes(x = GreenAlgae, y = Depth, color = Site)) +
  geom_point(size = 2, alpha = 0.5) + 
  facet_grid( ~Site) +
  scale_y_reverse( lim=c(15.5, 0)) +
  theme_bw() +
  labs(title = 'Date: {frame_time}', x = 'Green Algae in ug/L', y = 'Depth in m') +
  transition_time(Date) +
  ease_aes('linear') +
  shadow_mark(alpha = 0.3, size = 0.5) +
  theme(legend.position = "none")

animate(anim, duration = 15, width = 1000, height = 1000)

#gganimate depth-site Bluegreen facets by sample date
ggplot(data = FLP2018, aes(x = Bluegreen, y = Depth, color = Site)) +
  geom_point(alpha = 0.5) + 
  facet_grid( ~Site) +
  scale_y_reverse( lim=c(15.5, 0)) +
  theme(legend.position = "none") +
  theme_bw() +
  labs(title = 'Date: {frame_time}', x = 'Bluegreen in ug/L', y = 'Depth in m') +
  transition_time(Date) +
  ease_aes('linear')

anim <- ggplot(data = FLP2018, aes(x = Bluegreen, y = Depth, color = Site)) +
  geom_point(size = 2, alpha = 0.5) + 
  facet_grid( ~Site) +
  scale_y_reverse( lim=c(15.5, 0)) +
  theme_bw() +
  labs(title = 'Date: {frame_time}', x = 'Bluegreen in ug/L', y = 'Depth in m') +
  transition_time(Date) +
  ease_aes('linear') +
  shadow_mark(alpha = 0.3, size = 0.5) +
  theme(legend.position = "none")

animate(anim, duration = 15, width = 1000, height = 1000)

#gganimate depth-site Diatoms facets by sample date
ggplot(data = FLP2018, aes(x = Diatoms, y = Depth, color = Site)) +
  geom_point(alpha = 0.5) + 
  facet_grid( ~Site) +
  scale_y_reverse( lim=c(15.5, 0)) +
  theme(legend.position = "none") +
  theme_bw() +
  labs(title = 'Date: {frame_time}', x = 'Diatoms in ug/L', y = 'Depth in m') +
  transition_time(Date) +
  ease_aes('linear')

anim <- ggplot(data = FLP2018, aes(x = Diatoms, y = Depth, color = Site)) +
  geom_point(size = 2, alpha = 0.5) + 
  facet_grid( ~Site) +
  scale_y_reverse( lim=c(15.5, 0)) +
  theme_bw() +
  labs(title = 'Date: {frame_time}', x = 'Diatoms in ug/L', y = 'Depth in m') +
  transition_time(Date) +
  ease_aes('linear') +
  shadow_mark(alpha = 0.3, size = 0.5) +
  theme(legend.position = "none")

animate(anim, duration = 15, width = 1000, height = 1000)

#gganimate depth-site Cryptophyta facets by sample date
ggplot(data = FLP2018, aes(x = Cryptophyta, y = Depth, color = Site)) +
  geom_point(alpha = 0.5) + 
  facet_grid( ~Site) +
  scale_y_reverse( lim=c(15.5, 0)) +
  theme(legend.position = "none") +
  theme_bw() +
  labs(title = 'Date: {frame_time}', x = 'Cryptophyta in ug/L', y = 'Depth in m') +
  transition_time(Date) +
  ease_aes('linear')

anim <- ggplot(data = FLP2018, aes(x = Cryptophyta, y = Depth, color = Site)) +
  geom_point(size = 2, alpha = 0.5) + 
  facet_grid( ~Site) +
  scale_y_reverse( lim=c(15.5, 0)) +
  theme_bw() +
  labs(title = 'Date: {frame_time}', x = 'Cryptophyta in ug/L', y = 'Depth in m') +
  transition_time(Date) +
  ease_aes('linear') +
  shadow_mark(alpha = 0.3, size = 0.5) +
  theme(legend.position = "none")

animate(anim, duration = 15, width = 1000, height = 1000)

#FROM GITHUB :)
ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')

