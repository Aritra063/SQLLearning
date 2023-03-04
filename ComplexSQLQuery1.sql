create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');


/*
Output
TeamName|MatchesPlayed|NumberOfWins|NumberOfLosses
        |             |            |
*/

SELECT TOP (1000) [Team_1]
      ,[Team_2]
      ,[Winner]
  FROM [LearnSQL].[dbo].[ICCWorldCup]

-- Solution
SELECT 
    TeamName,
    COUNT(TeamName) AS NumOfMatchesPlayed,
    SUM(WinOrLoose) AS NumberOfWins,
    COUNT(TeamName) - SUM(WinOrLoose) AS NumberOfLosses
FROM
(SELECT 
    Team_1 AS TeamName,
    CASE
        WHEN Team_1 = Winner
            THEN 1
        ELSE 0
    END WinOrLoose
FROM [LearnSQL].[dbo].[ICCWorldCup]
UNION ALL
SELECT 
    Team_2 AS TeamName,
    CASE
        WHEN Team_2 = Winner
            THEN 1
        ELSE 0
    END WinOrLoose
FROM [LearnSQL].[dbo].[ICCWorldCup]) A
GROUP BY TeamName
ORDER BY NumberOfWins DESC