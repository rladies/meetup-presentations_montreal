

pacman::p_load(dplyr, magrittr, ggplot2, countrycode, ggrepel, summarytools, tidyr)

# GDP data
# https://data.oecd.org/gdp/gross-domestic-product-gdp.htm

# Tech jobs data
# Source: https://www.honeypot.io/women-in-tech-2018/

# GDP data
gdp = read.csv('data/GDP.csv')


# Women in tech jobs data
tech_jobs = readRDS("data/tech_jobs.rds")


# Map names from 3-letter abbreviation to full names
gdp$country = countrycode(gdp$LOCATION, 'iso3c', 'country.name')

# Join tech jobs and GDP, create percentage for "women in tech"
df = tech_jobs %>% left_join(gdp) %>% 
        na.omit()

# Women in tech jobs by region 
# Add continent to data frame
df$continent = countrycode(df$country,"country.name", "continent")

tech = df %>% select(continent, tech_perc, tech_perc_women, stem_perc_women_grad) %>% 
        gather(key = 'tech.ind', value = 'percentage', -continent) 

labels_tech = c(tech_perc = "% tech", tech_perc_women = "% women tech", stem_perc_women_grad = "% women STEM grad" )
labels_continent = c(Americas = "Americas n = 12", Asia = "Asia n = 15", Europe = "Europe n = 84", Oceania = "Oceania n = 6")


ggplot(data = tech, aes(x = percentage)) + 
        geom_freqpoly() + 
        facet_grid(continent~tech.ind, labeller = labeller(tech.ind = labels_tech, continent = labels_continent)) 


# Bubble chart
ggplot(data = df, aes(x = tech_avg_wage, y = tech_perc_women)) +
        geom_point() + 
        geom_text_repel(aes(label=LOCATION), size = 3) +
        scale_x_continuous(labels = scales::dollar) +
        #scale_y_continuous(labels = scales::percent) + 
        labs(
                title = "Salary of Women in Tech, by Country ",
                caption = "Source: https://www.honeypot.io/women-in-tech-2018/",
                x = "Avg salary in USD ($)",
                y = "Percentage of women in tech") +
        guides(size = FALSE) +
        theme_bw() 
theme(panel.grid.major.x = element_blank(),
      legend.position = 'none')



# add column for worsening for improving wage gap 
df  %<>% mutate(wagegap = ifelse(change_paygap<0, "Worsened", "Improved"))


# This plot takes a minute to render :( 

ggplot(df) + 
        geom_segment(aes(y=reorder(country, change_paygap), yend=country, x=0, xend=change_paygap, color=wagegap), size=1.3, alpha=0.9) + 
        geom_vline(xintercept = 0) + 
        labs(
                title = "Change in Gender Pay Gap, 2010-2015",
                caption = "Source: https://www.honeypot.io/women-in-tech-2018/",
                x = "Pay gap between 2010 and 2015",
                y = "Country") + 
        scale_color_manual(values=c("green","red")) + 
        scale_y_discrete(labels=c("Canada"=expression(bold('Canada')), "United States"=expression(bold('United States')), parse=TRUE))



ggplot(df) + 
        geom_segment(aes(y=reorder(country, inequality_index), yend=country, x=0, xend=inequality_index), size=1.3, alpha=0.5, colour = 'purple') + 
        geom_vline(xintercept = 0) + 
        labs(
                title = "Inequality Index, by Country",
                caption = "Source: https://www.honeypot.io/women-in-tech-2018/",
                x = "Inequality index = close to 0 is more equality",
                y = "Country") + 
        scale_y_discrete(labels=c("Canada"=expression(bold('Canada')), "United States"=expression(bold('United States')), parse=TRUE)) + 
        scale_x_continuous(expand = c(0,0))


