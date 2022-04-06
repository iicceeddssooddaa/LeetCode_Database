SELECT name, population, area
FROM World
HAVING area >= 3000000 OR population >= 25000000;
