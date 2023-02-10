library(tidyverse)
library(gganimate)
library(RColorBrewer)

dataset <- read_csv("dataset.csv")
custom_palette <- colorRampPalette(brewer.pal(8, "Set2"))(49)

animation <- dataset |>
  group_by(year) |>
  arrange(year, -victims_per_1m) |>
  mutate(rank = row_number()) |>
  filter(rank <= 10) |>
  ggplot() +
    scale_fill_manual(values = custom_palette) +
    geom_bar(aes(rank, victims_per_1m, fill = state, alpha = 0.8), stat= "identity") +
    geom_text(aes(rank, victims_per_1m, label = victims_per_1m), hjust=-0.1) +
    geom_text(aes(rank, y=0 , label = state), hjust=1.1) +
    geom_text(aes(x=15, y=max(victims_per_1m) , label = as.factor(year)), vjust = 0.2, alpha = 0.5,  col = "gray", size = 20) +
  coord_flip(clip = "off", expand = FALSE) + scale_x_reverse() +
    scale_fill_manual(values = custom_palette) +
    theme_minimal() +
    theme(
      panel.grid = element_blank(), 
      legend.position = "none",
      axis.ticks.y = element_blank(),
      axis.title.y = element_blank(),
      axis.text.y = element_blank(),
      plot.margin = margin(1, 4, 1, 3, "cm")
    ) +
    labs(title = "Mass shootings victims in US States", y = "Victims (killed + injured)") +
    transition_time(year) +
    enter_fade() +
    exit_fade() +
    ease_aes('quadratic-in-out')

animate(animation, renderer = ffmpeg_renderer())