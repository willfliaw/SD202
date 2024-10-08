# TP1

1. SELECT name FROM world WHERE continent='Europe'

2. SELECT DISTINCT continent FROM world

3. SELECT name FROM world WHERE name LIKE 'F%'

4. SELECT name FROM world WHERE name LIKE '%z%'

5. SELECT name FROM world WHERE population <= 1000000

6. SELECT name, population FROM world WHERE continent = 'Europe'

7. SELECT name, population FROM world WHERE name IN ('France', 'Germany', 'Italy') ORDER BY name

8. SELECT population FROM world WHERE name = 'France'

9. SELECT name, population, area FROM world WHERE population >= 100000000 OR area >= 3000000 ORDER BY name

10. SELECT name, population, area FROM world WHERE continent = 'Europe' AND (population >= 50000000 OR area >= 500000) ORDER BY name

11. SELECT name, population, area FROM world WHERE (population >= 100000000 AND NOT area >= 3000000) OR (area >= 3000000 AND NOT population >= 100000000) ORDER BY name

12. SELECT name FROM world WHERE capital = name ORDER BY name

13. SELECT name, capital FROM world WHERE CHAR_LENGTH(capital) = CHAR_LENGTH(name) AND capital <> name ORDER BY name

14. SELECT name, population FROM world ORDER BY population LIMIT 1

15. SELECT name, population FROM world WHERE population IS NOT NULL ORDER BY population DESC LIMIT 5

16. SELECT name, population, area FROM world ORDER BY name LIMIT 1 OFFSET 99

17. SELECT * FROM (SELECT name, population FROM world WHERE area IS NOT NULL AND

population IS NOT NULL ORDER BY area DESC LIMIT 20) AS T ORDER BY population DESC LIMIT 10;

18. SELECT name, population/NULLIF(area, 0) AS density FROM world WHERE continent = 'Asia' ORDER BY name

19. SELECT name, 'yes' AS dense FROM world WHERE

continent = 'Asia' AND population/NULLIF(area, 0) >= 100

UNION SELECT name, 'no' AS t FROM world WHERE continent = 'Asia' AND population/NULLIF(area, 0) < 100

ORDER BY dense DESC, name

20. SELECT COUNT(*) FROM world;

21. SELECT SUM(population) FROM world;

22. SELECT continent, COUNT(*) FROM world GROUP BY continent ORDER BY continent

23. SELECT continent, SUM(population), SUM(area) FROM world GROUP BY continent ORDER BY continent

24. SELECT continent, SUM(population) AS total FROM world GROUP BY continent HAVING SUM(population) >= 100000000 ORDER BY continent

25. SELECT continent, COUNT(*) FROM world WHERE population >= 1000000 GROUP BY continent ORDER BY continent

26. SELECT AVG(population) AS average FROM world

27. SELECT continent, ROUND(SUM(population)/SUM(area)) AS total, ROUND(AVG(population/NULLIF(area, 0))) AS average, ROUND(SUM(population/NULLIF(area, 0))/COUNT(*)) AS fake_average FROM world

GROUP BY continent

28. SELECT SUBSTR(name, 1, 1) AS alpha, SUM(population) FROM world GROUP BY alpha

ORDER BY alpha

29. SELECT W1.continent, W1.name AS largest, W2.name AS most_populous FROM world AS W1, world AS W2

WHERE W1.continent = W2.continent AND W1.area IS NOT NULL AND W2.population IS NOT NULL

AND NOT EXISTS

  (SELECT 1 FROM world AS W WHERE W.continent = W1.continent AND W.area > W1.area)

AND NOT EXISTS

  (SELECT 1 FROM world AS W WHERE W.continent = W2.continent AND W.population > W2.population)

ORDER BY W1.continent

30. SELECT continent, SUM(total) FROM

(SELECT continent, COUNT(*) AS total FROM world AS W1

WHERE population > (SELECT population FROM world AS W2 WHERE W1.continent =

W2.continent AND W2.area IS NOT NULL ORDER BY area DESC LIMIT 1) GROUP BY continent

UNION

SELECT DISTINCT continent, 0 AS TOTAL FROM world) AS T GROUP BY continent

ORDER BY continent
