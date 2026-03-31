library(readr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)

# Read data
weather <- read_csv("../../docs/arcata-weather/ghcn_arcata.csv")

current_year <- year(Sys.Date())

# Add day-of-year and year columns
precip <- weather %>%
  filter(!is.na(PRCP)) %>%
  mutate(year = year(date),
         doy = yday(date)) %>%
  # Only use complete years (>= 360 days) for historical stats, plus current year
  group_by(year) %>%
  mutate(days_in_year = n()) %>%
  ungroup() %>%
  filter(days_in_year >= 360 | year == current_year)

# Calculate cumulative precipitation by year
cumulative <- precip %>%
  arrange(year, doy) %>%
  group_by(year) %>%
  mutate(cum_precip = cumsum(PRCP)) %>%
  ungroup()

# Historical stats (excluding current year)
historical <- cumulative %>%
  filter(year != current_year) %>%
  group_by(doy) %>%
  summarise(
    p10 = quantile(cum_precip, 0.10, na.rm = TRUE),
    p25 = quantile(cum_precip, 0.25, na.rm = TRUE),
    p50 = quantile(cum_precip, 0.50, na.rm = TRUE),
    p75 = quantile(cum_precip, 0.75, na.rm = TRUE),
    p90 = quantile(cum_precip, 0.90, na.rm = TRUE),
    .groups = "drop"
  )

# Current year data
this_year <- cumulative %>%
  filter(year == current_year)

# Date labels for x-axis
date_breaks <- as.Date(paste0(current_year, "-", 1:12, "-01"))
date_doy <- yday(date_breaks)
month_labels <- month(date_breaks)

# Find where current year stands vs. median at latest day
latest <- this_year %>% filter(doy == max(doy))
median_at_latest <- historical %>% filter(doy == latest$doy) %>% pull(p50)
diff_inches <- round(latest$cum_precip - median_at_latest, 1)
diff_label <- ifelse(diff_inches >= 0,
                     paste0("+", diff_inches, "\" vs. median"),
                     paste0(diff_inches, "\" vs. median"))

# Historical year range
min_year <- cumulative %>% filter(year != current_year) %>% pull(year) %>% min()
max_year <- cumulative %>% filter(year != current_year) %>% pull(year) %>% max()

# Plot
p <- ggplot() +
  # Historical ribbons
  geom_ribbon(data = historical, aes(x = doy, ymin = p10, ymax = p90),
              fill = "#a6bddb", alpha = 0.3) +
  geom_ribbon(data = historical, aes(x = doy, ymin = p25, ymax = p75),
              fill = "#a6bddb", alpha = 0.4) +
  # Median line
  geom_line(data = historical, aes(x = doy, y = p50),
            color = "#74a9cf", linewidth = 0.5, linetype = "dashed") +
  # Current year

  geom_line(data = this_year, aes(x = doy, y = cum_precip),
            color = "#2171b5", linewidth = 1) +
  # Annotation
  annotate("text", x = latest$doy + 5, y = latest$cum_precip,
           label = paste0(current_year, "\n", round(latest$cum_precip, 1), "\"\n",
                          diff_label),
           hjust = 0, size = 3, color = "#2171b5", fontface = "bold") +
  # Styling
  scale_x_continuous(breaks = date_doy, labels = month_labels, expand = c(0.01, 0)) +
  scale_y_continuous(labels = function(x) paste0(x, "\"")) +
  labs(
    title = paste0("Cumulative Precipitation — Arcata, CA (", current_year, ")"),
    subtitle = paste0("Current year vs. historical range (", min_year, "–", max_year, ")"),
    x = NULL, y = "Cumulative precipitation (inches)",
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

ggsave("../../images/arcata-cumulative-precip.png", p, width = 10, height = 6, dpi = 150)
cat("Saved images/arcata-cumulative-precip.png\n")
