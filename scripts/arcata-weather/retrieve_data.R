library(data.table)
library(R.utils)
library(tidyr)
library(dplyr)
library(readr)
library(lubridate)

# Arcata/Eureka Airport station
station <- "USW00024283"
url <- paste0("https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/by_station/", station, ".csv.gz")

# Download and decompress
temp_gz <- tempfile(fileext = ".csv.gz")
temp_csv <- tempfile(fileext = ".csv")
download.file(url, temp_gz, mode = "wb")
gunzip(temp_gz, temp_csv, remove = FALSE)

# Read raw GHCN data (no header)
raw <- fread(temp_csv, header = FALSE,
             col.names = c("station", "date", "element", "value",
                           "mflag", "qflag", "sflag", "obstime"))

# Keep only the variables we need, drop flagged observations
weather <- raw %>%
  filter(element %in% c("PRCP", "TMAX", "TMIN", "SNOW", "SNWD"),
         qflag == "") %>%
  select(date, element, value) %>%
  mutate(date = ymd(date)) %>%
  pivot_wider(names_from = element, values_from = value)

# Convert units: tenths of mm -> inches, tenths of C -> F
weather <- weather %>%
  mutate(
    PRCP = PRCP / 254,          # tenths of mm to inches
    TMAX = (TMAX / 10) * 9/5 + 32,
    TMIN = (TMIN / 10) * 9/5 + 32,
    SNOW = SNOW / 254,
    SNWD = SNWD / 254
  )

# Write output
out_dir <- file.path(dirname(dirname(getwd())), "docs", "arcata-weather")
if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)
write_csv(weather, file.path(out_dir, "ghcn_arcata.csv"))

cat("Data saved to docs/arcata-weather/ghcn_arcata.csv\n")
cat(paste("Records:", nrow(weather), "\n"))
cat(paste("Date range:", min(weather$date), "to", max(weather$date), "\n"))

# Clean up
unlink(c(temp_gz, temp_csv))
