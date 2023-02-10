library(tidyverse)
library(gganimate)
library(RColorBrewer)


dataset <- read_csv("dataset.csv")
custom_palette <- colorRampPalette(brewer.pal(8, "Set2"))(length(unique(dataset$state)))

output = dataset |>
  ggplot() +
  scale_fill_manual(values = custom_palette) +
  geom_bar(aes(reorder(year_rank, -year_rank), victims_per_1m, fill = state, alpha = 0.95), stat = "identity") +
  geom_text(aes(reorder(year_rank, -year_rank), victims_per_1m, label = as.character(state)))  +
  geom_text(aes(reorder(year_rank, -year_rank), victims_per_1m, label = as.character(round(victims_per_1m, 1))), position=position_stack(vjust=0.5)) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    legend.position = "none",
    axis.ticks.y = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_b
  ) +
  coord_flip(clip = "off") +
  transition_states(year, state_length = 0, transition_length = 2) +
  enter_fade() +
  exit_fade() + 
  ease_aes('quadratic-in-out')

animate(output, renderer = ffmpeg_renderer())
