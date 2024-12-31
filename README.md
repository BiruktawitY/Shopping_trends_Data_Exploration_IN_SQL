 # Customer shopping trends Data Exploration
  - [Project Overview](#project-overview)
  - [Gender Distribution](#gender-distribution)

 ### Project Overview
  This project aims to uncover insights into the latest shopping trends by analyzing customer behaviours and transaction patterns. Our goal is to understand how different factors such as location, gender influence shopping habits and how these 

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
Output:

![image](https://github.com/user-attachments/assets/8f55c7a5-47f6-4937-84d3-0024fbaa9a11)

**Visualization**

This chart below is the distribtuion of customers based on gender:

![image](https://github.com/user-attachments/assets/0d70b95c-bdb2-415d-bc78-0898ab6d6577)

The dataset contains a higher number of a male customers compared to female customers.

Subscription status and promo code distribution based on gender 
and based on the image you can tell no female neither used a promo code nor have a subscription status
![image](https://github.com/user-attachments/assets/6835c88c-1b87-4f1a-9b31-371f2b64831b)





### Category Distribution:
```sql
-- category distribution 
SELECT Category, COUNT(*) total_num
FROM shopping_trends_copy
GROUP BY Category
ORDER BY total_num desc;
```
![image](https://github.com/user-attachments/assets/22e7d4a7-957f-4c2e-93c2-13a18b8b6ecc)

![image](https://github.com/user-attachments/assets/aeb35d34-fe22-4075-873b-854af4351714)

```sql
SELECT Location, count(*) total_count
FROM shopping_trends_copy
GROUP BY location
ORDER BY total_count desc
LIMIT 10;
```

![image](https://github.com/user-attachments/assets/504d0023-158b-4b00-8e36-02232d13c4f6)

```sql
SELECT `Preferred Payment Method` used_payment, COUNT(*) counted
FROM shopping_trends_copy
GROUP BY used_payment
ORDER BY counted DESC;
```
![image](https://github.com/user-attachments/assets/0c7bf633-0cb6-4e10-8565-eb8871878690)

SUBSCRIPTION 
![image](https://github.com/user-attachments/assets/6835c88c-1b87-4f1a-9b31-371f2b64831b)

SEASON TREND
```SQL
SELECT Season, Category, count(*) counted,CONCAT('$' , SUM(`Purchase Amount (USD)`) )total_spent, 
	rank() over(partition by Season ORDER by sum(`Purchase Amount (USD)`) DESC) RANKED
FROM shopping_trends_copy
GROUP BY Season,Category
ORDER BY Season;
```

![image](https://github.com/user-attachments/assets/64145cd9-d8a5-4a23-8875-2ffa16807a2d)

![image](https://github.com/user-attachments/assets/61f9dcdb-9989-4828-a432-9249465d9928)

```sql
SELECT `Frequency of Purchases`, count(*) total_count
FROM shopping_trends_copy
GROUP BY `Frequency of Purchases`
ORDER BY total_count DESC;
```

![image](https://github.com/user-attachments/assets/3e74b5ff-2b9b-448b-940a-5897abdb53f5)





 

