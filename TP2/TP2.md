# TP2

1. SELECT title, name FROM movie, actor WHERE title LIKE 'Star Wars%' AND director = actor.id

ORDER BY title

2. SELECT name FROM movie,actor,casting WHERE movie.id = casting.movieid AND

actor.id = casting.actorid AND title = 'Jurassic Park' ORDER BY ord

3. SELECT title FROM movie,actor,casting WHERE movie.id = casting.movieid AND

actor.id = casting.actorid AND name = 'George Clooney' ORDER BY title

4. SELECT title, name FROM movie, casting, actor WHERE yr = 1920 AND

casting.movieid = movie.id AND casting.actorid = actor.id AND ord=1 ORDER BY title

5. SELECT title, SA.name, D.name FROM movie, casting, actor as SA, actor as D

WHERE yr = 1920 AND casting.movieid = movie.id AND casting.actorid = SA.id AND ord=1 AND D.id = director ORDER BY title

6. SELECT title, COUNT(*) AS cnt FROM movie, casting WHERE casting.movieid = movie.id GROUP BY movie.id, title ORDER BY cnt DESC LIMIT 5

7. SELECT yr, COUNT(*) AS count FROM movie, casting, actor WHERE movie.id = casting.movieid AND

actor.id = casting.actorid AND name = 'Rock Hudson' GROUP BY yr HAVING COUNT(*) > 1

ORDER BY COUNT(*) DESC, yr

8. SELECT DISTINCT A2.name FROM actor AS A1, actor AS A2, casting AS C1, casting as C2 WHERE A1.name = 'Harrison Ford' AND A1.id = C1.actorid AND C1.movieid = C2.movieid AND C2.actorid = A2.id AND C2.ord = 1 AND A2.name <> 'Harrison Ford' ORDER BY A2.name

9. SELECT title FROM movie, actor, casting WHERE casting.movieid = movie.id AND

casting.actorid = actor.id AND actor.name = 'Woody Allen' AND movie.director = actor.id ORDER BY title

10. SELECT title FROM movie, actor, casting WHERE casting.movieid = movie.id AND

casting.actorid = actor.id AND actor.name = 'Woody Allen'

UNION

SELECT title FROM movie, actor WHERE movie.director = actor.id AND actor.name = 'Woody Allen'

ORDER BY title

11. SELECT title FROM movie,casting AS C1, casting AS C2, actor AS A1, actor AS

A2 WHERE A1.id = C1.actorid AND A2.id = C2.actorid AND C1.movieid = movie.id AND

C2.movieid = movie.id AND A1.name = 'Alain Delon' AND A2.name = 'Catherine Deneuve'

12. SELECT name FROM actor WHERE NOT EXISTS (

  SELECT id FROM movie WHERE TITLE LIKE 'Star Wars%' AND NOT EXISTS (

    SELECT * FROM casting WHERE movieid=movie.id AND actorid=actor.id))

13. SELECT name FROM actor, casting, movie

    WHERE casting.actorid = actor.id AND casting.movieid = movie.id AND name <> 'Harrison Ford'

    AND NOT EXISTS (

        SELECT 1 FROM movie AS M1, casting AS C1

            WHERE C1.movieid = M1.id AND C1.actorid = actor.id

            AND NOT EXISTS (

                SELECT 1 FROM casting AS C2, actor AS A2

                    WHERE A2.name = 'Harrison Ford'

                    AND C2.actorid = A2.id

                    AND C2.movieid = C1.movieid))

    GROUP BY name HAVING COUNT(movie.id) > 1

14. WITH oldmov AS (SELECT id, yr FROM movie WHERE yr <= 1930),

aactor AS (SELECT id, name FROM actor WHERE name LIKE 'A%' OR name LIKE 'B%' OR name LIKE 'C%')

SELECT DISTINCT A1.name, A2.name FROM aactor AS A1, aactor AS A2, casting AS C1a, casting AS C1b, casting AS C2a, casting AS C2b, oldmov AS Ma, oldmov AS Mb WHERE A1.id = C1a.actorid AND A1.id = C1b.actorid AND A2.id = C2a.actorid AND A2.id = C2b.actorid AND C1a.movieid = C2a.movieid AND C1b.movieid = C2b.movieid AND C1a.ord = 1 AND C2b.ord = 1 AND C1a.movieid = Ma.id AND C1b.movieid = Mb.id AND A1.name < A2.name

ORDER BY A1.name, A2.name
