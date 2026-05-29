
library(tidyverse)
0library(ggplot2)
library(dplyr)
library(car)



# 1. Load raw data files


adelaide <- read.csv("adelaide raw data.csv")
perth    <- read.csv("perth raw data.csv")
sydney   <- read.csv("sydney raw data.csv")


# 2. Add city names before combining


adelaide$City <- "Adelaide"
perth$City    <- "Perth"
sydney$City   <- "Sydney"


# 3. Combine data


rainfall_data <- rbind(adelaide, perth, sydney)


# 4. Clean and filter data to 1976-2025


rainfall_data$City <- as.factor(rainfall_data$City)
rainfall_data$Year <- as.numeric(rainfall_data$Year)
rainfall_data$Annual <- as.numeric(rainfall_data$Annual)

rainfall_data <- rainfall_data[
  rainfall_data$Year >= 1976 &
    rainfall_data$Year <= 2025 &
    !is.na(rainfall_data$Annual),
]


# 5. Check data
str(rainfall_data)
head(rainfall_data)
table(rainfall_data$City)


# 6. Descriptive statistics table


desc_stats <- rainfall_data %>%
  group_by(City) %>%
  summarise(
    Min = min(Annual, na.rm = TRUE),
    Q1 = quantile(Annual, 0.25, na.rm = TRUE),
    Median = median(Annual, na.rm = TRUE),
    Mean = mean(Annual, na.rm = TRUE),
    Q3 = quantile(Annual, 0.75, na.rm = TRUE),
    Max = max(Annual, na.rm = TRUE),
    SD = sd(Annual, na.rm = TRUE),
    .groups = "drop"
  )

print(desc_stats)



# 7. Figure 3: Mean annual rainfall bar chart


mean_plot <- rainfall_data %>%
  group_by(City) %>%
  summarise(
    MeanRainfall = mean(Annual, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  ggplot(aes(x = City, y = MeanRainfall)) +
  geom_col(fill = "steelblue", width = 0.65) +
  labs(
    title = "Mean Annual Rainfall by City, 1976-2025",
    x = "City",
    y = "Mean Annual Rainfall (mm)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(hjust = 0.5)
  )

print(mean_plot)


# 8. Figure 4: Boxplot


box_plot <- ggplot(rainfall_data, aes(x = City, y = Annual)) +
  geom_boxplot(fill = "lightblue", width = 0.60) +
  labs(
    title = "Annual Rainfall Distribution by City, 1976-2025",
    x = "City",
    y = "Annual Rainfall (mm)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(hjust = 0.5)
  )

print(box_plot)



# 9. Figure 5: Combined time-series plot


time_series_plot <- ggplot(
  rainfall_data,
  aes(x = Year, y = Annual, colour = City, group = City)
) +
  geom_line(linewidth = 0.8) +
  labs(
    title = "Annual Rainfall Over Time, 1976-2025",
    x = "Year",
    y = "Annual Rainfall (mm)",
    colour = "City"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.position = "bottom"
  )

print(time_series_plot)



# 10. ANOVA assumption checking


sd_check <- rainfall_data %>%
  group_by(City) %>%
  summarise(
    SD = sd(Annual, na.rm = TRUE),
    .groups = "drop"
  )

print(sd_check)

sd_ratio <- max(sd_check$SD) / min(sd_check$SD)

print(sd_ratio)



# 15. Final inferential test: Kruskal-Wallis

# H0: Annual rainfall distributions are the same across the three cities.
# H1: At least one city has a different annual rainfall distribution.

kruskal_result <- kruskal.test(Annual ~ City, data = rainfall_data)

print(kruskal_result)
