### Rainfall-patterns-comparision

## Project Overview

This project was completed for Engineering Data Analytics. The aim was to compare annual rainfall patterns across Adelaide, Perth and Sydney using Bureau of Meteorology rainfall data from 1976 to 2025.

The analysis compares mean annual rainfall, rainfall variability and long-term rainfall patterns across the three cities. Descriptive statistics, graphs, ANOVA assumption checking and a Kruskal-Wallis test were used.

## Group Name

GRIFFIN

## Group Members

- Bishal Pudasaini (a3192432)
- Dipendra Shah (a3196723)
- Sahil Sinchuiri (a3191695)
- Sanish Panta (a1991057)
- Sunil Shrestha (a3202634)

## Data

The data were obtained from the Australian Bureau of Meteorology Climate Data Online service.

Files included:

- `data/adelaide.csv`
- `data/perth.csv`
- `data/sydney.csv`

Each file contains rainfall records for one city. The analysis used annual rainfall data from 1976 to 2025.

## Code

The R code used for the analysis is provided in:

- `updatedRcode`

The code includes:

- data loading
- data cleaning
- descriptive statistics
- graphs
- ANOVA assumption checking
- Kruskal-Wallis test

## Outputs

The output folder contains figures and tables used in the report, including:

- study area map
- methodology flow chart
- mean rainfall bar chart
- rainfall boxplot
- rainfall time-series plot


## Main Findings

Sydney had the highest mean annual rainfall and the largest year-to-year variation. Perth had moderate rainfall and moderate variation. Adelaide had the lowest mean annual rainfall and the smallest spread.

The Kruskal-Wallis test showed that annual rainfall distributions were significantly different across the three cities.

## Software Used

- R
- RStudio
- ggplot2
- dplyr
- car
