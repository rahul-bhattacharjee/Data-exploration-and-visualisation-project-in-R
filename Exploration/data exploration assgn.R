library(ggplot2)
library(dplyr) # used for distinct function. This library runs when it is run twice. The first time it throws an error.
library(gtools) # used for quantcut function
library(corrplot) # for the visual correlation matrix graph.
# install.packages("GGally")
library(GGally) # also for another visual correlation matrix graph.

# stringsAsFactors = False is to keep strings as strings(or character datatype in R)
# na.strings is to convert blank strings into NA values, since otherwise they are not discovered by the is.na function and they appear as "" instead of NA, since NAs dont have any datatype but "" are strings.
data <- read.csv('AB_NYC_2019 - original.csv', stringsAsFactors = F, na.strings = c("", "NA"))
head(data)
summary(data)

# 1. Missing values and imputation.
# ==============================================================================
# How many null values we have for each column
colSums(is.na(data))
# Sum counts when the value is TRUE and doesn't count when the value is FALSE.
# https://www.datanovia.com/en/lessons/identify-and-remove-duplicate-data-in-r/
sum(duplicated.data.frame(data))
# https://stackoverflow.com/questions/22196078/count-unique-values-for-every-column
# difference between unique(counts unique rows/values in each/single columns) and distinct(counts unique rows with all columns). https://discuss.analyticsvidhya.com/t/how-to-count-number-of-distinct-values-in-a-column-of-a-data-table-in-r/1124/2
apply(data, 2, function(x) length(unique(x)))
# The below proves that the no. of unique/distinct rows in the dataset is equal to the total no. of rows in the dataset.
# https://dplyr.tidyverse.org/reference/distinct.html
nrow(distinct(data))
nrow(data)

# Convert date strings to date class/data type.
data$last_review <- as.Date(data$last_review,"%d-%m-%y")
data$last_review
is(data$last_review)

# Checking whether the NAs in the last_reiview column and the reviews_per_month have a correlation(when the number_of_reviews column has a 0 value
nrow(data[which(data$number_of_reviews==0),])
nrow(data[is.na(data$last_review),])
nrow(data[is.na(data$reviews_per_month),])
# As we can see from running the below code,the columns last_review and reviews_per_month are NA when the number_of_reviews column has the value 0. And 10052, the no. of NAs in both these columns is actually the total no. of NAs in these columns according to the colSums.... code above. So that means all cases of NA values in these two columns are due to the 0 value in the number_of_reviews column.
nrow(data[which(data$number_of_reviews==0 & is.na(data$last_review) & is.na(data$reviews_per_month)),])

# Change the reviews_per_month column to 0.00 where it is NA since if no. of reviews is 0, reviews_per_month has to be 0.
# https://stackoverflow.com/questions/8161836/how-do-i-replace-na-values-with-zeros-in-an-r-dataframe
data$reviews_per_month[is.na(data$reviews_per_month)] <- 0.00 
# To check whether the imputation worked.
head(data[which(data$number_of_reviews==0 & is.na(data$last_review)),])

# How to deal with NAs in a date column with date data type:
# https://stackoverflow.com/questions/39899997/how-to-replace-nas-in-a-date-column
# Since NAs in the date column cannot be replaced with NA values, hence they have been left as NA values.

# =========================================================================




# 2. Data analysis and exploration
#==========================================================================
# Finding correlation between all the columns in a dataframe:
# -------------------------------------------------------------------------
summary(data)
# http://www.sthda.com/english/wiki/correlation-matrix-a-quick-start-guide-to-analyze-format-and-visualize-a-correlation-matrix-using-r-software
# cor function only takes numeric variables
cordata <- data[, sapply(data, is.numeric)]
# Only take the rows without any missing values
# https://statisticsglobe.com/complete-cases-in-r-example/
cordata <- cordata[complete.cases(cordata), ]
cormatrix <- cor(cordata, method = "spearman")
corrplot(cormatrix,tl.srt=45)
# https://www.datacamp.com/community/blog/r-correlation-tutorial
# The ggcorr function disregards non-numeric variables automatically, which saves some time by exempting the user from "subsetting-out" such variables prior to creating the matrix.
ggcorr(cordata)
ggcorr(data,label=T,label_alpha = T)
# -------------------------------------------------------------------------




