---
published: false
layout: post
title: Arcata Weather in Context
---

Arcata has a climate that confuses people. It doesn't snow, it rarely gets hot, and the temperature range on any given day in January is about the same as July. But the precipitation tells a different story — nearly all of it falls between October and April, and the summers are dry enough to make you forget it rains at all.

I came across [John Johnson's Milwaukee weather visualizations](https://github.com/jdjohn215/milwaukee-weather) and thought the same approach would be interesting for Arcata, especially the cumulative precipitation chart. Milwaukee gets rain year-round. Arcata gets a firehose in winter and nothing in summer. That contrast should look dramatic on a cumulative curve.

The data comes from NOAA's [GHCN-Daily](https://www.ncei.noaa.gov/products/land-based-station/global-historical-climatology-network-daily) network, specifically the Arcata/Eureka Airport station (USW00024283), which has records going back to the 1940s.

## Cumulative precipitation

![Cumulative precipitation for Arcata, CA](/images/arcata-cumulative-precip.png)

The steep climb from October through March is where Arcata gets most of its ~40+ inches of annual rainfall. The flat line through summer is the Mediterranean dry season. The historical ribbons show how much year-to-year variation there is — some wet years push well past 50 inches, while dry years barely break 25.

## Daily high temperatures

![Daily high temperatures for Arcata, CA](/images/arcata-daily-high.png)

This is the boring one, in a good way. Arcata's daily highs don't vary much — the marine influence keeps things between 50°F and 65°F for most of the year. The narrow historical ribbons confirm this. There's no real summer spike the way inland cities get. Red and blue dots mark days where the current year set a new record high or low for that date.

## Code

The R scripts that generate these charts are in the [site repo](https://github.com/adamkc/adamkc.github.io/tree/master/scripts/arcata-weather). Run `retrieve_data.R` first to pull the NOAA data, then the two build scripts to generate the plots.
