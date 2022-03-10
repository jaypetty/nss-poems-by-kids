--1.What grades are stored in the database?
SELECT *
FROM Grade;

--2.What emotions may be associated with a poem?
SELECT *
FROM Emotion;

--3.How many poems are in the database?
--COUNT() returns how many rows match that criteria
SELECT COUNT(p.id) as PoemTotal
From Poem p;

--4.Sort authors alphabetically by name. What are the names of the top 76 authors?
-- ORDER BY will order things in the table in asc/desc order
SELECT TOP 76 Author.Name
FROM Author
ORDER BY Author.Name asc;

--5.Starting with the above query, add the grade of each of the authors.
SELECT TOP 76 Author.Name, Grade.Name as Grade 
FROM Author
JOIN Grade ON Author.GradeId = Grade.Id
ORDER BY Author.Name 

--6.Starting with the above query, add the recorded gender of each of the authors.
SELECT TOP 76 Author.Name, Grade.Name as Grade, Gender.Name as Gender
FROM Author 
JOIN Grade ON Author.GradeId = Grade.Id
JOIN Gender ON Author.GenderId = Gender.Id
ORDER BY Author.Name asc;

-- 7.What is the total number of words in all poems in the database?
-- SUM() adds the number of words in all the poems.
SELECT SUM(Poem.WordCount)  'TotalWords'
FROM Poem;

--8.Which poem has the fewest characters?
SELECT TOP 1 Poem.Title, Poem.CharCount
FROM Poem
ORDER BY Poem.CharCount

--9. How many authors are in the third grade?
SELECT COUNT(Author.Name) as '3rd Graders'
FROM Author
JOIN Grade ON GradeId = Grade.Id
WHERE Grade.Name = '3rd Grade';

-- 10. How many total authors are in the first through third grades?
SELECT COUNT(Author.Name) as 'Authors first through third'
FROM Author
JOIN Grade ON GradeId = Grade.Id
WHERE Grade.Name = '3rd Grade' OR Grade.name = '1st Grade' OR Grade.name = '2nd Grade'

-- 11. What is the total number of poems written by fourth graders?
SELECT COUNT(Poem.Id) as 'Poems by 4th' 
FROM Poem
JOIN Author on Poem.AuthorId = Author.Id
JOIN Grade on GradeId = Grade.Id
WHERE Grade.Name = '4th Grade';

-- 12. How many poems are there per grade?
SELECT Grade.Name, COUNT(Poem.Id) 'Total Number of Poems for each grade'
FROM Poem
Left Join Author ON Poem.AuthorId = Author.id
Left Join Grade ON Author.GradeId = Grade.id 
GROUP BY Grade.Name
ORDER BY Grade.Name

-- 13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)select count (*) as Authors, Grade.name as Grade
SELECT COUNT (*) as Authors, Grade.name as Grade
from Author
Left Join Grade ON author.GradeId = Grade.id
GROUP BY Grade.Name
ORDER BY Grade.Name  

-- 14. What is the title of the poem that has the most words?
SELECT TOP 1 Poem.Title, Poem.WordCount
FROM Poem
ORDER BY Poem.WordCount DESC

-- 15. Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT TOP 1 a.Id, a.Name, COUNT(p.Id) PoemCount
FROM Author a
JOIN Poem p ON p.AuthorId = a.Id
GROUP BY a.Id, a.Name
ORDER BY COUNT(p.Id) DESC

-- 16. How many poems have an emotion of sadness?
SELECT COUNT(*) 'Sad Poem Count'
FROM Poem p
JOIN PoemEmotion pe ON pe.PoemId = p.Id
JOIN Emotion e ON pe.EmotionId = e.Id
WHERE e.Name = 'Sadness'

-- 17. How many poems are not associated with any emotion?
SELECT COUNT(*) 'Emotionless Poems'
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
WHERE pe.Id IS NULL

-- 18. Which emotion is associated with the least number of poems?



-- 19. Which grade has the largest number of poems with an emotion of joy?
SELECT TOP 1 g.Name, COUNT(p.Id) 'NumofPoems'
FROM Grade g
JOIN Author a ON a.GradeId = g.Id
JOIN Poem p ON p.AuthorId = a.Id
JOIN PoemEmotion pe ON pe.PoemId = p.Id
JOIN Emotion e ON e.Id = pe.EmotionId
WHERE e.Name = 'Joy'
GROUP BY g.Id, g.Name
ORDER BY COUNT(p.Id) DESC

-- 20. Which gender has the least number of poems with an emotion of fear?
SELECT TOP 1 g.Name, COUNT(p.Id) as NumPoems
FROM Poem p
JOIN PoemEmotion pe ON p.Id = pe.PoemId
JOIN Emotion e ON pe.EmotionId = e.Id
JOIN Author ON p.AuthorId = Author.Id
JOIN Gender g ON Author.GenderId = g.Id
WHERE e.Name = 'Fear'
GROUP BY g.Name, e.Name
ORDER BY COUNT(p.Id);
