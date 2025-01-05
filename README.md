 # Customer shopping trends Data Exploration
 ## Table of Contents
  - [Project Overview](#project-overview)
  - [Data source](#data-source)
  - [Tools Used](#tools-used)
  - [Data prepartaion](#data-preparation)
  - [Gender Distribution](#gender-distribution)
  - [Category Distribution](#category-distribution)
  - [Geographic Distribution](#geographic-distribution)
  - [Payment Method Preferences Distribution](#payment-method-preferences-distribution)
  - [Seasonal Sales Trends Analysis](#seasonal-sales-trends-analysis)
  - [Purchase Frequency Distribution](#purchase-frequency-distribution)


 ### Project Overview
  This project aims to uncover insights into the latest shopping trends by analyzing customer behaviours and transaction patterns. Our goal is to understand how different factors such as location, gender influence shopping habits. This analysis is supported by SQL for data manipulation and Tableau for visualization, seeks to uncover actionable trends that inform promo usage activities, enhancing customer engagement and others. 
  
 ### Data source 
This analysis is based on a dataset from kaggle, which can be found [here](https://www.kaggle.com/datasets/bhadramohit/customer-shopping-latest-trends-dataset).\
The dataset shopping_trends.csv contains 3900 rows with 19 columns. \
 Below are the key features of dataset: 
   - **Customer Information**: Age, Gender, Location,
   - **Transaction Details**: Item Purchased, Category, Purchase Amount(USD), Location, Size, Color, Season, Review Rating, Discount Applied, Promo Code Used
   - **Customer Engagement**: Subscription Status, Previous Purchases, Frequency of Purchases
   - **Payment and Shipping**: Preferred Payment Method, Shipping Type, Payment Method

### Tools Used
 - MySQL - For data cleaning, and data analysis.
 - Tableau - For creating insightful and interactive visualizations.

## Data analysis
### Data Preparation
1. **Creating a Copy of the Table**: 
```sql
CREATE TABLE shopping_trends_copy LIKE shopping_trends;

INSERT INTO shopping_trends_copy 
SELECT * 
FROM shopping_trends;
```
This query creates a new table called `shopping_trends_copy` which is an exact replica of `shopping_trends`, to ensure that our data analysis does not alter the original data. 

2. **Viewing a sample of the dataset**:
```sql
SELECT  *
FROM shopping_trends_copy
LIMIT 10;
```
This query shows the first 10 rows of the copied table
![image](https://github.com/user-attachments/assets/f577e7b2-f85b-472a-8e12-a54dd685fe3d)

3. **Check for duplicates Entries**:
```sql
SELECT `Customer ID`
FROM shopping_trends_copy
GROUP BY `Customer ID`
HAVING COUNT(*) > 1;
```
![image](https://github.com/user-attachments/assets/04dfd519-1e64-433b-9b6c-3e98888c84d3) \
No duplicate values

### Gender Distribution
This section examines the distribution of customers based on Gender. To analyze the gender distribution of our customers, we used the following SQL query:
```sql
SELECT Gender, COUNT(*) total_count
FROM shopping_trends_copy
GROUP BY Gender;
```
**Output**:

![image](https://github.com/user-attachments/assets/8f55c7a5-47f6-4937-84d3-0024fbaa9a11)

The output table from the SQL query shows that there are 2,652 male customers and 1,248 female customers. This data was then visualized to better illustrate the gender disparity among our customer base.

**Visualization**:

![image](https://github.com/user-attachments/assets/0d70b95c-bdb2-415d-bc78-0898ab6d6577)

The bar chart depicts the gender distribution, with male customers significantly outnumbering female customers. This indicates a gender ratio 68% male to 32% female, highlighting a potential area of focus for marketing product alignment strategies to better a more balanced customer demographic.

**Subscription Status and Promo Code Usage Distribution by Gender** :\
To further analyze customer bahaviour regarding promo code usage and subscription status across different genders, the following SQL query was used:
```sql
SELECT Gender, `Subscription Status`, `Promo Code Used`, COUNT(*) total_count
FROM shopping_trends_copy
GROUP BY Gender, `Subscription Status`, `Promo Code Used`;
```
**Output**:

![image](https://github.com/user-attachments/assets/81cc8eed-286d-4fae-aea5-38e3a72f814c) \
The query results reveal that:
 - A total of 1053 male customers have both a subscription and have used a promo code.
 - 624 male customers have used a promo code without subscribing.
 - 975 male customers have neither subscribed nor used a promo code.
 - All 1,248 female customers have not subscribed nor used a promo code.

**Visualization**:

![image](https://github.com/user-attachments/assets/6835c88c-1b87-4f1a-9b31-371f2b64831b)

The bar chart above provides a visual breakdown of the finding and highlights significant trends in customer behaviour regarding subscription and promo code usage.The visualization assists in understanding the skew towards male engagement in promotional activities and subscription services, while also underlining the complete lack of engagement from female customers in these areas.


### Category Distribution:
In this dataset there are four categories included for shopping: Clothing, Accessories, Footwear, and Outwear.In this section,we will be analyzing the distribution of these different categories using the following SQL query:
```sql
-- Category distribution 
SELECT Category, COUNT(*) total_num
FROM shopping_trends_copy
GROUP BY Category
ORDER BY total_num desc;
```
**Output**: \
![image](https://github.com/user-attachments/assets/22e7d4a7-957f-4c2e-93c2-13a18b8b6ecc) \
This output table lists the total counts for each category, sorted in descending order based on popularity.

**Visualization**: \
![image](https://github.com/user-attachments/assets/aeb35d34-fe22-4075-873b-854af4351714) \
As depicted in the visualization above, Clothing is the most popular category with 1,737 units sold, followed by Accessories, Footwear, and Outwear, with the latter being the least popular at 324 units. This distribution is predicatble, as clothing generally has a broader appeal and more frequent purchasing turnover compared to specialized items like outwear.

**Popular Item Purchased in Each Category**: \
To identify the most popular item purchased within each category, we use the following SQL query:
```sql
-- Most purchased item in each category
SELECT Category, `Item Purchased`, Count
FROM (
	SELECT  Category, `Item Purchased`,COUNT(*) Count, 
		DENSE_RANK() OVER(PARTITION BY Category ORDER BY COUNT(*) DESC) Ranked
	FROM shopping_trends_copy
	GROUP BY Category,`Item Purchased`
) AS RankedItems
WHERE Ranked = 1;
```
**Output**:\
![image](https://github.com/user-attachments/assets/ebab7993-b279-4d82-81fe-1588b1c65885)\
The above query provides a detailed view of the most popular items in each shopping category. The output reveals that Jewelry is the top item purchased in Accessories, Blouses and Pants in Clothing, Sandals in Footwear, and Jackets in Outwear, each with substantial sales counts, showing clear prefernces within consumer purchasing patterns.

### Geographic Distribution

To understand the geographic distribution of customer purchases better, the following SQL query was used to identify the top 10 locations with the highest number of purchases:
```sql
SELECT Location, count(*) total_count
FROM shopping_trends_copy
GROUP BY location
ORDER BY total_count desc
LIMIT 10;
```
**Output**:\
![image](https://github.com/user-attachments/assets/504d0023-158b-4b00-8e36-02232d13c4f6)

The output table displays the top 10 locations where customers are making purchases, with Montana leading with 96 purchases, closely followed by California with 95, and Idaho with 93.This indicates a diverse geographic spread in terms of customer base, which could be crucial for regional marketing strategies.The results reveals somewhat unexpected leader with Monatana having the most transactions, suggesting a strong market presence in areas that may not typically be seen as major commercial hubs. This information can be used to expand product lines to preferences observed in these top-performing locations.

### Payment Method Preferences Distribution
To gain insights into the preferred payment methods of our customers, the following SQL query was used:
```sql
SELECT `Preferred Payment Method` used_payment, COUNT(*) counted
FROM shopping_trends_copy
GROUP BY used_payment
ORDER BY counted DESC;
```
**Output**:\
![image](https://github.com/user-attachments/assets/0c7bf633-0cb6-4e10-8565-eb8871878690)

The output table lists the number of transactions per payment method, showing an even distribution among the options. The data indicates a broad preference for digital payment methods, with PayPal, Credit Card, and Venmo collectively accounting for a significant portion of the transactions. This suggests that our customer base is more comfortable with electronic transactions, which could influence future decisions on payment integerations.

### Seasonal Sales Trends Analysis
The following SQL query is used to analyze spending patterns across different product categories in various seasons.It groups the data by season and category, summing up the revenue and ranking them within each season:
```SQL
SELECT Season, Category, count(*) counted,CONCAT('$' , SUM(`Purchase Amount (USD)`) )total_spent, 
	rank() over(partition by Season ORDER by sum(`Purchase Amount (USD)`) DESC) RANKED
FROM shopping_trends_copy
GROUP BY Season,Category
ORDER BY Season;
```
**Output**:\
![image](https://github.com/user-attachments/assets/64145cd9-d8a5-4a23-8875-2ffa16807a2d)\
The SQL output table above provides a breakdown of counts and total expenditure for each category across different seasons, highlighting the ranking of each category based on the spending within the particular season.

**Visualization**:
![image](https://github.com/user-attachments/assets/61f9dcdb-9989-4828-a432-9249465d9928)
The bar charts provided illustrate the seasonal spending distribution across various product categories, demonstrating a consistent dominance of clothing in total expenditures throughout the seasons, For instance, during the spring, clothing leads with a spending amount of $27,692, significantly outperforming other categories. This pattern is repeated in other seasons, with clothing maintaining the highest spending in winter and summer as well. The chart also reveal fluctuating but substantial expendictures on accessories and footwear, highlighting seasonal variations in consumer preferences.

## Purchase Frequency Distribution 
To determine the purchase patterns of our customers, we analyzed the frequency of purchases using the following SQL query:
```sql
SELECT `Frequency of Purchases`, count(*) total_count
FROM shopping_trends_copy
GROUP BY `Frequency of Purchases`
ORDER BY total_count DESC;
```
**Output**:\
![image](https://github.com/user-attachments/assets/3e74b5ff-2b9b-448b-940a-5897abdb53f5)\
The output table from the SQL query categorizes customer purchases by frequenct, revealing that the most common frequency is every 3 months, with 584 instances. This suggests that customers tend to plan their shopping around specific times of the year, possibly influenced by seasonal changes or sales event. Lower frequencies for monthly, bi-weekly, fortnightly, and weekly purchases indicate less regular purchasing habits.



 

