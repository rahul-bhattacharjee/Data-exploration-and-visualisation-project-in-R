
[NOTE] This data was copied from a word file, where any images could not be copied here.







Data Exploration Report

Name: Rahul Bhattacharjee

 




Table of Contents
I. Introduction	4
Problem description	4
Question	4
Motivation	4
II. Data Wrangling	4
A. Data Sources	4
1. Data Description	4
2. Data Links	4
B. Data Wrangling steps	4
1. Data Cleaning	4
2. Data transformation	5
3. Tools utilised	5
III. Data Checking	5
1. Data checking approaches used	5
2. Errors found	5
3. Correction methods	6
4. Tools used for checking and correction	7
IV. Data Exploration	7
1. Description of the data exploration process.	7
2. Statistical tests used.	7
3. Visualisations and Discoveries	8
i.	id – Listing ID	8
ii.	name - Listing Title	8
iii.	host_id - ID of Host	8
iv.	host_name - Name of Host	8
v.	neighbourhood_group - Name of borough the listing is located in	8
vi.	neighbourhood - Name of neighbourhood the listing is located in	9
vii.	latitude - latitude of listing	9
viii.	longitude - longitude of listing	9
ix.	room_type - Type of space on offer	9
x.	price - price per night in USD	11
xi.	minimum_nights - minimum number of nights required to book the listing	12
xii.	number_of_reviews - total reviews accumulated by that listing	12
xiii.	last_review - date on which the listing was last rented and reviewed	12
xiv.	reviews_per_month - total number of reviews divided by the number of months the listing has been active	12
xv.	calculated_host_listings_count- number of listings per host	12
xvi.	availability_365 - number of days in a year the listing is active	12
xvii.	price_range (user created) – 5 price ranges for the price column	12
xviii.	total_revenue (user created) – product of (price * minimum_nights* number_of_reviews)	13
4. Tools used	13
V. Conclusion	13
1. Summary of learnings from the dataset	13
2. How the data exploration process answered the original questions	13
VI. Reflection	14
1. Brief description of learnings from this project.	14
2. What could have been done differently in hindsight?	14
VII. Bibliography	14
VIII. Appendix	15















I. Introduction
Problem description
How to find out the factors that lead to the success of the Airbnb hosts in New York city in the USA from the dataset used.

Question
1. What are the factors that make a New York city Airbnb host successful in terms of number of reviews?
Some of the factors could be busy neighbourhoods, proximity to famous landmarks, number of host listings, price, availability during the year, etc.
2. How do the neighbourhoods affect the price?
3. How is the density of these units scattered around NY?

Motivation
Since there are a lot of Airbnb hosts in NY, we try to find out the reasons or attributes that make them successful. This could point out towards some factors for success in the Airbnb business that could be replicated to other countries and locations as well.

II. Data Wrangling
A. Data Sources
1. Data Description
The data consists of information regarding the Airbnb listings within New York City. The dataset has 48895 rows and 16 columns. Please see the 16 attributes with their respective descriptions in the table of contents. Click on the link to see the analysis done for that column.
2. Data Links
New York city Airbnb data:
 https://www.kaggle.com/dgomonov/new-york-city-airbnb-open-data

B. Data Wrangling steps
1. Data Cleaning
Read the data into R, with stringsAsFactors = F parameter to convert the Factor variables to character and na.strings = c("", "NA") to convert blank strings to NA values.
Read the data into Tableau after changing NA values for the reviews_per_month column to 0.00 and changing the last_review column from character class to the date class using the as.date function.
I did not perform any data cleaning apart from the above steps, because all the data was in the same dataset. Hence, I did not have to merge any datasets. Apart from that please refer the data checking section, as there might be some overlap between these two sections. Further data cleaning had to be performed for the dataset.

2. Data transformation
No data transformations were performed. The price column in the data had a lot of extreme outliers as you will see in the price column analysis later on. This could be fixed by performing a log transformation. But since most of the values were grouped in a certain range, I instead thought of focusing on that group instead of the outliers, without subsetting the data, and instead of changing the data. See the price column description for a better idea of this procedure. Another tactic that has been used is of adding a categorical variable, providing very low to very high categories for 5 different intervals in the price range, which were divided on the basis of intervals of each subsequent 20th percentile. 
3. Tools utilised
R language 3.6.3 with RStudio 1.2.5042 

