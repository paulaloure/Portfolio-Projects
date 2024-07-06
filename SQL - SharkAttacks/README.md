# Project 5: SQL - Shark Attacks

The aim of this project was data cleaning and exploratory analysis in PostgreSQL. I have used the real data regarding shark attacks over the world, analysing among others the attacks caused by various shark species, injuries in various body parts and in many countries 

**Skills used: group by, partition by, CTE, subqueries, mathematical and string operations, regex**

Project consist of 3 parts:

**PART 1: Creating the table** \
**PART 2: Cleaning the data** \
In this part I have gone over every column in the data, checked it distinct values, nulls and duplicates. I have clean the data, removing or changing incorrect entries, such as date in the future, or values other then Y and N in column with fatal attacks.
I have grouped data in categories (shark species, body part injured) and extracted the values from the text strings.

**PART 3: Data analysis** 

In this part I have answered the below questions:

***1. Which of the states in US have the higher amount of shark attacks?***

![sa1](https://user-images.githubusercontent.com/96730074/227324161-bfa7728b-9d9d-4b92-8bce-fb6487f36569.png)

Based on the data, the majority of the shark attacks happened in Florida. Then, the next are Hawaii and California 

***2. What is the percentage of attacks between men and women based on the available data?***


![sa2](https://user-images.githubusercontent.com/96730074/227325376-787e1872-e21b-40d3-9f5d-3ca9a4e6a700.png)
![sa2a](https://user-images.githubusercontent.com/96730074/227325360-ad57bf5c-3cb7-495e-92f2-f9106c4e6c34.png)
Based on the available data, victis of 89% of shark attacks were men

***3. Which of the US states has the higher rate of fatal attacts with regard to all attacks?***


![sa3](https://user-images.githubusercontent.com/96730074/227325735-99acbafd-525b-4490-a94b-00e796bf91c3.png) \
There are a few states, where the statistics are high, because there are not many shark attacks. 
For these states, even 2 fatal attacks corresponds to high percentage of all attacks (for example 40% for Mississipi) \
For Hawaii, with 69 fatal attacks, 25% of all attacks were fatal. \
For Florida, where they were 65 fatal attacks, it corresponds to only 6.7% of all attacks.

***4. What is the percentage of fatal attacts between man and woman?***
![sa4](https://user-images.githubusercontent.com/96730074/227326423-dbc918b1-d13a-4215-8e64-ef3a27a63254.png)

Rate of fatal accidents for men is 27% and for woman is 20% with regard to all shark attacks.

***5. What percentage of all fatal attacks were provoked?***

![s5](https://user-images.githubusercontent.com/96730074/227326834-3c618857-4c2a-4f1b-9285-3dee0f6eb1cf.png)

Only 1.46% of all fatal attacks were provoked.

***6. Is there a region where attacks by some shark species are most common than by the others?***

![sa6a](https://user-images.githubusercontent.com/96730074/227328773-85663978-9712-4bb2-b406-288057520333.png)
![sa6b](https://user-images.githubusercontent.com/96730074/227328815-74453d02-5b94-493b-8296-071dffa2bca9.png)

Based on analyzis, we see that:
- nearly 29% of all attacks in USA are caused by Great White Shark, and 18% by Tiger Shark 
- 57% of all attacks in South Affrica are caused by Great White Shark 
- 90% of attacks in Italy are by Great White Shark 
- 100% of attacks in Croatia is by Great White Shark 
- 100% of attacks in Iran is by Bull Shark.

***7. Which shark species attack more often?***

![sa7](https://user-images.githubusercontent.com/96730074/227330957-02746434-2aba-4d73-ab36-b92d9b863da0.png)

Over 30% of all attacks are caused by great white sharks!

***8. Which shark species are the most deadly?***

![sa8](https://user-images.githubusercontent.com/96730074/227332806-bc906b6a-c6d8-44f9-aed8-807722d5388e.png)

Based on the data, nearly 30% of Tiger Shark attacks are deadly. \
For Great White Shark it is 24%, so every 4th attack of Great White Shark is fatal.\
Good news is that non of the attacks by carpet shark (53) or gray reef shark (45) was fatal.

***9. Which body part is attacked by sharks the most often?***

![sa9b](https://user-images.githubusercontent.com/96730074/227333289-8d494bc7-8fcd-44b4-8ae7-8f35f9fb57cf.png)
![sa9a](https://user-images.githubusercontent.com/96730074/227333305-40331ab5-f8aa-46f3-8b7d-afafd36d8070.png)

Based on the data, over 40% of injuries is of the leg and over 22 of feet, so over 60% of lower limbs.
15% of injuries is of arm and 16% of hand, so over 30% of upper limbs.

***10. Is there any shark than attacked most time different body part than leg?***

![10a](https://user-images.githubusercontent.com/96730074/227334439-f766ff55-9e3f-42e3-9d5c-de6022e3633d.png)

Based on the data, for most species the body part attacked most often is leg or feet, however there are some shark species for which the most often attacted part is arm (caribbean reef shark) or hand (for example oceanic whitetip shark which most often attack hand or arm).

***11. What are the activities with the highest ratio of fatal attacks?***

![sa11a](https://user-images.githubusercontent.com/96730074/227334825-a46d2b97-b818-4818-b5e6-059089d1ec71.png)
![sa11b](https://user-images.githubusercontent.com/96730074/227335116-20f523c3-d9a8-4eda-90c1-eb2a39b3759e.png)

The highest probability of fatal attacks experienced people that fell into water. 
According to data, nearly 84% of them died after being attacked!
The next activity is boating and sea disaster.
The lowest percentage is for boogie boarding and surfing, where less than 7% of all attacks are fatal.
\
\
Data source: https://www.kaggle.com/datasets/mysarahmadbhat/shark-attacks