# NOW WE START CHECKING ALL THE COLUMNS OF THE DATAFRAME ONE BY ONE IN THE SEQUENCE PRESENT IN THE DATASET.
# 1. COLUMN NAME: id
# --------------------------------------------------------------------------
# Simple index number for the host. The missing values in this column were ignored. But at least some of the host ids perhaps can be filled by going to the listings of these hosts and finding the host ids. This hasn't been done because host ids do not contribute to the analysis in anyway.
# No analysis done here.  
# --------------------------------------------------------------------------

# 2. COLUMN NAME: name
# --------------------------------------------------------------------------
# Although some natural language could be peformed to determine the best names for listings which could attract customers, for e.g. words like 'loft', 'home away from home' seem catchy. But due to my limited knowledge in NLP, I did not perform the same.
# No analysis done here.  
# --------------------------------------------------------------------------

# 3. COLUMN NAME: host_id
# --------------------------------------------------------------------------
# Simple index number for the host. The missing values in this column were ignored. But at least some of the host ids perhaps can be filled by going to the listings of these hosts and finding the host ids. This hasn't been done because host ids do not contribute to the analysis in anyway.
# No analysis done here.  
# --------------------------------------------------------------------------

# 4. COLUMN NAME: host_name
# --------------------------------------------------------------------------
# This column doesn't contribute anything to the analysis, hence ignored.
# No analysis done here.  
# --------------------------------------------------------------------------

# 5. COLUMN NAME: neighbourhood_group
# --------------------------------------------------------------------------
# Let's see the neighbourhood groups.
unique(data$neighbourhood_group)
# number of neighbourhood groups.
length(unique(data$neighbourhood_group))
# Let's plot them and see their value counts.
ggplot(data,aes(x=neighbourhood_group)) + geom_histogram(stat="count", fill="red")
# Let's plot their percentage of counts. For some reason, we have to write the count in a weird fashion to get the graph.
ggplot(data,aes(x=neighbourhood_group, (..count..)*100/sum(..count..))) + geom_bar(fill="blue")
# Manhattan is the highest and Staten Island is the lowest percentage counts. Manhatten and Brooklyn are the most commercially developed boroughs and the commercial hubs of NY, hence this is understandable.

# Lower articles are more important
# https://felixfan.github.io/ggplot2-remove-grid-background-margin/
# https://ggplot2.tidyverse.org/reference/geom_density_2d.html
# https://hackernoon.com/how-to-interpret-a-contour-plot-a617d45f91ba
# The key takeaway from this analysis is,
# A small distance between the contours indicates a steep slope along that direction.
# A large distance between the contours indicates a gentle slope along that direction.
# In the below case, depth or height is the same thing, the graph is denser at that point.
# A contour plot shows here 3 dimensions, latitude, longitude and density/count as the contours.
# I did not use this graph in my report, instead I used a map of NY I plotted in my Tableau file with all records plotted on that map to show density.
ggplot(data, aes(longitude,latitude)) + geom_density2d(aes(color = neighbourhood_group),size=1) + ggtitle("Density of Airbnb listings by borough") + theme_bw()

# --------------------------------------------------------------------------

# 6. COLUMN NAME: neighbourhood
# --------------------------------------------------------------------------
# This column is over shadowed by the previous column of neighbourhood_groups, since it is a smaller group and the names are more familiar. Hence not much to do here.
# There were 221 neighbourhood in the dataset, the popular ones out of which are located in Manhattan.
# No analysis done here.  
# --------------------------------------------------------------------------

# 7. COLUMN NAME: latitude
# --------------------------------------------------------------------------
# See map made in tableau file
# --------------------------------------------------------------------------

