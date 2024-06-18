
[NOTE] This data was copied from a word file, where any images could not be copied here.





Data Visualisation Report

‘What makes NY Airbnb hosts successful’

Name: Rahul Bhattacharjee



 

Contents
Introduction	3
Design	3
Sheet 1 – Generate Ideas	3
Sheet 2 – Idea 1	4
Sheet 3 – Idea 2	5
Sheet 4 – Idea 3	6
Sheet 5 – Final Idea	7
Implementation	7
Technologies	8
R or D3	8
Final Implementation	8
User guide	8
Structure of the Shiny Web App	8
Available visualisation options	10
Conclusion	15
Bibliography	16
Appendix	16























Introduction
The message that I want to convey with my narrative visualisation is that of understanding what are reasons for the success of the Airbnb listings in New York. What factors contribute to their success. 
The intended audience for this narrative visualisation could be 
-	People intending to start Airbnb services at their properties in New York
-	The people of New York for general information, 
-	Travellers visiting New York to see the layout of the Airbnb businesses and options in the city, 
-	Aspiring data scientists who want to see an example of a data visualisation report using R shiny.
Design
Sheet 1 – Generate Ideas
In this sheet, the purpose was to come up with different ideas. Hence, these were the ideas that I came up with:
(Please refer Sheet 1 in the Appendix for a picture of the same.)
A. Ideas
1. Map – Creating a map of New York and visualising the distribution of the Airbnb listings on the map. One could also see the distribution of some of the important features of the dataset across the map.
2. Bar chart – Use stacked bar charts to show the distribution of the values of a variable, where each bar is highlighted by the proportions of another variable.
3. Pie chart – Pie charts used to show the comparison of counts of different values of the categorical values in a pie chart format, to be able to see the proportions of the values in contrast to each other and the total sample space.
4. Tree map – To show the comparison of the proportions of the values of categorical variables against each other and the total sample space.
5. Circular Packing – To see the proportion of the hosts’ listings counts in proportion to each other and the total sample space.
B. Filter Ideas
1. Avoid using the tree map as it is similar to the pie chart.
2. Avoid using Circular Packing to avoid technical complication in coding.
C. Categorise
The categories of visualisations that could be associated to the above ideas were as follows:
1. Geographic
2. Pie chart 
3. Bar chart
D. Combine and Refine
1. Map with different filters maybe even with zoom features
2. Bar chart/Box plot
3. Pie chart

Sheet 2 – Idea 1
Title: Interactive map
Task
Visualise spread of Airbnb listings on a map
Layout
Please refer Sheet 2 in the Appendix for a picture of the same.
1)	New York map 
2)	A drop down menu to:
a)	select an attribute and 
b)	select borough
3)	Legend showing the different classes of the selected attribute.
4)	Button – Click to see summary.
Operation
-	When the visualisation first loads, the map is the first thing the user will see.
-	User has to select the attribute from the drop down menu, to see listing distribution of that attribute on the map.
-	User can select the borough to zoom in or can select the “All” option to see all boroughs at once.
-	Press “click to see summary” button to go the “bar chart” section.
Focus
-	On choosing a different ‘attribute’, the data points on the map will represent any one of the classes of that attribute.
-	Similarly, the legend changes with the change in the attribute selection.
-	Tooltip showing more information about each datapoint like price, room_type, min_nights,etc. or for each borough on mouseover.
Pros
-	Shows geographical distribution of data instances.
-	Gives a good overall frame of reference or perspective.
Cons
-	Count based on density cannot be observed here i.e. count/size of area * total area.
-	Doesn’t show the numerical comparison of classes per borough.  