III. Data Checking
1. Data checking approaches used
i.	Checked for duplicates in a row wise manner (whether a complete row is in duplicate). Checked for unique values for each row which turned out the be the total number of records in the dataset confirming that there were no duplicate rows in the dataset. So, no row duplicates were found
ii.	Checked whether there were duplicates in each column and found none. Just to be sure, checked separately for the ‘id’ column as that column serves as the index number for all the records in the data. But no duplicates were found in that column as well, which wasn’t a surprise.
iii.	Checked the total count of NA values for each column. NA values were found.
iv.	Checked the summary function for each column to find some suspicious values.

2. Errors found
iii. NA values were found in four columns in the dataset namely – name, host_name, last_reviews, reviews_per_month.
iv. Checked the summary function for each column to find some suspicious values:
a.	Min price – 0.0
b.	Max price – 10000 USD where the 3rd quartile is only 175 USD per night.
c.	Min number_of_reviews – 0.0
d.	Min availability_365 – 0.0 days
e.	Max calculated_host_listings_count – 327
f.	Max minimum_nights – 1250 where the 3rd quartile is only 5 nights

3. Correction methods
iii. NA values were found in four columns in the dataset namely – name, host_name, last_reviews, reviews_per_month. On closer inspection, NA values in the last reviews and reviews per month columns were due to 0 values in the number_of_reviews column. So, in that case, it seems understandable that last reviews and reviews per month column would have NA values. But I have decided to impute the value 0.0 for NA values in the reviews per month column, for better mathematical application possibilities and accuracy.
iv. a.  Min price – 0.0
There were 11 such listings with price of 0.0. On checking the website, the price of a 8 of these listings can be found using the URL https://www.airbnb.com.au/rooms/[id no.] . All the info given in the dataframe match the listing including the host_name and name. And hence, I went ahead to impute the prices from their respective webpages. Now only 3 listings are left with 2 not having any current listings or host page which can be found from the hosts webpage https://www.airbnb.com.au/users/show/[host_ID]. The third and last listing does not have a proper image gallery for this listing, no reviews, although the host does have reviews from other listings. It would be best to remove these records 2 records that don't exist anymore, nor does their host. And for the third, this listing seems to be a first time attempt at a listing, hence it does not have any price or reviews, so removing it would be best. 
So out of the total 11 listings 8 were imputed from their prices from the website and 3 were removed as they were either non-existent anymore or did not have any values to help the analysis.
iv. b. Max price – 10000 USD where the 3rd quartile is only 175 USD per night.
Since, there are quite a few values above the third quartile and New York being a very expensive city, such a high price seems possible.
iv. c. Min number_of_reviews – 0.0
This is quite possible that a new host might not have any reviews yet.
iv. c. Min availability_365 – 0.0 days
On further checking, 17533 rows where availability_365 values were 0.0 days. No definitive reason can be thought of for this to happen. Maybe, the listings are new, but still they have to be available to be able rent out the space. This seems like an anomaly in the dataset. But not much can be done about it because these values consist of almost 20% of the rows in the dataset. There is no direct correlation between this column and any other to be able to find a possible reason. And it is impossible to check each row individually.  So, these values were left as it is.
iv. c. Max calculated_host_listings_count – 327
As it happens there is one host called Sonder which does hold 327 listings confirmed by the no. of rows where it has it’s name in the host_name column. So, it turns out this is a true value.
iv. d. Max minimum_nights – 1250 where the 3rd quartile is only 5 nights
On taking a closer look it seems that the IQR is from Q1-1 night to Q3-5 nights, but still there are a lot of different unique values above 5 nights, going all the way to 1250 nights. So, this seems like a valid figure.

4. Tools used for checking and correction
R language 3.6.3 with RStudio 1.2.5042.

