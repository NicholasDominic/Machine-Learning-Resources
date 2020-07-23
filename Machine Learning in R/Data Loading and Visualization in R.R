# Load the dataset
df = read.csv("data/House_Price.csv", header=TRUE)

str(df) # see all variables and its data types
summary(df) # to open Extended Data Dictionary (EDD)

# Data Visualization
hist(df$crime_rate)
barplot(table(df$airport))

# Null Value Imputation
df$n_hos_beds[is.na(df$n_hos_beds)] = mean(df$n_hos_beds, na.rm=TRUE)
which(is.na(df$n_hos_beds)) # check if there's still null/NA values

# Create dummy variables (one-hot code for categorical data)
library(dummies)
df = dummy.data.frame(df)
