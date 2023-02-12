library(tidyverse)
library(calendR)
library(plotly)
library(htmlwidgets)

dataset <- read.csv("../datasets/dataframe.csv")

text <- paste("Countries:", dataset$holidays)

p = calendR(year = 2022,
        special.days = as.vector(dataset$holidays),
        gradient = TRUE,
        low.col = "#FFFFFF",
        special.col = rgb(1, 0, 0, alpha = 0.6),
        legend.pos = "right",
        legend.title = "Celebrating\ncountries",
        orientation = "portrait",
        start = "M",
        title = "Public Holidays in the World (2022)",
        font.family = "Roboto Condensed") +
        aes(text=paste('Countries celebrating: ', dataset$holidays))

p

pp <- ggplotly(p, tooltip = "text") |>
  layout(title = list(text = paste0('Public Holidays in the World (2022)',
                                    '<br>',
                                    '<sup>',
                                    ' ',
                                    '</sup>')))
saveWidget(config(pp, displayModeBar = FALSE), file="../assets/public-holidays.html")