# R - data cleaning 


library(tidyr)
library(dplyr)
library(skimr)
library(Hmisc)
library(nycflights13)
library(ggplot2)


# Before we move on, lets clear the Global Envionment of objects that we will no longer use
rm(list=ls())

# dataFrame a list of vectors of equal length i.e. a table
# we installed this data with the nycflights13 library
View(flights)

##### dplyr
# dplyr using the NYC flights data
# For dplyr we are going to explore filtering, arrange, group, and mutate functions
# This data set has missing values in several thousand observations on several variables
summary(flights) 
glimpse(flights)

### Filter
# filter : filter allows to view a subset of rows the data frame
flightsJFK <- filter(flights, origin=="JFK")
# We can use is.na to pull just observations with NA values
flightsDepTimeNA <- filter(flights, is.na(dep_time))
# or exclude them (n.b. this is only excluding NA on a single column)
flightsCleanDepTime <- filter(flights, !is.na(dep_time))

### Select
# we can also subset of columns using select
flightsCarrierOriginDest <- select(flights, carrier, origin, dest)
summary(flightsCarrierOriginDest)
factor(flightsCarrierOriginDest$carrier) # how many categories
# factor shows us the 16 unique values for the $carrier
table(flightsCarrierOriginDest$carrier)  # categories and frequency
# table shows us the unique values and the frequency of use

### Arrange
# Arrange allows us to change the order of the data
flightsSortDepTime <- arrange(flights, dep_time)
flightsSortDepTime <- arrange(flights, desc(dep_time))

### Group and Summary
# lets create a data frame of that groups the data by month
flightsByMonth <- group_by(flights, year, month)
# now lets look at the number of flights and average departure delay
summarise(flightsByMonth, count = n(), delay = mean(dep_delay, na.rm=TRUE))

### Mutate
# mutate allows us to create a new column at the end of the data frame
# as a function of existing columns
flights <- mutate(flights, speed = distance / air_time * 60)
summary(flights)


# Hmisc - here we quickly remove rows with missing values
# Descriptive statistics before data cleaning
skim(flights)


# Data cleaning 
cleanFlights <- flights[complete.cases(flights),]  # only select complete data rows for the cleandata frame
cleanFlights <- unique(cleanFlights) # eliminate duplicate values (none in our example file)
View(cleanFlights)

# Descriptive statistics after data cleaning
skim(cleanFlights)