# 8. COLUMN NAME: longitude
# --------------------------------------------------------------------------
# See map made in tableau file
# --------------------------------------------------------------------------

# 9. COLUMN NAME: room_type 
# --------------------------------------------------------------------------
# Let's plot a boxplot showing the price range for each room type.
ggplot(data, aes(x=room_type, y=price)) + geom_boxplot()
# Let's magnify the boxplot to show the price range where the dataset has the highest frequency.
# How to add xlabel, ylabel, title, subtitle
# https://ggplot2.tidyverse.org/reference/labs.html
ggplot(data, aes(x=room_type, y=price)) + geom_boxplot()+ coord_cartesian(
  xlim = NULL,
  ylim = c(0,250),
  expand = TRUE,
  default = FALSE,
  clip = "on"
) + labs(x="Room Type", y="Price")
# As is quite visible that as the price for the Entire home/apt is highest, followed by private room and shared room coming in last. This price difference is not just for the median prices of each room type but for the entire IQR range.

ggplot(data, aes(room_type)) + geom_bar(aes(fill = price_range)) + ggtitle("Count of Listings by Room Type")       

# --------------------------------------------------------------------------

# 10. COLUMN NAME: price
# --------------------------------------------------------------------------
# The 'price' column seems to be the most important column for the analysis of this dataset(success of an airbnb host depends directly on the price).

summary(data$price)
# Having a min. price of zero is suspicious and needs investigation.
#--------------------------------------
(data[which(data$price==0),])
# On checking the website, the price of a few of these listings can be found using the url https://www.airbnb.com.au/rooms/[id no.]
# All the info given in the dataframe match the listing including the host_name and name.
# Impute price as per website in the price column
data$price[data$price==0 & data$id==18750597] <- 250
data$price[data$price==0 & data$id==20333471] <- 86
data$price[data$price==0 & data$id==20523843] <- 47
data$price[data$price==0 & data$id==20608117] <- 86
data$price[data$price==0 & data$id==20624541] <- 155
data$price[data$price==0 & data$id==20639628] <- 100
data$price[data$price==0 & data$id==20639792] <- 55
data$price[data$price==0 & data$id==20639914] <- 55
# Check that row for updated price.
data[data$price==250 & data$id==18750597,]
data[data$price==86 & data$id==20333471,]
data[data$price==47 & data$id==20523843,]
data[data$price==86 & data$id==20608117,]
data[data$price==155 & data$id==20624541,]
data[data$price==100 & data$id==20639628,]
data[data$price==55 & data$id==20639792,]
data[data$price==55 & data$id==20639914,]
# 20933849 - 0
# 21291569 - no listing found 
# 21304320 - no listing found

# Now only three listings are left with 2 not having any current listings and the third doesn't have a proper image gallery, no reviews, although the host does have reviews from other listings(but as per this row, the host doesn't have any more listings). Yes, as per this records hosts webpage https://www.airbnb.com.au/users/show/[host_ID] , there are 2 listings.
# It would be best to remove these records 2 records don't exist anymore, nor does their host. And for the third, this listing seems to be a first time attempt at a listing, hence it does not have any price or reviews.
# https://stackoverflow.com/questions/12328056/how-do-i-delete-rows-in-a-data-frame/52199795
data <- data[-c(26260, 26842, 26867), ]
# Now there are no listings with price = 0 Usd per night.
#-------------------------------------

# Plotting the price attribute to perform analysis of its distribution.
#--------------------------------------
p <- ggplot(data,aes(x=price)) + geom_boxplot()
# shows weird boxplot - extremly flat IQR. Lets zoom the graph a little.
p <- ggplot(data,aes(x=price)) + geom_boxplot()+ coord_cartesian(
  xlim = c(0,1500),
  ylim = NULL,
  expand = TRUE,
  default = FALSE,
  clip = "on"
)
p
# Lets plot a histogram instead for a little more clarity.
p <- ggplot(data,aes(x=price)) + geom_histogram(binwidth = 50, fill="orange")
# Lets zoom the graph a little.
p <- ggplot(data,aes(x=price)) + geom_histogram(binwidth = 50, fill="orange") + coord_cartesian(
  xlim = c(0,1500),
  ylim = NULL,
  expand = TRUE,
  default = FALSE,
  clip = "on"
)
p
# As can be seen price distribution seems to be grouped around the lower end of the price range (0-10000 USD) at less than 500 USD i.e. positively skewed.
percent_below_500 <- nrow(data[data$price<=500,])/nrow(data)
percent_below_500
# Almost 98% of the entries are below the 500 USD range.