Sheet 3 – Idea 2
Title: Bar chart/box plot
Task
Compare different x-axis attributes on an already selected y-axis
Layout
Please refer Sheet 3 in the Appendix for a picture of the same.
1. Bar chart/box plot
2. Drop down menu to select x-axis values.
3. Y-axis legend
4. Button – “Click to see relative comparison”
5. Button – “Go back to change main attribute”
Operation
-	When the user selects the attribute on the map, the user can then press the “click to see summary” button to visit this page. Upon doing so, the y-axis will be the same attribute selected previously on the map page.
-	The user can then change the x-axis attribute between boroughs, room_type, price_range etc to see different distributions of the attribute on the y-axis.
-	Press the “Click to see relative comparison” to go to the next screen.
-	Press the “Go back to change main attribute” button to go to the first screen.
 
Focus
-	On choosing a different x-axis, the x-axis will change, the y-axis remaining the same. Only the latter attribute’s distribution changes over the values on the x-axis.
Pros
-	By changing the x-axis, the user will be able to see the relationships between the attribute on the y-axis and those selected for the x-axis. It shows different comparisons of the y-axis attribute over different X-axis values.
Cons
-	¬The user has to go back to the sheet 1 with the map, to change the y-axis attribute. 

Sheet 4 – Idea 3
Title: Pie chart
Task
Show a relative comparison or proportion on a pie chart
Layout
Please refer Sheet 4 in the Appendix for a picture of the same.
1.	See a pie chart with the values of the attribute selected on sheet 1 with the map.
2.	See a legend of the values of this main attribute.
3.	Button – “Go back to change main attribute”
Operation
-	When the user goes to the bar chart page, he/she can press the “click to see relative comparison” button to visit this page.
-	Press the “Go back to change main attribute” button to go to the first screen.
Focus
-	The purpose of the pie chart is to show the relationship of the classes in each attribute amongst each other.
-	The pie chart will show the percentage of the total for each class/value of the attribute shown in the pie chart.
-	A tooltip will show up on mouse over, showing additional information like the count value of the individual class and the total of all classes.
Pros
-	Shows the relationship between the different classes of each attribute.
Cons
-	Since there is no scale, it is difficult to visualise the magnitude of the attribute and its classes in general.
-	¬The user has to go back to the sheet 1 with the map, to change the y-axis attribute. 

Sheet 5 – Final Idea
Title: Final design/realisation
Task
See all previous visualisations together and their requirements. 
Layout
Please refer Sheet 5 in the Appendix for a picture of the same.
-	Page 1 – Map.
o	Step 1 - Select attribute to see its distribution on the map
o	Step 2 – Press the button “Click to see summary” to go to the next screen.
-	Page 2 – Bar chart/Box plot
o	Step 3 – Select attribute for the x-axis.
o	Step 4 – Press the button “Click to see relative comparison” to go the next screen.
-	Page 3 – Pie chart
o	Press the “Go back to change main attribute” button to go back to the Page 1.
Operation
Please refer the steps mentioned above.
Details
Programming language – HTML, CSS, JS or R
Library – D3 for JS or shiny in case of R.
Data – New York Airbnb data from the Kaggle website.
Software requirements:
-	Rstudio for R
-	Brackets IDE for HTML, CSS, JS.

Implementation
Technologies
For the implementation of the above designs, I have used the following technologies:
1)	Programming language – R 3.6.3
2)	IDE – R studio - Version 1.2.5042
3)	The libraries used are as follows:
a)	Shiny – To create an interactive web app
b)	Leaflet – to draw interactive maps
c)	ggplot2 – To create different types of graphs like bubble chart, bar chart, scatter plot etc.
d)	dplyr – For use of data manipulation functions like distinct function.
e)	htmltools – For html tag manipulation for leaflet.

Final Implementation
During the implementation of the final design mentioned above, I made some changes as well. The final implementation steps are detailed below:
1.	Added a cluster map to show the grouping of the listings in different parts of the New York map. This is to help the user discover the NY map and see the where listings are located and how they are clustered. Each data point also has a tooltip which appears on mouse over.
2.	Same as in the final design, used a drop down menu box, for the user to select a feature that they want to see a corresponding visualisation for.
3.	Same as in the final design, on selecting the feature of choice from the drop down menu, the user will be able to see a visualisation relating to that feature which represents the feature distribution amongst the listing, and also how that feature interacts with other features.
4.	Different to the final design, I have used different visualisations for the different data set features, that best represent the distribution of the feature among the listings in the dataset. 
5.	Added a summary section at the bottom of the webpage, this shows the summary visualisations of the important features that contribute to the success of the Airbnb hosts and their explanations.

