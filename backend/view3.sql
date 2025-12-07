FrequentlyShownMovies VIEW
Create a VIEW listing all movies shown more than 3 times per day

USE cinema_db;

CREATE OR REPLACE VIEW ThreeTimeMovies AS
SELECT 
    m.title AS movie_title,
    DATE(s.start_time) AS show_date,
    COUNT(*) AS times_shown_that_day
FROM Shows s
JOIN Movie m ON s.movie_id = m.movie_id
GROUP BY m.movie_id, DATE(s.start_time)
HAVING times_shown_that_day > 3
ORDER BY show_date DESC, times_shown_that_day DESC;
