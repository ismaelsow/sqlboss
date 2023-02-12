library(tidyverse)
library(gganimate)
library(RColorBrewer)

custom_palette <- colorRampPalette(brewer.pal(8, "Set2"))(14)

dataset <- read_csv("dataset.csv")

dataset |>
  filter(year == 2015) |>
  ggplot() +
  scale_fill_manual(values = custom_palette) +
  geom_bar(aes(reorder(state, -year_rank), victims_per_1m, fill = state, alpha = 0.8), stat = "identity") +
  geom_text(aes(state, victims_per_1m, label = as.character(round(victims_per_1m, 1))), hjust = 1.5) +
  coord_flip() +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    legend.position = "none",
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    axis.text.x = element_blank(),
  )
