# Paulina's Portfolio
<br>
Hi there!
<br>
<br>
Welcome to my portfolio page. <br>
My name is Paulina, and I've been working with data since May 2023. However, my journey with data began already during my university studies, where I developed skills in loading, transforming, and visualizing various kinds of data.

I am passionate about lifelong learning and continually strive to develop my skills. I enjoy exploring new technologies, solving complex problems, and applying innovative solutions to real-world challenges. In my free time, you can find me at the gym or walking in the park, as I believe that a healthy body is essential for a healthy and focused mind.
<br>
<br>
Below, you can find my portfolio projects showcasing my expertise in SQL and Python:
<br>
<br>
<br>

# Project 1: PYTHON - YOUTUBE API - <a href="https://github.com/paulaloure/Portfolio-Projects/tree/main/Python_API" target="_blank">see the project</a>

This project contains the following steps:

**PART 1:** Connecting to Youtube API and extracting videos information\
**PART 2:** Saving channel and video information to excel and loading to the SQL Database\
**PART 3:** Connecting PowerBI Desktop to the SQL database, loading and transforming data in PowerQuery\
**PART 4:** Creating PowerBI Dashboard



**Libraries used: GoogleAPIClient, Pandas, DateTime, Dotenv**


**Main Goal**

The goal of this project was to download the list of all videos from a youtube channel with their details, and create PowerBI dashboard based on the data. The dashboard would aim to answer below questions:
 - How many views/subscribes the channel has and how far it is from reaching next benchmark?
 - Videos posted on which weekdays have most views?
 - What would be the best video lenght to optimize number of comments and likes?
 - What are best perofrming videos in terms of views, likes and comments?
 - What is the viewers engagement? Does higher number of views translates to higher number of likes and comments?

<br>

**Steps**

![Dodaj nagłówek (4)](https://github.com/paulaloure/Portfolio-Projects/assets/96730074/a41cd59a-9ad3-47e6-982a-434b5662bc8e)

<br>

**Results** 

As a result, the below PowerBI dashboad was created. The .pbix file can also be found in the project folder.
![Screenshot 2024-07-06 115935](https://github.com/paulaloure/Portfolio-Projects/assets/96730074/f2199ce9-0e87-40dc-bbc7-cb0b7f3ddef9)




<br>
<br>
<br>

# Project 2: PYTHON - VOLCANOES - <a href="https://github.com/paulaloure/Portfolio-Projects/tree/main/Volcanoes" target="_blank">see the project</a>


Project 'Volcanoes' contains the following steps:\
**PART 1:** Data extracting from wikipedia\
**PART 2:** Data cleaning\
**PART 3:** Data analysis and visualization on graphs and maps

**Library used: NumPy, Pandas, Geopandas, MatPlotLib**

The goal of this project was to extract, merge and clean the data from wikipedia to be able to perform data analysis. The problems, or questions that I tried to solve based on the analysed data are as follows:\
	1. Which eruption was the biggest in terms of Volcanic Explosivity Index (VEI), Fatalities and Max Plume Height?\
	2. What are the numbers of explosions, fatalities caused by volcanic explosions and volcanic explosivity index (VEI) per continents and countries?\
	3. Does the amount of explosions change with time?\
	4. Does the Max Plume Heigt or Fatalities number correlate with the explosions strength (VEI)?\
	5. Where are located the highest volcanoes or volcanoes of certain type?

![image](https://user-images.githubusercontent.com/96730074/197048646-2da98575-6ab2-43c8-ab82-31f4734f13a6.png)


<br>
<br>
<br>

# Project 3: SQL - DVD RENTAL - <a href="https://github.com/paulaloure/Portfolio-Projects/tree/main/SQL%20-%20DVD%20rental" target="_blank">see the project</a>

The aim of this project was data manipulation and analysis in PostgreSQL. Dataset used comes from Udemy course 'Become an expert at SQL!' and contains many tables, from which the following were used in this project: address, payment, film, inventory, actor, category. 

**Skills used: groupby, joins, mathematical and string operations, temporary tables, creating views**

In the project the below question were answered:
1. Which film categories are rented most often?
2. Which films brought the highest income to the rental place?
3. Which customer has the highest mean spend in the rental place?
4. Which staff managed to earn more with rental per month in one year?

Visualisation of the mean spend for the customers with id 1-99:

![graph_visualiser-1666979333244](https://user-images.githubusercontent.com/96730074/198700508-9f997b3b-6783-41e8-bbdd-574923c68e77.png)



<br>
<br>
<br>

# Project 4: PYTHON - Airbnb New York data - <a href="https://github.com/paulaloure/Portfolio-Projects/tree/main/Pyton_AirBNB" target="_blank">see the project</a>

This project contains the following steps:\
**PART 1:** Importing data\
**PART 2:** Data exploration\
**PART 3:** Data preparation\
**PART 4:** Feature understanding\
**PART 5:** Feature relationship\
**PART 6:** Questions

**Library used: NumPy, Pandas, Seaborn, MatPlotLib**

The goal of this project was to import, review, transform and visualize data regarding Airbnb flats in New York. In this project I tried to answer the below questions:\
	1. What are the relationships between features? Are there any correlations?\
	2. Which are the locations with the cheapest/most expensive apartments?\
	3. Which hosts manage above 100 flats with the best ratings?\
	4. Which type of room is the cheapest?\
 	5. Are newest flats the most expensive?
<p align="center">
  <img src="https://user-images.githubusercontent.com/96730074/217895856-c393d145-030d-4a3c-a5ed-4e0a48340753.png" />
</p>



<br>
<br>
<br>

# Project 5: SQL - Shark Attacks  - <a href="https://github.com/paulaloure/Portfolio-Projects/tree/main/SQL%20-%20SharkAttacks" target="_blank">see the project</a>

The aim of this project was data cleaning and exploratory analysis in PostgreSQL. I have used the real data regarding shark attacks over the world, analysing among others the attacks caused by various shark species, injuries in various body parts and in many countries 

**Skills used: group by, partition by, CTE, subqueries, mathematical and string operations, regex**

Project consist of 3 parts:

**PART 1: Creating the table** \
**PART 2: Cleaning the data** \
**PART 3: Data analysis** 

In data analysis part I have answered the below questions:
1. Which of the states in US have the higher amount of shark attacks?
2. What is the percentage of attacks between men and women based on the available data?
3. Which of the US states has the higher rate of fatal attacts with regard to all attacks?
4. What is the percentage of fatal attacts between man and woman?
5. What percentage of all fatal attacks were provoked?
6. Is there a region where attacks by some shark species are most common than by the others?
7. Which shark species attack more often?
8. Which shark species are the most deadly?
9. Which body part is attacked by sharks the most often?
10. Is there any shark than attacked most time different body part than leg?
11. What are the activities with the highest ratio of fatal attacks? 
    
Based on the analysis we can see that the most attacted body part is leg
<p align="center">
  <img src="https://user-images.githubusercontent.com/96730074/227603632-ed91d306-b5d9-47e5-8278-cdd7210ddb57.png" /> 
  <img src="https://user-images.githubusercontent.com/96730074/227333305-40331ab5-f8aa-46f3-8b7d-afafd36d8070.png" />
</p>

... and, that men are attacked more often than women:
<p align="center">
  <img src="https://user-images.githubusercontent.com/96730074/227603682-66696317-af2c-40f5-ab0d-4ab890c490c8.png" />
</p>
<p align="center">
  <img src="https://user-images.githubusercontent.com/96730074/227604264-e406ef76-dce8-4772-a491-0cb21f7b4f33.png" /> 
</p>


