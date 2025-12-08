USE cinema_db;

-- ROLES
INSERT INTO Role (role_id, role_name)
VALUES
(1, 'Manager'),
(2, 'Staff')
ON DUPLICATE KEY UPDATE role_name = VALUES(role_name);

-- EMPLOYEES
INSERT INTO Employee (FName, LName, phone, email, street_num, street, city, state, zip, password)
VALUES
('John', 'Doe',  '1234567890', 'john@example.com',  '101', 'Main St',   'San Diego', 'CA', '92101', 'Password1!'),
('Sarah', 'Smith','0987654321', 'sarah@example.com', '225', 'Ocean Ave', 'San Diego', 'CA', '92101', 'SecurePass2@');

-- EMPLOYEE ROLES
INSERT INTO EmployeeRole (employee_id, role_id)
VALUES
(1, 1),  -- John is Manager
(2, 2);  -- Sarah is Staff

-- CINEMAS
INSERT INTO Cinema (name, street_num, street, city, state, zip)
VALUES
('Downtown Cinema', '101', 'Main St',    'San Diego', 'CA', '92101'),
('Pacific Theatre', '555', 'Pacific Hwy','San Diego', 'CA', '92101');

-- AUDITORIUMS
INSERT INTO Auditorium (cinema_id, name, capacity, supports_3d, supports_imax)
VALUES
(1, 'Auditorium A', 200, 1, 0),
(1, 'Auditorium B', 150, 0, 0),
(2, 'Auditorium 1', 220, 1, 1),
(2, 'Auditorium 2', 100, 0, 0);

-- RATINGS
INSERT INTO Rating (rating_id, name)
VALUES
(1, 'PG-13'),
(2, 'R')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- GENRES
INSERT INTO Genre (genre_id, genre_name)
VALUES
(1, 'Drama'),
(2, 'Sci-Fi'),
(3, 'Action')
ON DUPLICATE KEY UPDATE genre_name = VALUES(genre_name);

-- MOVIES
INSERT INTO Movie (title, description, year, duration_minutes, release_date, rating_id)
VALUES
('Oppenheimer',
 'The story of J Robert Oppenheimer and development of nuclear weapons.',
 2023, 180, '2023-07-21', 2),
('Dune: Part Two',
 'Paul Atreides unites with Chani and the Fremen while seeking revenge.',
 2024, 166, '2024-03-01', 1),
('Spider-Man: No Way Home',
 'Peter Parker faces consequences of his identity being revealed.',
 2021, 148, '2021-12-17', 1);

-- MOVIE GENRE
INSERT INTO MovieGenre (movie_id, genre_id)
VALUES
(1, 1),  -- Oppenheimer = Drama
(2, 2),  -- Dune = Sci-Fi
(3, 3);  -- Spider-Man = Action

-- SHOWTIMES
INSERT INTO Shows (movie_id, auditorium_id, start_time, end_time, format)
VALUES
(1, 1, '2025-01-15 18:00:00', '2025-01-15 21:00:00', 'regular'),
(2, 2, '2025-01-15 19:00:00', '2025-01-15 21:46:00', '3D'),
(3, 3, '2025-01-16 17:30:00', '2025-01-16 19:58:00', 'regular'),
(1, 4, '2025-01-16 18:30:00', '2025-01-16 21:30:00', 'regular'),
(2, 3, '2025-01-16 21:00:00', '2025-01-16 23:46:00', '3D'),
(3, 4, '2025-01-17 15:00:00', '2025-01-17 17:28:00', 'regular'),
(1, 1, '2025-01-18 10:00:00', '2025-01-18 13:00:00', '3D'),
(1, 2, '2025-01-18 13:30:00', '2025-01-18 16:30:00', 'regular'),
(1, 3, '2025-01-18 17:00:00', '2025-01-18 20:00:00', 'regular'),
(1, 4, '2025-01-18 20:30:00', '2025-01-18 23:30:00', 'regular');


-- SEATS
INSERT INTO Seat (auditorium_id, row_label, seat_number)
VALUES
(1, 'A', 1), (1, 'A', 2), (1, 'A', 3),
(1, 'B', 1), (1, 'B', 2), (1, 'B', 3),

(2, 'A', 1), (2, 'A', 2), (2, 'A', 3),
(2, 'B', 1), (2, 'B', 2), (2, 'B', 3),

(3, 'A', 1), (3, 'A', 2), (3, 'A', 3),
(4, 'A', 1), (4, 'A', 2), (4, 'A', 3);

-- WORKFOR
INSERT INTO WorkFor (cinema_id, employee_id)
VALUES
(1, 1),   -- John works at Downtown Cinema
(2, 2);   -- Sarah works at Pacific Theatre
