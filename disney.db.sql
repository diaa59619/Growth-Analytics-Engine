CREATE TABLE users (
    User_ID INTEGER,
    Region TEXT,
    Age_Group TEXT,
    Subscription_Type TEXT
);

CREATE TABLE content (
    Content_ID INTEGER,
    Content_Name TEXT,
    Genre TEXT,
    Release_Type TEXT
);

CREATE TABLE user_activity (
    User_ID INTEGER,
    Content_ID INTEGER,
    Watch_Time INTEGER,
    Sessions INTEGER,
    Date TEXT
);

CREATE TABLE campaign (
    Campaign_ID INTEGER,
    Channel TEXT,
    Campaign_Type TEXT,
    Cost INTEGER
);

CREATE TABLE campaign_performance (
    Campaign_ID INTEGER,
    User_ID INTEGER,
    Clicked INTEGER,
    Converted INTEGER
);
SELECT * FROM users LIMIT 5;

SELECT * FROM content LIMIT 5;
SELECT * FROM user_activity LIMIT 5;
SELECT * FROM campaign LIMIT 5;
SELECT * FROM campaign_performance LIMIT 5;

SELECT Region, COUNT(*) AS Total_Users
FROM users
GROUP BY Region
ORDER BY Total_Users DESC;

SELECT Subscription_Type, COUNT(*) AS Total
FROM users
GROUP BY Subscription_Type;

SELECT Region, SUM(Watch_Time * Sessions) AS Engagement
FROM user_activity ua
JOIN users u ON ua.User_ID = u.User_ID
GROUP BY Region
ORDER BY Engagement DESC;

SELECT User_ID, AVG(Watch_Time * Sessions) AS Avg_Engagement
FROM user_activity
GROUP BY User_ID
ORDER BY Avg_Engagement DESC
LIMIT 10;

SELECT Genre, SUM(Watch_Time) AS Total_Watch
FROM user_activity ua
JOIN content c ON ua.Content_ID = c.Content_ID
GROUP BY Genre
ORDER BY Total_Watch DESC;

SELECT Release_Type, SUM(Watch_Time) AS Watch_Time
FROM user_activity ua
JOIN content c ON ua.Content_ID = c.Content_ID
GROUP BY Release_Type;


SELECT Channel, SUM(Cost) AS Total_Spend
FROM campaign
GROUP BY Channel;

SELECT Channel,
       AVG(Clicked) AS CTR,
       AVG(Converted) AS Conversion_Rate
FROM campaign_performance cp
JOIN campaign c ON cp.Campaign_ID = c.Campaign_ID
GROUP BY Channel;

SELECT 
    COUNT(*) AS Total_Users,
    SUM(Clicked) AS Clicked_Users,
    SUM(Converted) AS Converted_Users,
    ROUND(SUM(Clicked)*100.0/COUNT(*),2) AS CTR_Percentage,
    ROUND(SUM(Converted)*100.0/COUNT(*),2) AS Conversion_Percentage
FROM campaign_performance;

SELECT User_ID, SUM(Watch_Time * Sessions) AS Total_Engagement
FROM user_activity
GROUP BY User_ID
ORDER BY Total_Engagement DESC
LIMIT 5;

SELECT u.Region, c.Genre, SUM(Watch_Time) AS Total_Watch
FROM user_activity ua
JOIN users u ON ua.User_ID = u.User_ID
JOIN content c ON ua.Content_ID = c.Content_ID
GROUP BY u.Region, c.Genre
ORDER BY Total_Watch DESC
LIMIT 10;