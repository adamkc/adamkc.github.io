---
published: true
layout: post
title: Arcata Weather in Context
---

Arcata has a climate that confuses people. It doesn't snow, it rarely gets hot, and January looks about the same as July on a thermometer. The precipitation is a different story. Nearly all of it falls between October and April, and the summers are dry enough to make you forget it rains at all.

I came across [John Johnson's Milwaukee weather visualizations](https://github.com/jdjohn215/milwaukee-weather) and thought the same approach would work well for Arcata, especially the cumulative precipitation chart. Milwaukee gets rain year-round. Arcata gets a firehose in winter and nothing in summer. That contrast should look dramatic on a cumulative curve.

Data comes from NOAA's [GHCN-Daily](https://www.ncei.noaa.gov/products/land-based-station/global-historical-climatology-network-daily) network, Arcata/Eureka Airport station (USW00024283), with records back to 1992.

## Cumulative precipitation

![Cumulative precipitation for Arcata, CA](/images/arcata-cumulative-precip.png)

The steep climb from October through March is where most of the ~40 annual inches land. Then flat. The ribbons show how much year-to-year variation there is — wet years clear 50 inches, dry years barely crack 25.

## Daily high temperatures

![Daily high temperatures for Arcata, CA](/images/arcata-daily-high.png)

This is the boring chart, in a good way. The marine layer keeps daily highs between 50°F and 65°F for most of the year, with almost no summer spike. Red dots are record highs for the date, blue are record lows.

## Code

R scripts are in the [site repo](https://github.com/adamkc/adamkc.github.io/tree/master/scripts/arcata-weather). Run `retrieve_data.R` first, then the two build scripts.