User guide
I will divide the user guide into different sections, as per the different sections of the shiny app that was created. The sections are as given below:
Structure of the Shiny Web App
Title section 
This section is located at the top of the shiny app. Hence, this is the first thing the user will get to see.
1. There is a title text to the whole shiny app, describing the main purpose of the visualisation.
2. There is a cluster map to show the grouping of the listings in different parts of the New York map. This has been created for the user to discover the various places where the listings in the data set are present. This can help the user to get familiar with locations of the listings in the NY map. This can help the user to familiarise any of the locations they might already know in the NY city and on its map.
 
3. If the user clicks on each cluster, until there is no cluster left, the user will be able to see the individual data points in the form of blue coloured circles. At that zoom level, if the user performs a mouse over over the individual data points, he/she will be able to see a tooltip with the essential information of that listing data point. This can be seen below.
 
Sidebar Panel
Location of section
This section comes below the Title section described above. This is where the user can interact with the data and get a sense of the dataset, the features in the dataset. This section will either be on the right or left side of the main section but below the title section.
Feature selection
The first step to using the visualisations in the main panel, is to select a feature in the sidebar panel. This is where the user can select a feature of his/her choice and find what the data says about that feature. They will see different visualisations and graph for each feature in the main panel consequently, to better depict how the feature impacts the Airbnb business of Airbnb host. This choice has been implemented in the form of a drop down menu, where the user has to select the feature that they want to view from the drop down menu, to see their corresponding visualisations.
 
The options available in the drop down menu are as follows:
 
Main Panel
Location of section
This section is again located below the Title section but to either side of the Sidebar section in the shiny app. This is the main place for the user to see the visualisations in the Shiny App.
Visualisation
On selecting the feature in the side panel, the user will be shown the visualisation corresponding to the feature selected on this main panel section. This could be just one visualisation or multiple ones.

Available visualisation options
1. Feature select – “Price ranges”
If the user selects the “Price ranges” variable, the user will be shown the following visualisation.
 
 
It shows a dot density diagram of the of the different price ranges, shown in the legend and how they are distributed across the city.
2. Feature select – “Price”
If the user selects the final variable, i.e. “Price”, the user will be shown the following visualisation.
 
3. Feature select – “Minimum nights”
If the user selects the final variable, i.e. “Minimum nights”, the user will be shown the following visualisation.
 
4. Feature select – “Room type”
If the user selects the final variable, i.e. “Room type”, the user will be shown the following visualisation.
 
5. Feature select – “Reviews”
If the user selects the final variable, i.e. “Reviews”, the user will be shown the following visualisation.
 
6. Feature select – “Availability”
If the user selects the final variable, i.e. “Availability”, the user will be shown the following visualisation.
 
Summary section
This section is situated below the main panel and it shows the summaries from the analysis. It summarises the analysis by providing bubble chart for the total revenue of each listing.
 
Conclusion
Realisations
Project summary
As presented in the summary section of the shiny app, the most successful Airbnb listings have the following traits:
1. High minimum number of nights – This helps them get higher revenues for each booking while keeping the costs for maintenance low.
2. Medium range of prices  to attract  more people while earning higher revenues.
3. Higher number of reviews here means more bookings i.e. higher popularity or loyalty towards the property. Number of reviews have been used as the number of bookings since the number of bookings were not available.


Bibliography
1. Kaggle. (2019) New York City Airbnb Open Data [Data file]. Retrieved from: 
 https://www.kaggle.com/dgomonov/new-york-city-airbnb-open-data 

Appendix
1. Five design sheets (continued on the next sheet)
 

 
 
 

 