IV. Data Exploration
1. Description of the data exploration process.
a.	We first check for any correlation between the columns. 
b.	We try to analyse each column at a time. 
c.	We check each column’s distribution details in the summary function of R. 
d.	We look for trends in each column, whether there is any correlation with any other column or if that column could help explain the figures in another column. So, one column could be used to help explain another column. Since the ‘price’ column seems to be the most important factor to judge the success of an Airbnb host, so it has been used in relation to other columns. 

2. Statistical tests used. 
i.	Summary function in R was used to get a basic distribution of all the column variables some of which have been mentioned above in the data checking portion. Some more usage of those statistics will be done in the column wise analysis.
ii.	Apart from that the correlation between each variable column in the dataset was performed. Please see the figure given below. As per the figure below, unfortunately, there is very little correlation between any of the column variables except ‘id’ and ‘number_of_review’ which seems coincidental.
 
3. Visualisations and Discoveries
Please see the column wise discussion of the dataset using various visualisations and the discoveries made from them.
i.	id – Listing ID
Simple index number for the Airbnb listing/space on rent.
ii.	name - Listing Title
Although some natural language processing could be performed to determine the best names for listings which could attract customers, for e.g. words like ‘loft’, ‘home away from home’ seem catchy. But due to my limited knowledge in NLP, I did not perform the same.
iii.	host_id - ID of Host
Simple index number for the host. The missing values in this column were ignored. But at least some of the host ids perhaps can be filled by going to the listings of these hosts and finding the host ids. This hasn’t been done because host ids do not contribute to the analysis in anyway.
iv.	host_name - Name of Host
This column doesn’t contribute anything to the analysis.
v.	neighbourhood_group - Name of borough the listing is located in
See the plot on the next page.
 
As we can see from the above plot made using Tableau, that the most listings are in the borough of Manhattan which is the densest and Staten Island is the least dense. For more details lets see the next plot using Tableau.
 
As we can see from the above plot, Manhattan has the most listings with 44.30% of the total listings, followed closely by Brooklyn at 41.12%, whereas Bronx (2.23%) and Staten island (0.76%) have the least. This makes a lot of sense, since Manhattan and Brooklyn hold the most commercial properties in NY. Manhattan is the most popular borough in NY since it has the most famous landmarks in NY like Empire State Building, Wall street, Madison Avenue for fashion, Metropolitan Museum of Art, the Central Park etc. Brooklyn being close to Manhattan and also having a lot of commercial spots is also a busy neighbourhood.
vi.	neighbourhood - Name of neighbourhood the listing is located in
There were 221 neighbourhood in the dataset, the popular ones out of which are located in Manhattan.
vii.	latitude - latitude of listing
Used for the Map in the neighbourhood_groups section.
viii.	longitude - longitude of listing 
Used for the Map in the neighbourhood_groups section.
ix.	room_type - Type of space on offer
There are 3 types of room or space on offer:
-	Entire home/apt 
-	Private room
-	Shared room 
On plotting the price variable on the y-axis and room types as the x-axis using ggplot in R, due to a lot of extreme outliers, the plot doesn’t come out very informative. Hence, the below plot is a plot using the coord_cartesian function in ggplot which zooms the plot without changing the data itself. As can be seen from the below boxplot, Entire home type commands the highest prices, even the 1st quartile is higher than the 3rd quartile for the other types. Coming in second is the Private which has a higher interquartile range than that of the Shared room. 
 
 

