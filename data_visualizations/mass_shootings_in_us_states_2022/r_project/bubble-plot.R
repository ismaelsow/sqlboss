library(tidyverse)
library(hrbrthemes)
library(plotly)
library(htmlwidgets)

dataset <- read_csv("dataset.csv")
p = dataset |>
  filter(year == 2022) |>
  
  # Classic ggplot
  ggplot(aes(
    x = population_in_m,
    y = victims_per_1m,
    size = population_in_m,
    fill=region,
    text = paste(
      "Region: ",region,
      "\nState: ", state,
      "\nPopulation (M): ", population_in_m,
      "\nVictims per 1M: ", victims_per_1m,
    sep="")
  )) +
  scale_fill_manual(values = custom_palette) +
  geom_point(alpha = 0.5, color = "black", shape = 21) +
  scale_size(range = c(.1, 14), name="pop. (M)") +
  guides(fill = guide_legend(override.aes = list(size = 6))) +
  theme_ft_rc() +
  theme(
    legend.position = "bottom",
    legend.box = "vertical",
    axis.line = element_line(color='white'),
    axis.text.y = element_text(margin = margin(r = 10)),
    axis.text.x = element_text(margin = margin(t = 10)),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
  ) +
  labs(
    title = "Mass Shootings Victims in US States (2022)",
    subtitle = "Killed & injured per 1M people",
    x = "Population (M)",
    y = ""
  ) +
  scale_fill_discrete(name="")

# save the image
p
ggsave("mass-shootings.png", bg = "white")

# turn ggplot interactive with plotly
pp <- ggplotly(p, tooltip="text") |>
  layout(title = list(text = paste0('Mass Shootings Victims in US States (2022)',
                                    '<br>',
                                    '<sup>',
                                    'Killed & injured per 1M people',
                                    '</sup>')))
saveWidget(config(pp, displayModeBar = FALSE), file="mass-shootings.html") 