# Creating a new column 'price_range' by segregating 'price' column into labelled interval ranges, according to each 20th percentile.
# --------------------------------------------
# Checking the value of each 20th percentile.
# https://www.r-bloggers.com/quartiles-deciles-and-percentiles/
quantile(copy$price,prob = c(0,0.20, 0.40, 0.60, 0.80,1) )
# Checking if the same quantile values are shown as interval values in the quantcut function- Yes.
head(quantcut(copy$price,5),10)
# Creating categories in a new column
data$price_range <- quantcut(data$price,5,labels=c("very low(0-60)", "low(60-90)","medium(90-130)","high(130-200)","very high(200-10000)"))
# Check missing values - none.
sum(is.na(data$price_range))
# Check unique values/no. of unique values for the column
length(unique(data$price_range))
head(data$price_range)
tail(data$price_range)
# price_range wise density under 500 USD per night. Leave if you don't understand density.
# The y-axis of a density plot is percentage of 100, where 100 is the total count.
# I didn't use this in my report since a density plot is a little hard to explain
ggplot(subset(data, price < 500), aes(price)) + geom_density(aes(fill = price_range), alpha=0.35) + ggtitle("Listing Population Density by Price")

# This graph is okay, not much can determined out of it. See the next price_range wise stacked bar chart for each neighbourhood_group plot for a better visualisation.
ggplot(data, aes(longitude,latitude)) + geom_density2d(aes(color = price_range)) + ggtitle("Density of Listings by Price") + facet_wrap(vars(price_range))
# The below graph is a better representation of the breakup of neighbourhood wise price ranges.
ggplot(data, aes(x=neighbourhood_group)) + geom_bar(aes(fill = price_range)) + ggtitle("Count of Airbnb listings by borough")
# The below is bound to happen since the price column has been divided on the basis of percentile not percentage.
ggplot(data, aes(x=price_range)) + geom_bar()  + ggtitle("Count of Airbnb listings by price_range")
# --------------------------------------------------------------------------

# 11. COLUMN NAME: minimum_nights
# --------------------------------------------------------------------------
summary(data)

ggplot(data, aes(minimum_nights)) + geom_histogram(binwidth = 1)+ coord_cartesian(
  xlim = c(0,100),
  ylim = NULL,
  expand = TRUE,
  default = FALSE,
  clip = "on"
)

nrow(data[which(data$minimum_nights>5),])
sort(unique(data$minimum_nights))

ggplot(data, aes(minimum_nights,price)) + geom_point()
ggplot(data, aes(room_type,minimum_nights)) + geom_point()

ggplot(data, aes(room_type,minimum_nights)) + geom_boxplot()
ggplot(data, aes(room_type,minimum_nights)) + geom_boxplot()+ coord_cartesian(
  xlim = NULL,
  ylim = c(0,5),
  expand = TRUE,
  default = FALSE,
  clip = "on"
)
# --------------------------------------------------------------------------

# 12. COLUMN NAME: number_of_reviews
# --------------------------------------------------------------------------
summary(data$number_of_reviews)

ggplot(data, aes(number_of_reviews)) + geom_boxplot()

# reviews per month plotted against price_range after zooming in graph to ignore outliers.
ggplot(data, aes(price_range, number_of_reviews)) + geom_boxplot(aes(fill=price_range)) + 
  coord_cartesian(
    xlim = NULL,
    ylim = c(0,50),
    expand = TRUE,
    default = FALSE,
    clip = "on"
  )

