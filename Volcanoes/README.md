# Project 1: PYTHON - VOLCANOES

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

Based on the extracted data and analysis, the answer for the questions are as follows:


**1. Which eruption was the biggest in terms of Volcanic Explosivity Index (VEI), Fatalities and Max Plume Height?**
	
Volcanic Explosivity Index is a measure of magnitude and intensity of volcanic eruption in 0-8 logaritmmic scale. Based on the data the biggest eruptions since 1500 were: 

![image](https://user-images.githubusercontent.com/96730074/197043397-9eb4cf02-b45a-498b-9faf-14f55823e159.png)


The eruptions that caused most Fatalities were:\
![image](https://user-images.githubusercontent.com/96730074/197050964-d4fd0dec-b466-4e3f-8272-894eac058e94.png)



The eruptions with biggest registered Plume height were:\
![image](https://user-images.githubusercontent.com/96730074/197044007-7028115f-2a0c-4928-b8c7-0f9beb0d8e3f.png)

**2. What are the numbers of eruptions, fatalities caused by volcanic explosions and volcanic explosivity index (VEI) per continents and countries?**

Statistics per continents:\
![image](https://user-images.githubusercontent.com/96730074/197044243-c2aca8e3-d12a-48a9-a9a1-5fbbe40042b0.png)


Statistics per countries:\
![image](https://user-images.githubusercontent.com/96730074/197044404-d2748a3d-a17f-4ef2-8724-66cc0e09209d.png)

**3. Does the amount of eruptions change with time?**\
![image](https://user-images.githubusercontent.com/96730074/197045717-1725feea-497f-40a8-a144-f81efa8ccf9f.png)

Histogram above shows larger number of volcanic eruptions in the last 30 years. This doesn't mean that the eruptions are more frequent. 
The larger amount of eruptions is first of all due to increased tracking and recording of every single eruption, which was not properly tracked in the past. Secondly it is because of globalisation and posibility to track even smallest events in every part of the world, including the most remote areas.

**4. Does the Max Plume Heigt or Fatalities number correlate with the explosions strength (VEI)?**


![image](https://user-images.githubusercontent.com/96730074/197048530-8ddf736c-25e8-47d1-a3b8-751bdc5c62bb.png)


The graph doesn't show the correlation between Volcanic Explosivity Index and Fatalities. Significant number of fatalities was recorded for eruptions of VEI equals to 3-6. The number of fatalities doesn't depend on how strong is the eruption, but rather on it's proximity to big cities and highly populated areas.\

![image](https://user-images.githubusercontent.com/96730074/197048593-ecf2d89c-4e97-4316-91ec-9833316bdc55.png)

There is also no clear correlation between VEI and Max Plume height. The Plume heigh depends not only on the strength of eruption, but also on it's type. The plume height is the biggest during the most explosive eruptions (in contrary to the effusive eruptions) and the column of volcanic materials can reach over 40 km.


**5. Where are located the highest volcanoes or volcanoes of certain type?**

![image](https://user-images.githubusercontent.com/96730074/197048646-2da98575-6ab2-43c8-ab82-31f4734f13a6.png)

![image](https://user-images.githubusercontent.com/96730074/197048672-83d3c54d-427d-429a-b016-ad69fd59b158.png)


