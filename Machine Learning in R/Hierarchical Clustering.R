#==================================================#
#================== DATA LOADING ==================#
#==================================================#
data("mtcars") # load the dataset; MTCARS stands for "Motor Trend Car Road Tests"
head(mtcars) # see six first row

# see selected data
mtcars["Honda Civic",]
mtcars["Chrysler Imperial",]
mtcars["Pontiac Firebird",]

"
Attributes of mtcars dataset:
- 'mpg' for Miles/(US) Gallon
- 'cyl' for number of Cylinders
- 'disp' for Displacement
- 'hp' for gross Horsepower
- 'drat' for rear axle ratio
- 'wt' for Weight (1000 lbs)
- 'qsec' for quarter time (1/4 mile time)
- 'vs' for engine (0=V-shaped, 1=straight)
- 'am' for transmission (0=auto, 1=manual)
- 'gear' for number of forward Gears
- 'carb' for number of Carburetors
"

#==================================================#
#================ DATA EXPLORATION ================#
#==================================================#
dim(mtcars) # see mtcars' dimension
nrow(mtcars) # see mtcars' total rows
ncol(mtcars) # see mtcars' total columns
names(mtcars) # see mtcars' attributes
summary(mtcars) # see mtcars' statistical info (except for Mode)

cov(mtcars[, 1:11]) # see mtcars' all variance
cov(mtcars$"mpg", mtcars$"hp") # see variance between "mpg" and "hp"

cor(mtcars[, 1:11]) # see mtcars' all correlationc
cor(mtcars$"cyl", mtcars$"drat") # see correlation between "cyl" and "drat"

# see mtcars' mode (most value) for selected attribute
print(names(sort(-table(mtcars$"mpg")))[1])
print(names(sort(-table(mtcars$"cyl")))[1])
print(names(sort(-table(mtcars$"drat")))[1])
print(names(sort(-table(mtcars$"carb")))[1])

#==================================================#
#=============== DATA VISUALIZATION ===============#
#==================================================#
library(ggplot2)

# Histogram Plot for mtcars$mpg
ggplot(mtcars, aes(mpg)) + geom_histogram(binwidth=4) + 
  xlab('Miles per Gallon') + ylab('Number of Cars') + # set xlabel and ylabel
  ggtitle("Distribution of Cars by Mileage") # set title

# Histogram Plot for mtcars$cyl
ggplot(mtcars, aes(cyl)) + geom_histogram(binwidth=1) + 
  xlab('Cylinders') + ylab('Number of Cars') + # set xlabel and ylabel
  ggtitle("Distribution of Cars by Cylinders") # set title

# Histogram Plot for mtcars$hp
ggplot(mtcars, aes(hp)) + geom_histogram(binwidth=20) + 
  xlab('Miles per Gallon') + ylab('Number of Cars') + # set xlabel and ylabel
  ggtitle("Distribution of Cars by Horsepower") # set title

# see mtcars' attribute density for selected attribute
plot(density(mtcars$wt))
plot(density(mtcars$qsec))
plot(density(mtcars$disp))

# Linear Regression Plot between mtcars$hp and mtcars$mpg
ggplot(mtcars, aes(hp, mpg)) + geom_point() +
  geom_smooth(method="lm", se=FALSE) +
  xlab("No. of Hoursepower") + ylab("Miles per Gallon") +
  ggtitle("Impact of Number of Horsepower on MPG")

# Non-Linear Regression Plot between mtcars$hp and mtcars$mpg
ggplot(mtcars, aes(hp, mpg)) + geom_point() + stat_smooth() +
  xlab("No. of Hoursepower") + ylab("Miles per Gallon") +
  ggtitle("Impact of Number of Horsepower on MPG")

# boxplot between mtcars$mpg and mtcars$gear
boxplot(mpg ~ gear, data=mtcars)

# scatter plot matrices between any mtcars' attributes
pairs(~wt+mpg+disp+cyl, data=mtcars, main="Scatter Plot Matrix")

# Hierarchical Clustering for mtcars dataset
hc = hclust(dist(as.matrix(mtcars)))
print(hc)
plot(hc)
heatmap(as.matrix(mtcars), scale="column", margins=c(5,10),
        xlab="Specifications Variables", ylab="Car Models")