For the above plot, a new categorical column for the range of prices in the dataset was created based on the each successive 20th percentile called the price_range. When we plot the room types against the price range, we can see that:
Entire home/apt – Overall, this room type has the highest counts out of the three. There are close to 8000 counts of listings with the ‘very high’ price range ranging from 200 to 10000 USD. In fact, most of this price range from the entire dataset is covered in this room type. It is the same for the ‘high’ price range which has about 10000 counts. The ‘medium’ range is shared between this room type and Private room ranging from 90 to 130 USD.
Private room – This room type is a close second to Entire house/apt, in terms of total count. But conversely to the previous room type, it has a major segment from the ‘very low’ price type ranging from 0 to 60 USD and the ‘low’ range from 60-90 USD.
Shared room - This room type has the least number of counts ranging from ‘very low’ to ‘low’ price ranges and none of the other price ranges.
What can be inferred from the above plot is that most customers prefer to rent the entire home/apt, especially in case of families, where there is wide variety but mostly on the higher side of Airbnb listings which is understandable due to the area of the space leased. It is followed closely by a private room, preferable and cost effective for individuals, and they have a wide variety of prices on offer, mostly on the affordable side. Most customers do not prefer sharing their rooms despite their cheap costs.
x.	price - price per night in USD
Another categorical variable was added mentioning the price ranges by separating the price column values by intervals of the 20th percentile. You can see the intervals in the following graph.
Due to the reason that price has a very highly positively skewed distribution and that because it has many extreme outliers well over the IQR range, it is hard to plot without ignoring the outliers. But since the outliers are also legitimate data values, I though it better to present the price variable with this visualisation to see how the price differs from borough to borough in NY.
 
As we can see from the above graph that Manhattan has the highest price ranges to boast off, while also having the highest count of listings due to its popularity. It has the highest counts of the price ranges ‘very high’, ‘high’, maybe even the ‘medium’ range. In addition, it also has a selection of ‘low’ and ‘very low’ listings. Just like Manhattan, Brooklyn also has a wide variety of offerings, but more offerings on affordable side of the spectrum, where in this case, the ‘medium’, ‘low’ and the ‘very low’ ranges have higher counts. 
Queens comes in a far third with a much fewer number of listings but the price ranges on a much more affordable side than the previous two. Bronx and Staten island listings are fewer and on the cheaper end of the spectrum.
But on the whole Manhattan and Brooklyn take the cake of the Airbnb listings in NY with numerous listings and listings with a very wide variety of prices. If anyone is looking for an Airbnb accommodation in New York, they should look for a place in these two boroughs, no matter their budget.
xi.	minimum_nights - minimum number of nights required to book the listing
By using the summary function, we can see that the minimum value is 1 night and the maximum value is 1250 nights. But on checking the ‘minimum_nights’ spread across each ‘room_type’ (See Appendix 1 for graph), we see that that the IQR range for ‘Entire home/apt’ is a little higher than that of ‘Private room’, whereas that for the ‘Shared room’ is the lowest.  This is expected because hosts might want people to stay on their properties for longer to gain higher revenues and less costs like cleaning. 
xii.	number_of_reviews - total reviews accumulated by that listing 
The number of reviews range from Q1 value of 1 review to Q3 value of 24 reviews in the interquartile range, where the min was 0 reviews and max was 629 reviews. Plotting this value against room_type or price range brings up similar values without much difference.
xiii.	last_review - date on which the listing was last rented and reviewed
The majority of the values are between 2018 to 2019.
xiv.	reviews_per_month - total number of reviews divided by the number of months the listing has been active
This column relies on the number_of_reviews column. The higher the reviews in that column, the higher the reviews will be in this column. 
xv.	calculated_host_listings_count- number of listings per host
Min of 1 and max of 327 held by a host called Sonder. Sonder is an organisation which provide high quality rentals with great services available in many cities across the US.
xvi.	availability_365 - number of days in a year the listing is active
Since, 17533 rows where availability_365 values were 0.0 days, were found in this column, not much analysis can be done in this column. Min is 0 days, median is 45 days and max is 365 days.
xvii.	price_range (user created) – 5 price ranges for the price column
This column was created to help with the analysis of the price column. See price column for more details.
xviii.	total_revenue (user created) – product of (price * minimum_nights* number_of_reviews)
This column was created to check the total revenue from this Airbnb business. This is not an accurate representation of the total revenue because the number of reviews column includes reviews gathered across the lifetime of the listing which dates back to before this dataset. But this is used to get a general idea of the earnings per listing. Min is 0(owing to no reviews), Q1 is 175 only, median is 1680 USD, Q3 is 8000 and max is 11166804 USD. The max listing is an outlier because the price is 346USD per night with min nights of 198 days and 163 reviews (accumulated over its lifetime). It certainly is a popular listing.

