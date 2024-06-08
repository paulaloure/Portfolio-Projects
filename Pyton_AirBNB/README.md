# Project 3: PYTHON - Airbnb New York data

This project contains the following steps:\
**PART 1:** Importing data\
**PART 2:** Data exploration\
**PART 3:** Data preparation\
**PART 4:** Feature understanding\
**PART 5:** Feature relationship\
**PART 6:** Questions

**Libraries used: NumPy, Pandas, Seaborn, MatPlotLib**

The goal of this project was to import, review, transform and visualize data regarding Airbnb flats in New York. In this project I tried to answer the below questions:
	1. What are the relationships between features? Are there any correlations?\
	2. Which are the locations with the cheapest/most expensive apartments?\
	3. Which hosts manage above 100 flats with the best ratings?\
	4. Which type of room is the cheapest?\
 	5. Are newest flats the most expensive?

Based on the extracted data and analysis, the answer for the questions are as follows:


**1. What are the relationships between features? Are there any correlations?**
	
As shown on the below graph, there is no correlation between the flat price and the number of reviews:\
![1](https://user-images.githubusercontent.com/96730074/217627440-60caa19d-cb5b-4265-a8ed-3151a466edc0.png)

We see also that the price can range from less than 100 USD to above 1000 USD:\
![2](https://user-images.githubusercontent.com/96730074/217627705-7000b33e-dee1-4e90-afdd-76720765b052.png)

The preferred quantity of nights spend is below 3 days or over 30 days:\
![3](https://user-images.githubusercontent.com/96730074/217628332-552a66d6-ea6b-4213-bc88-3aa30db773e3.png)

And the most frequent quantities of nights have also the highest amount of reviews:\
![4](https://user-images.githubusercontent.com/96730074/217628639-6c6d371c-3964-4692-9f25-8bb0291f649e.png)

Number of reviews doesn't depend on the price and the flat rating:\
![5](https://user-images.githubusercontent.com/96730074/217628881-7fae5c61-980f-4f3b-9db4-bb48165f8dc0.png)

The types of accomodation that are most common on airbnb in New York are entire flats/houses and private rooms:
![7](https://user-images.githubusercontent.com/96730074/217629185-3a831f37-51d8-4bb5-8011-e58280071366.png)



**2. What are the locations with the most expensive apartments?**

Below locations have the highest prices of flats, which reach over 800 USD per night:
![8](https://user-images.githubusercontent.com/96730074/217888684-2f044a25-866d-445e-b799-f82b1963e83a.png)


**3. Which hosts that have more than 100 flats, has the best rating?**\

![9](https://user-images.githubusercontent.com/96730074/217888952-d674bc58-d030-434d-ae62-b34545a56435.png)


**4. Which type of room is the cheapest?**

It turned out, that hotel rooms are statistically more expensive than rented flats or rooms. The cheapest option is shared room, however the difference between shared room, private room and entire apartment or house is not large:


![10](https://user-images.githubusercontent.com/96730074/217889625-d25b6adc-2bdf-454e-9cfd-ad11aa7d6898.png)

**5. Are newest flats the most expensive?**

According to the below graph, the construction year does not impact the apartment price. It may be due to the fact that the older appartments indicate the construction year of 2003, so still are relatively new:
![11](https://user-images.githubusercontent.com/96730074/217890145-ba5a2f12-f4f0-422c-a378-ee918d2fef15.png)





