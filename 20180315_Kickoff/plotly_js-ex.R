#!/usr/bin/env Rscript
library(plotly)
library(htmlwidgets)
search <- paste0(
  "http://google.com/#q=", curl::curl_escape(rownames(mtcars))
)
p <- (plot_ly(mtcars, x = ~wt, y = ~mpg, color = ~factor(vs)) %>%
  add_markers(text = ~search, hoverinfo = "x+y") %>%
  onRender("
    function(el, x) {
      el.on('plotly_click', function(d) {
        // d.points is an array of objects which, in this case,
        // is length 1 since the click is tied to 1 point.
        var pt = d.points[0];
        var url = pt.data.text[pt.pointNumber];
        // DISCLAIMER: this won't work from RStudio
        window.open(url);
      });
    }
  ")
)
# Then run p in R :)