# reviews per month plotted against room_type after zooming in graph to ignore outliers.
ggplot(data, aes(room_type, number_of_reviews)) + geom_boxplot(aes(fill=room_type)) + 
  coord_cartesian(
    xlim = NULL,
    ylim = c(0,50),
    expand = TRUE,
    default = FALSE,
    clip = "on"
  )


ggplot(data, aes(number_of_reviews)) + geom_density() + ggtitle("Listing Population Density by Number of Reviews")

# --------------------------------------------------------------------------

# 13. COLUMN NAME: last_review
# --------------------------------------------------------------------------
summary(data$last_review)
ggplot(data,aes(last_review)) + geom_boxplot()
# The below code is throwing up an error(not a date type)
# + 
#   coord_cartesian(
#     xlim = c(2010-01-01,2017-12-31),
#     ylim = NULL,
#     expand = TRUE,
#     default = FALSE,
#     clip = "on"
#   )
# --------------------------------------------------------------------------

# 14. COLUMN NAME: reviews_per_month
# --------------------------------------------------------------------------
# Check reviews_per_month. This column is heavily reliant on the number_of_reviews column. So you can ignore the below analysis.
summary(data)

ggplot(data, aes(reviews_per_month)) + geom_boxplot()

# reviews per month plotted against price_range after zooming in graph to ignore outliers.
ggplot(data, aes(price_range, reviews_per_month)) + geom_boxplot(aes(fill=price_range)) + 
  coord_cartesian(
    xlim = NULL,
    ylim = c(0,3),
    expand = TRUE,
    default = FALSE,
    clip = "on"
  )

# reviews per month plotted against room_type after zooming in graph to ignore outliers.
ggplot(data, aes(room_type, reviews_per_month)) + geom_boxplot(aes(fill=room_type)) + 
  coord_cartesian(
    xlim = NULL,
    ylim = c(0,3),
    expand = TRUE,
    default = FALSE,
    clip = "on"
  )

# --------------------------------------------------------------------------

# 15. COLUMN NAME: calculated_host_listings_count
# --------------------------------------------------------------------------
summary(data$calculated_host_listings_count)

nrow(data[which(data$calculated_host_listings_count==327),])

# --------------------------------------------------------------------------

# 16. COLUMN NAME: availability_365 
# --------------------------------------------------------------------------
summary(data$availability_365)

nrow(data[which(data$availability_365==0),])
# --------------------------------------------------------------------------


# 17. COLUMN NAME(CREATED BY ME): price_range
# --------------------------------------------------------------------------
# Check price column analysis above
# --------------------------------------------------------------------------

# 17. COLUMN NAME(CREATED BY ME): total_revenue
# --------------------------------------------------------------------------
# I didn't take availability_365 because each review will only pertain to only stay period which will hold multiple days of stay but represented by only one review. So the best estimate of no. of days of stays is minimum_nights, since the guest must have had to stay for that long to give one review.
data$total_revenue <- data$price * data$minimum_nights* data$number_of_reviews
summary(data$total_revenue)
 
data[which(data$total_revenue==11166804),]

# Sonder has the highest number of listings in Airbnb at 327 listings.
data[which(data$host_name=="Sonder (NYC)"),]

# How to find the highest total revenue summed by host id/name i.e. highest earning host.
# https://stackoverflow.com/questions/1660124/how-to-sum-a-variable-by-group
a <- data.frame(aggregate(data$total_revenue, by=list(Category=data$host_name), FUN=sum))
summary(a)
colnames(a)
a[which(a$x==14085900),]
# This host has the highest total revenue by my imperfect formulae.
data[which(data$host_name=="Joni"),]


# ggplot(data, aes(room_type, reviews_per_month)) + geom_boxplot(aes(fill=room_type)) + 
#   coord_cartesian(
#     xlim = NULL,
#     ylim = c(0,3),
#     expand = TRUE,
#     default = FALSE,
#     clip = "on"
#   )


# --------------------------------------------------------------------------
