# =============================
# Introduction to R: Basic Statistical Analysis
# =============================

# --- Initial Setup ---
# Clean R environment
rm(list = ls())

# Set working directory
# Specify your working folder path
# Replace XXX with the folder path containing your CSV file
setwd('/Users/XXX')
print(getwd())

# Install required packages (if needed)
# install.packages("gtsummary")
# install.packages("tidyverse")
# install.packages("stargazer")
# install.packages("modelsummary")

# Load required libraries
library(gtsummary)
library(tidyverse)

# --- Data Loading ---
# Read the CSV file
# "data.csv" should be prepared in advance
data <- read.csv("data.csv")

#Confirmation of the data set
str(data)
#Converting to factor type
data$intervention <- factor(data$intervention)

# --- T-test and Basic Statistics ---
# Perform t-test comparing scores between intervention(1) and control(0) groups
t_test_result <- t.test(score ~ intervention, data = data, var.equal = TRUE)
print(t_test_result)  # Display results

# Calculate mean and standard deviation for each group
group_stats <- tapply(data$score, data$intervention, function(x) {
  c(mean = mean(x), sd = sd(x), n = length(x))
})
print(group_stats)

# --- Create Boxplot ---
# Set graphic parameters
par(cex.main = 1.5,    # Title font size
    cex.lab = 1.3,     # Axis label font size
    cex.axis = 1.2)    # Axis tick label font size

# Create boxplot
boxplot(score ~ intervention, data = data,
        main = "Score by Intervention Group",
        xlab = "Intervention",
        ylab = "Score")

# Using tidyplots to create boxplot
library(tidyplots)
data %>% 
  tidyplot(x = intervention, y = score, color =  intervention,width = 100, height = 60) %>% 
  #add_mean_bar(alpha = 0.4) %>% 
  #add_sem_errorbar() %>% 
  add_data_points_beeswarm() %>%
  adjust_padding(bottom = 0.05) %>% 
  add_boxplot(fill = NA) %>% 
  adjust_colors(colors_discrete_apple) +
  theme(
    text = element_text(size = 16),           # Overall font size
    axis.text = element_text(size = 14),      # Font size for axis labels
    axis.title = element_text(size = 16),     # Font size for axis titles
    legend.text = element_text(size = 14),    # Font size for legend text
    legend.title = element_text(size = 16)    # Font size for legend title
  )

# --- Multiple Regression Analysis ---
# Load additional packages
library(stargazer)
library(modelsummary)

# Perform multiple regression
model <- lm(score ~ weight + age, data = data)
summary(model)  # Display regression summary
msummary(model)  # Alternative output format

# Generate formatted regression table (text format)
stargazer(model, 
          type = "text",
          title = "Regression Results",
          digits = 2,
          font.size = "large",
          column.sep.width = "3",
          dep.var.labels = "Score",
          covariate.labels = c("Weight", "Age"),
          notes.label = "Notes:",
          notes = "p<0.1; p<0.05; *p<0.01")

# --- Diagnostic Plots ---
# Display basic diagnostic plots
par(mfrow = c(2,2), cex.main = 1.3, cex.lab = 1.2, cex.axis = 1.1)
plot(model)

# --- Correlation Matrix ---
# Check correlations between variables
cor_matrix <- cor(data[c("score", "weight", "age")])
print(round(cor_matrix, 3))

# --- Descriptive Statistics ---
# Display basic descriptive statistics
summary_stats <- data.frame(
  Mean = apply(data[c("score", "weight", "age")], 2, mean),
  SD = apply(data[c("score", "weight", "age")], 2, sd),
  Min = apply(data[c("score", "weight", "age")], 2, min),
  Max = apply(data[c("score", "weight", "age")], 2, max)
)
print(round(summary_stats, 2))

# --- Create Table using gtsummary ---
# Generate formatted summary table
reset_gtsummary_theme()
table1 <- data %>% 
  mutate(intervention = factor(intervention, labels = c("Exercise", "Control"))) %>% 
  tbl_summary(by = intervention,
              statistic = list(age ~ "{mean}({sd})",
                               weight ~ "{mean}({sd})",
                               score ~ "{mean}({sd})"),
              digits = list(c(age, weight, score) ~ c(1, 1)),
              label = list(age ~ "Age (yr)",
                           sex ~ "Sex",
                           weight ~ "Weight (kg)",
                           score ~ "Accuracy (%)")) %>% 
  add_p(list(age ~ "t.test",
             weight ~ "t.test",
             score ~ "t.test")) %>% 
  modify_spanning_header(starts_with("stat") ~ "Treatment") %>% 
  modify_header(label = "Characteristics") %>% 
  add_overall() %>%   
  bold_labels()
table1
