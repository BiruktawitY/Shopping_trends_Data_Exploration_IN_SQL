SELECT *
FROM shopping_trends;

-- create a copy of the table for data analysis 
CREATE TABLE shopping_trends_copy LIKE shopping_trends;

INSERT INTO shopping_trends_copy 
SELECT * 
FROM shopping_trends;

SELECT  *
FROM shopping_trends_copy
LIMIT 10;

-- Check duplicates
SELECT `Customer ID`
FROM shopping_trends_copy
GROUP BY `Customer ID`
HAVING COUNT(*) > 1;

-- Data analysis
-- Gender Distribution
SELECT Gender, COUNT(*) total_count
FROM shopping_trends_copy
GROUP BY Gender;

-- Subscription status and promo code distribution based on Gender
SELECT Gender, `Subscription Status`, `Promo Code Used`, COUNT(*) total_count
FROM shopping_trends_copy
GROUP BY Gender, `Subscription Status`, `Promo Code Used`;

-- Category distribution 
SELECT Category, COUNT(*) total_num
FROM shopping_trends_copy
GROUP BY Category
ORDER BY total_num desc;

-- Most purchased item in each category
SELECT Category, `Item Purchased`, Count
FROM (
		SELECT  Category, `Item Purchased`,COUNT(*) Count, 
			DENSE_RANK() OVER(PARTITION BY Category ORDER BY COUNT(*) DESC) Ranked
		FROM shopping_trends_copy
		GROUP BY Category,`Item Purchased`
	) AS RankedItems
WHERE Ranked = 1;

-- Geographic Distribution
SELECT Location, count(*) total_count
FROM shopping_trends_copy
GROUP BY location
ORDER BY total_count desc
LIMIT 10;

-- Payment Method Preferences Distribution
SELECT `Preferred Payment Method` used_payment, COUNT(*) counted
FROM shopping_trends_copy
GROUP BY used_payment
ORDER BY counted DESC;

-- Seasonal sales trend
SELECT Season, Category, count(*) counted,CONCAT('$' , SUM(`Purchase Amount (USD)`) )total_spent, 
	rank() over(partition by Season ORDER by sum(`Purchase Amount (USD)`) DESC) RANKED
FROM shopping_trends_copy
GROUP BY Season,Category
ORDER BY Season;

-- Purchase frequency distribution
SELECT `Frequency of Purchases`, count(*) total_count
FROM shopping_trends_copy
GROUP BY `Frequency of Purchases`
ORDER BY total_count DESC;
