library(readr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)
# Read data
weather <- read_csv("../../docs/arcata-weather/ghcn_arcata.csv")

current_year <- year(Sys.Date())

temps <- weather %>%
  filter(!is.na(TMAX)) %>%
  mutate(year = year(date),
         doy = yday(date))

# Historical stats (excluding current year)
historical <- temps %>%
  filter(year != current_year) %>%
  group_by(doy) %>%
  summarise(
    record_low = min(TMAX, na.rm = TRUE),
    p10 = quantile(TMAX, 0.10, na.rm = TRUE),
    p25 = quantile(TMAX, 0.25, na.rm = TRUE),
    p50 = quantile(TMAX, 0.50, na.rm = TRUE),
    p75 = quantile(TMAX, 0.75, na.rm = TRUE),
    p90 = quantile(TMAX, 0.90, na.rm = TRUE),
    record_high = max(TMAX, na.rm = TRUE),
    .groups = "drop"
  )

# Current year
this_year <- temps %>%
  filter(year == current_year)

# Find records broken this year
records <- this_year %>%
  left_join(historical, by = "doy") %>%
  mutate(
    is_record_high = TMAX >= record_high & TMAX > p90,
    is_record_low = TMAX <= record_low & TMAX < p10
  ) %>%
  filter(is_record_high | is_record_low)

# Date labels for x-axis
date_breaks <- as.Date(paste0(current_year, "-", 1:12, "-01"))
date_doy <- yday(date_breaks)
month_labels <- month(date_breaks)

# Historical year range
min_year <- temps %>% filter(year != current_year) %>% pull(year) %>% min()
max_year <- temps %>% filter(year != current_year) %>% pull(year) %>% max()

# Plot
p <- ggplot() +
  # Historical ribbons
  geom_ribbon(data = historical, aes(x = doy, ymin = record_low, ymax = record_high),
              fill = "#fdd0a2", alpha = 0.25) +
  geom_ribbon(data = historical, aes(x = doy, ymin = p10, ymax = p90),
              fill = "#fdae6b", alpha = 0.3) +
  geom_ribbon(data = historical, aes(x = doy, ymin = p25, ymax = p75),
              fill = "#f16913", alpha = 0.2) +
  # Median line
  geom_line(data = historical, aes(x = doy, y = p50),
            color = "#d94801", linewidth = 0.4, linetype = "dashed") +
  # Current year
  geom_line(data = this_year, aes(x = doy, y = TMAX),
            color = "#8b0000", linewidth = 0.7) +
  # Record markers
  {if (nrow(records %>% filter(is_record_high)) > 0)
    geom_point(data = records %>% filter(is_record_high),
               aes(x = doy, y = TMAX), color = "red", size = 2)} +
  {if (nrow(records %>% filter(is_record_low)) > 0)
    geom_point(data = records %>% filter(is_record_low),
               aes(x = doy, y = TMAX), color = "blue", size = 2)} +
  # Styling
  scale_x_continuous(breaks = date_doy, labels = month_labels, expand = c(0.01, 0)) +
  scale_y_continuous(labels = function(x) paste0(x, "\u00B0F")) +
  labs(
    title = paste0("Daily High Temperature — Arcata, CA (", current_year, ")"),
    subtitle = paste0("Current year vs. historical range (", min_year, "–", max_year, ").\n",
                      "Red dots = record highs. Blue dots = record lows for the date."),
    x = NULL, y = "Daily high temperature",
    caption = "Data: NOAA GHCN-Daily, Arcata/Eureka Airport (USW00024283)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.background = element_rect(fill = "linen", color = NA),
    panel.background = element_rect(fill = "linen", color = NA),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "#e0d8cc", linewidth = 0.3),
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "gray40", size = 10),
    plot.caption = element_text(color = "gray50", size = 8),
    axis.text = element_text(color = "gray30")
  )

ggsave("../../images/arcata-daily-high.png", p, width = 10, height = 6, dpi = 150)
cat("Saved images/arcata-daily-high.png\n")
