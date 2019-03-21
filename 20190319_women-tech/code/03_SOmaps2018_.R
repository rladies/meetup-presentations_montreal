

# Explore: 

pacman::p_load(dplyr, magrittr, purrr, stringr, summarytools, rworldmap, RColorBrewer, classInt)


# Create a df = table(country & frequency)
countries2018 = as.data.frame(table(df_2018$country))

# Name the columns: country and value (frequency)
colnames(countries2018) = c("country", "value")
head(countries2018)

# Match country names in survey to the country names in package
matched = joinCountryData2Map(countries2018, joinCode="NAME", nameJoinColumn="country", verbose = T)
mapCountryData(matched, nameColumnToPlot="value", mapTitle="Stack Overflow Respondents", catMethod = "pretty", colourPalette = "heat")


# Change color 

colourPalette = RColorBrewer::brewer.pal(5,'RdPu')

# change the legend of the value to be plotted (count) to something more informative 
classInt = classIntervals(countries2018$value, n=5, style="sd")

catMethod = classInt[["sd"]]

mapCountryData(matched, 
               nameColumnToPlot="value", 
               mapTitle="Stack Overflow Respondent",
               colourPalette= colourPalette,  #changed color palette
               oceanCol= 'lightblue', #blue ocean
               catMethod= 'classInt',
               borderCol = 'black', #add black country borders
               missingCountryCol= 'grey') #missing countries in grey



classInt
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")

mapCountryData(matched, 
               nameColumnToPlot="value", 
               mapTitle="Stack Overflow Respondent",
               colourPalette= colourPalette,  #changed color palette
               oceanCol= 'lightblue', #blue ocean
               catMethod= 'catInt', 
               borderCol = 'black', #add black country borders
               missingCountryCol= 'grey') #missing countries in grey

mapParams = mapCountryData(matched, 
                           nameColumnToPlot= 'country',
                           addLegend=FALSE, 
                           catMethod = cat, 
                           colourPalette=colourPalette)

do.call(addMapLegend, c(mapParams, legendLabels="all", legendWidth=0.5, legendIntervals="data", legendMar = 2 ))


# Fix the denominator # It has a population variable, are things being scaled?

# sources
# https://cran.r-project.org/web/packages/rworldmap/vignettes/rworldmapFAQ.pdf
# https://www.springboard.com/blog/maps-in-r/
# classification https://pro.arcgis.com/en/pro-app/help/mapping/layer-properties/data-classification-methods.htm

maps::world.cities %>%
        ggplot() +
        geom_point(aes(x=long, y=lat, size=pop, fill=pop, color=pop), alpha=.1, show.legend = FALSE) + 
        theme_void() +
        coord_equal()
