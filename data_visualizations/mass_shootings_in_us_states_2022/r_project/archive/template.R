library(tidyverse)
library(gganimate)
library(RColorBrewer)

dataset <- read_csv("dataset.csv")
custom_palette <- colorRampPalette(brewer.pal(8, "Set2"))(length(unique(dataset$state)))

output <- dataset |>
  mutate(state = if_else(state == "District of Columbia", "Dist. Columbia", state)) |>
  ggplot() +
  scale_fill_manual(values = custom_palette) +
  geom_col(aes(year_rank, victims_per_1m, fill = state, alpha = 0.95)) +
  geom_text(aes(year_rank, victims_per_1m, label = as.character(round(victims_per_1m, 1))), hjust=1) +
  geom_text(aes(year_rank, y=0 , label = state), hjust=1.1) + 
  geom_text(aes(x=15, y=max(victims_per_1m) , label = as.factor(year)), vjust = 0.2, alpha = 0.5,  col = "gray", size = 20) +
  coord_flip(clip = "off", expand = FALSE) + scale_x_reverse() +
  theme_minimal() + theme(
    panel.grid = element_blank(), 
    legend.position = "none",
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    axis.title = element_blank(),
    plot.margin = margin(1, 4, 1, 3, "cm")
  ) +
  ggtitle("US States Mass Shootings Victims per 1M") +
  transition_states(year, state_length = 0, transition_length = 2) +
  enter_fade() +
  exit_fade() + 
  ease_aes('quadratic-in-out')

animate(output, renderer = ffmpeg_renderer(), width = 1920, height = 1080, fps = 25, duration = 15, rewind = FALSE)
anim_save("animation.mp4")
