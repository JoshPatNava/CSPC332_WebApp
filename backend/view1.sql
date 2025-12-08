USE cinema_db;

CREATE OR REPLACE VIEW LongMoviesByGenre AS
SELECT
    g.genre_name       AS genre,
    c.name             AS cinema_name,
    a.name             AS auditorium_name,
    m.title            AS movie_title
FROM Movie m
JOIN MovieGenre mg ON m.movie_id = mg.movie_id
JOIN Genre g ON g.genre_id = mg.genre_id
JOIN Shows s ON s.movie_id = m.movie_id
JOIN Auditorium a ON a.auditorium_id = s.auditorium_id
JOIN Cinema c ON c.cinema_id = a.cinema_id
WHERE m.duration_minutes > 120
GROUP BY
    g.genre_name,
    c.name,
    a.name,
    m.title
ORDER BY
    g.genre_name,
    c.name,
    a.name,
    m.title;
