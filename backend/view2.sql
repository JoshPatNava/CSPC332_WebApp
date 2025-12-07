USE cinema_db;

CREATE OR REPLACE VIEW CinemaAuditorium3D AS
SELECT
    c.name AS cinema_name,
    CONCAT(
        c.street_num, ' ', c.street, ', ',
        c.city, ', ', c.state, ' ', c.zip
    ) AS cinema_address,
    a.name AS auditorium_name,
    a.capacity AS capacity,
    a.supports_3d AS supports_3d
FROM Cinema c
JOIN Auditorium a ON c.cinema_id = a.cinema_id
ORDER BY c.name, a.name;
