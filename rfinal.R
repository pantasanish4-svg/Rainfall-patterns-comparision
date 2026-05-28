# Author: Group GRIFFIN
# Last Modified: 28/05/2026


library(tidyverse)
library(dplyr)
library(ggplot2)
library(car)



# 2. Load data

adelaide <- read.csv("adelaide.csv")
perth    <- read.csv("perth.csv")
sydney   <- read.csv("sydney.csv")



# 3. Add city names before combining


adelaide <- adelaide %>%
  mutate(City = "Adelaide")

perth <- perth %>%
  mutate(City = "Perth")

sydney <- sydney %>%
  mutate(City = "Sydney")



# 4. Combine files into one dataset


rainfall_data <- bind_rows(adelaide, perth, sydney)


# 5. Clean and prepare data


rainfall_data <- rainfall_data %>%
  mutate(
    City = as.factor(City),
    Year = as.numeric(Year),
    Annual = as.numeric(Annual)
  ) %>%
  filter(
    Year >= 1976,
    Year <= 2025,
    !is.na(Annual)
  )


# Check the cleaned data

str(rainfall_data)
head(rainfall_data)
table(rainfall_data$City)


# 6. Descriptive statistics



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

write.csv(desc_stats, "descriptive_statistics.csv", row.names = FALSE)


# 7. Mean annual rainfall bar chart


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




# 8. Boxplot of annual rainfall


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





# 9. Time-series plot

 
 ggplot(rainfall_data,
                           aes(x = Year, y = Annual, colour = City, group = City)) +
  geom_line(linewidth = 0.8) +
  labs(
    title = "Annual Rainfall Over Time, 1976–2025",
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


 
# 12. Final inferential method: Kruskal-Wallis test

# H0: Annual rainfall distributions are the same across
#     Adelaide, Perth and Sydney.
#
# H1: At least one city has a different annual rainfall
#     distribution.

kruskal_result <- kruskal.test(Annual ~ City, data = rainfall_data)

print(kruskal_result)

