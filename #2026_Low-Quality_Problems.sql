SELECT problem_id
FROM Problems
WHERE (Problems.likes / (Problems.likes + Problems.dislikes)) < .6
ORDER BY problem_id;
