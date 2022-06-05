SELECT firstName, lastName, city, state
FROM Person
LEFT OUTER JOIN Address ON Person.personID = Address.personID;
