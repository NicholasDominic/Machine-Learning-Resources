# R is case sensitive programming language
# To clear RStudio Console, press CTRL+L

# Set current directory
# 1. using setwd("...")
setwd("E:/DATA SCIENCE/MACHINE LEARNING/R - Regression")
# 2. go to menu Session > Set Working Directory
# You can also apply default working directory on menu Tools > Global Options > General

# List of all variables: ls()
ls()
# Delete selected variable: rm(...) or remove(...)
# Therefore to delete all variables: rm(list=ls())

# Multiple assignment var1 <- var2 <- ... <- varN
# To create an array/list, use start_num:end_num or c(start_num:end_num)
a = b = (1:10)*2
d = c(1:10)

# To create a custom sequence
# 1. sequence(total_num, start_num, by=step)
e = sequence(5, 100, by=25)
# 2. seq(start_num, end_num, by=step)
f = seq(5, 100, by=20)

# To browse, type browseURL(...)
browseURL("http://cran.r-project.org/web/views/")

# To show all libraries: library()
# To show current loaded libraries: search()
search()

# To install new R Library: install.packages("...")
# To uninstall R Library: remove.packages("...")
install.packages("LiblineaR")

# To import library:
# 1. see tab PACKAGES on right below nav and checklist the checkbox
# 2. execute this code, require("...")
require("LiblineaR")

# To remove library:
# 1. see tab PACKAGES on right below nav and unchecklist the checkbox
# 2. excute this code, detach("package:...", unload=TRUE)
detach("package:LiblineaR", unload=TRUE)

# To see R library's documentation or help: ? library_name or help(library_name)
? stats
help(stats)

# To see R list of datasets (see datasets R library/package)
data()

# To see all data in selected dataset, just type its name
iris

# But to load it into Global Environment (for use), type data(...)
data(iris)

# To see the structure of selected dataset
str(iris) # from Iris dataset

# Load dataset from given .txt
Product = read.table("data/Product.txt", header=TRUE, sep="\t")
str(Product) # see all features (structure of dataset)
Product # all dataset are opened in R Console
View(Product) # all dataset are opened in new window

# Load dataset from given .csv
Customer = read.csv("data/Customer.csv", header=TRUE)
str(Customer) # see all features (structure of dataset)
Customer # all dataset are opened in R Console
View(Customer) # all dataset are opened in new window

# BARPLOT
# Documentation of Barplot (its parameters)
browseURL("https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/barplot")

y_customer = table(Customer$Region)
barplot(y_customer)
barplot(y_customer[order(y_customer)]) # ascending order
barplot(y_customer[order(-y_customer)]) # descending order
barplot(y_customer, horiz=TRUE) # horizontal barplot

colors() # see available colors in R
barplot(y_customer, col="green")
barplot(y_customer, col=c("red", "green", "yellow", "blue"))

barplot(y_customer, border=NA) # remove outside border in each barplot
barplot(y_customer, main="Freq of Regions") # set barplot title
barplot(y_customer, xlab="Regions", ylab="Freq")

# HISTOGRAM
# Documentation of Histogram (its parameters)
browseURL("https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/hist")

cust_age = table(Customer$Age)
hist(cust_age)
hist(cust_age, breaks=7) # two breakpoints between histogram
hist(cust_age, breaks=c(0, 10, 30))

install.packages("keras")