4. Tools used
R language 3.6.3 with RStudio 1.2.5042 and Tableau Professional Desktop Edition 20.1.2 64 bit. Although, R has been used for most of the analysis, Tableau has also been used in some instances for better, quicker and easier visualisation. It has been only used for the 2 graphs in the data exploration column section ‘neighbourhood_group’.

V. Conclusion
1. Summary of learnings from the dataset
	Manhattan has the most listings followed closely by Brooklyn, whereas Bronx and Staten Island have the least. This makes a lot of sense, since Manhattan and Brooklyn hold the most commercial properties in NY. And Manhattan is the most popular borough in NY since it has the most famous landmarks in NY.
	But on the same note as above, Manhattan and Brooklyn take the cake of the Airbnb listings in NY with numerous listings and listings with a very wide variety of prices. 
	Entire home room_type commands the highest prices, second is the Private room followed by the Shared room.
	Most customers prefer to rent the entire home/apt, especially in case of families, where there is wide variety but mostly on the higher price_ranges due to the area of the space leased. It is followed closely by a private room, preferable and cost effective for individuals, and they have a wide variety of prices on offer, mostly on the affordable side. Most customers do not prefer sharing their rooms despite their cheap costs.
	But on checking the ‘minimum_nights’ spread across each ‘room_type’, we see that that the IQR range for ‘Entire home/apt’ is a little higher than that of ‘Private room’, whereas that for the ‘Shared room’ is the lowest.  This is expected because hosts might want people to stay on their properties for longer to gain higher revenues and less costs like cleaning. 
	Sonder is an organisation which provide high quality rentals with great services available in many cities across the US. As an Airbnb host, it holds 327 listings in NY (highest number of listings). But still my total revenue formula, it gets beaten by another host “Joni”, due to Sonder having very low number of reviews.

2. How the data exploration process answered the original questions
1. What are the factors that make a New York city Airbnb host successful in terms of number of reviews?
Some of the factors could be busy neighbourhoods, proximity to famous landmarks, number of host listings, price, availability during the year, etc.
Ans. This question could not be definitively answered but a general sense can be gained: 
	Since Manhattan has the most popular landmarks and the commercial hub of New York, it also has the highest number of listings including the most expensive ones. So yes, neighbourhood, proximity to famous landmarks does play a role.
	Since, the number of reviews gathered across the lifetime of the listing, is not matched by the timeline of the dataset (mostly 2018 to 2019), its hard to find the total revenue from a listing during a certain period.
	In general, factors that directly affect the total revenue of a host are – price per night, availability during the year, high ratings and reviews, good services, good neighbourhood, etc.
2. How do the neighbourhoods affect the price?
Ans. Manhattan followed by Brooklyn have the highest density of Airbnb rentals, some of them being the costliest.
3. How is the density of these units scattered around NY?
Ans. 85% of them are located in Manhattan and Brooklyn alone.
VI. Reflection
1. Brief description of learnings from this project.
Understood the different stages of data exploration and what they entail from the data wrangling, checking and exploration. Also learned how to approach each stage and learned to move step by step instead of jumping forward, which causes problems later.
2. What could have been done differently in hindsight?
Instead of just focusing only on the important variables like price, neighbourhood groups, room_type, etc, it would have been better to do the work in a more systematic manner by starting my analysis from the first column, followed by the second and so on till the last column. I feel because I did not do this at the start, it created unnecessary stress on me, because I kept thinking till the last stages that I haven’t done enough. So in hindsight, I should have started my analysis one by one from the first column in the dataset till the last column.
VII. Bibliography
Kaggle. (2019) New York City Airbnb Open Data [Data file]. Retrieved from: 
 https://www.kaggle.com/dgomonov/new-york-city-airbnb-open-data

VIII. Appendix
1.  
Note that since there are a lot of outliers in the ‘minimum_nights’ column, hence the above graph has been zoomed to be able to see the IQR ranges of all three room types using coord_cartesian function in R, which does not cut any values.
