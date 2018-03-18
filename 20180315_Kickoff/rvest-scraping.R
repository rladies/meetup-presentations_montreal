pacman::p_load(rvest, qdap, dplyr, ggplot2, data.table)

# 1. A single page 

webpage = read_html('https://www.rover.com/search/?centerlat=45.519751&page=1')

# select nodes (regularly occuring pieces of information) from html document 
name_html = html_nodes(webpage, '.sitter-link')

# extract text from html 
name_data = html_text(name_html, trim=FALSE)
name_data = html_text(name_html, trim=TRUE)

cost_html = html_nodes(webpage, '.text-orange strong')
cost_data = html_text(cost_html, trim = TRUE)

ds = data.frame(name_data, cost_data = as.numeric(gsub(x = cost_data, '\\$', '')))


# extract attributes from html 
h = html_attrs(name_html)
# This has the link to the full profile, so we could use this information to scrape more deatils like the number of reviews. 


# 2. We know there are 7 pages, and we want all of the data 

npages = 7 
webpages = paste0( rep('https://www.rover.com/search/?centerlat=45.519751&page=', npages), 
              1:npages)

scrape_rover = function(webpage) { 
  webpage = read_html(webpage)
  name_html = html_nodes(webpage, '.sitter-link')
  name_data = html_text(name_html, trim=TRUE)
  cost_html = html_nodes(webpage, '.text-orange strong')
  cost_data = html_text(cost_html, trim = TRUE)
  ds = data.frame(name_data, cost_data = as.numeric(gsub(x = cost_data, '\\$', '')))
  return(ds)
}

result_list = lapply(X = webpages, FUN = scrape_rover) 

result = rbindlist(result_list) %>% data.frame() 

ggplot(data = result) + 
  geom_histogram(aes(x=cost_data), binwidth=5, fill = 'lightblue', colour = 'white') + 
  geom_vline(xintercept = 35, colour = 'black', linetype = 2) +
  ggtitle('Histogram of Rover.com daily dog sitting prices') 



