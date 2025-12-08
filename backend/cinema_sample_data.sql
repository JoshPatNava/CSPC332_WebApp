USE cinema_db;

-- ROLES 
INSERT INTO Role (role_id, role_name)
VALUES
(1, 'Theater Manager'),
(2, 'Technician'),
(3, 'Ticketing'),
(4, 'Concessions'),
(5, 'Usher')
ON DUPLICATE KEY UPDATE role_name = VALUES(role_name);

-- RATINGS
INSERT INTO Rating (rating_id, name)
VALUES
(1, 'G'),
(2, 'PG'),
(3, 'PG-13'),
(4, 'R')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- GENRES 
INSERT INTO Genre (genre_id, genre_name)
VALUES
(1, 'Action'),
(2, 'Animation'),
(3, 'Comedy'),
(4, 'Family'),
(5, 'Horror'),
(6, 'Thriller'),
(7, 'Drama'),
(8, 'Sci-Fi')
ON DUPLICATE KEY UPDATE genre_name = VALUES(genre_name);

-- CINEMAS
INSERT INTO Cinema (name, street_num, street, city, state, zip)
VALUES
('Downtown Cinema', '101', 'Main St', 'San Diego', 'CA', '92101'),
('Pacific Theatre', '555', 'Pacific Hwy', 'San Diego', 'CA', '92102'),
('Westfield Mall Cinema', '200', 'Fashion Valley Rd', 'San Diego', 'CA', '92108'),
('Harbor View Cineplex', '750', 'Harbor Dr', 'San Diego', 'CA', '92101'),
('Mission Valley Cinema', '1640', 'Camino Del Rio N', 'San Diego', 'CA', '92108');

-- AUDITORIUMS
INSERT INTO Auditorium (cinema_id, name, capacity, supports_3d, supports_imax)
VALUES
-- Downtown Cinema
(1, 'Auditorium A', 200, 1, 0),
(1, 'Auditorium B', 150, 0, 0),
(1, 'Auditorium C', 180, 1, 0),
-- Pacific Theatre
(2, 'Screen 1', 220, 1, 1),
(2, 'Screen 2', 100, 0, 0),
(2, 'Screen 3', 150, 1, 0),
-- Westfield Mall Cinema
(3, 'Theater 1', 180, 1, 0),
(3, 'Theater 2', 120, 0, 0),
(3, 'IMAX Theater', 300, 1, 1),
-- Harbor View Cineplex
(4, 'Hall A', 250, 1, 1),
(4, 'Hall B', 200, 1, 0),
(4, 'Hall C', 150, 0, 0),
(4, 'Hall D', 100, 0, 0),
-- Mission Valley Cinema
(5, 'Room 1', 175, 1, 0),
(5, 'Room 2', 175, 1, 0),
(5, 'Room 3', 125, 0, 0),
(5, 'VIP Room', 50, 1, 0);

-- EMPLOYEES
INSERT INTO Employee (FName, LName, phone, email, street_num, street, city, state, zip, password)
VALUES
('John', 'Doe', '6195551234', 'john@abccinema.com', '101', 'Main St', 'San Diego', 'CA', '92101', 'Password1!'),
('Sarah', 'Smith', '6195555678', 'sarah@abccinema.com', '225', 'Ocean Ave', 'San Diego', 'CA', '92102', 'SecurePass2@'),
('Mike', 'Johnson', '6195559012', 'mike@abccinema.com', '330', 'Harbor Dr', 'San Diego', 'CA', '92103', 'MikePass3#'),
('Emily', 'Davis', '6195553456', 'emily@abccinema.com', '445', 'Broadway', 'San Diego', 'CA', '92104', 'EmilyPass4$'),
('David', 'Wilson', '6195557890', 'david@abccinema.com', '560', 'Market St', 'San Diego', 'CA', '92105', 'DavidPass5%'),
('Jessica', 'Brown', '6195551111', 'jessica@abccinema.com', '789', 'First Ave', 'San Diego', 'CA', '92101', 'JessPass6^'),
('Robert', 'Taylor', '6195552222', 'robert@abccinema.com', '321', 'Second St', 'San Diego', 'CA', '92102', 'RobPass7&'),
('Amanda', 'Martinez', '6195553333', 'amanda@abccinema.com', '654', 'Third Ave', 'San Diego', 'CA', '92103', 'AmandaPass8*'),
('Chris', 'Anderson', '6195554444', 'chris@abccinema.com', '987', 'Fourth St', 'San Diego', 'CA', '92104', 'ChrisPass9!'),
('Lisa', 'Thomas', '6195555555', 'lisa@abccinema.com', '147', 'Fifth Ave', 'San Diego', 'CA', '92105', 'LisaPass10@');

-- EMPLOYEE ROLES
INSERT INTO EmployeeRole (employee_id, role_id)
VALUES
(1, 1),  -- John is Theater Manager
(2, 2),  -- Sarah is Technician
(3, 3),  -- Mike is Ticketing
(4, 4),  -- Emily is Concessions
(5, 5),  -- David is Usher
(6, 1),  -- Jessica is Theater Manager
(7, 2),  -- Robert is Technician
(8, 3),  -- Amanda is Ticketing
(9, 4),  -- Chris is Concessions
(10, 5); -- Lisa is Usher

-- WORKFOR (which cinema each employee works at)
INSERT INTO WorkFor (cinema_id, employee_id)
VALUES
(1, 1),  -- John at Downtown Cinema
(1, 3),  -- Mike at Downtown Cinema
(2, 2),  -- Sarah at Pacific Theatre
(2, 4),  -- Emily at Pacific Theatre
(3, 5),  -- David at Westfield Mall Cinema
(3, 6),  -- Jessica at Westfield Mall Cinema
(4, 7),  -- Robert at Harbor View Cineplex
(4, 8),  -- Amanda at Harbor View Cineplex
(5, 9),  -- Chris at Mission Valley Cinema
(5, 10); -- Lisa at Mission Valley Cinema

-- MOVIES
INSERT INTO Movie (title, description, year, duration_minutes, release_date, rating_id)
VALUES
('Oppenheimer', 'The story of J. Robert Oppenheimer and the development of the atomic bomb during World War II.', 2023, 180, '2023-07-21', 4),
('Dune: Part Two', 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.', 2024, 166, '2024-03-01', 3),
('Spider-Man: No Way Home', 'Peter Parker seeks help from Doctor Strange when his identity is revealed, leading to a multiverse adventure.', 2021, 148, '2021-12-17', 3),
('Inside Out 2', 'Riley enters puberty and experiences a new set of emotions that complicate her sense of self.', 2024, 96, '2024-06-14', 1),
('The Conjuring', 'Paranormal investigators Ed and Lorraine Warren work to help a family terrorized by a dark presence in their farmhouse.', 2013, 112, '2013-07-19', 4),
('A Quiet Place', 'A family must live in silence to avoid mysterious creatures that hunt by sound.', 2018, 90, '2018-04-06', 3),
('Barbie', 'Barbie suffers a crisis that leads her to question her world and her existence, embarking on a journey of self-discovery.', 2023, 114, '2023-07-21', 3),
('The Dark Knight', 'Batman faces the Joker, a criminal mastermind who wants to plunge Gotham City into anarchy.', 2008, 152, '2008-07-18', 3),
('Inception', 'A thief who steals corporate secrets through dream-sharing technology is given the task of planting an idea into a CEO mind.', 2010, 148, '2010-07-16', 3),
('Avatar: The Way of Water', 'Jake Sully and his family face new threats as they explore the oceanic regions of Pandora.', 2022, 192, '2022-12-16', 3),
('Frozen II', 'Elsa and Anna embark on a journey to discover the origin of Elsa powers and save their kingdom.', 2019, 103, '2019-11-22', 1),
('The Exorcist: Believer', 'Two girls mysteriously vanish and return with no memory of what happened, leading to a terrifying supernatural investigation.', 2023, 121, '2023-10-06', 4),
('Smile', 'After witnessing a bizarre traumatic incident, a therapist becomes haunted by a terrifying supernatural entity.', 2022, 115, '2022-09-30', 4),
('Knives Out', 'A detective investigates the death of a wealthy patriarch, uncovering secrets within his eccentric family.', 2019, 130, '2019-11-27', 3),
('Everything Everywhere All at Once', 'A middle-aged Chinese immigrant is swept up in an insane adventure where she must save the multiverse.', 2022, 139, '2022-03-25', 4),
('Top Gun: Maverick', 'After thirty years, Maverick is still pushing the envelope as a top naval aviator, training a group of graduates for a special mission.', 2022, 130, '2022-05-27', 3),
('The Super Mario Bros. Movie', 'Mario and Luigi embark on an adventure through the Mushroom Kingdom to rescue Princess Peach from Bowser.', 2023, 92, '2023-04-05', 1),
('Guardians of the Galaxy Vol. 3', 'The Guardians must protect Rocket while facing threats from his troubled past.', 2023, 150, '2023-05-05', 3),
('John Wick: Chapter 4', 'John Wick uncovers a path to defeating the High Table, but must face new enemies with powerful alliances.', 2023, 169, '2023-03-24', 4),
('Wonka', 'The story of how a young Willy Wonka met the Oompa-Loompas and became the renowned chocolate maker.', 2023, 116, '2023-12-15', 1);

-- MOVIE GENRES
INSERT INTO MovieGenre (movie_id, genre_id)
VALUES
(1, 7),  -- Oppenheimer = Drama
(1, 6),  -- Oppenheimer = Thriller
(2, 8),  -- Dune = Sci-Fi
(2, 1),  -- Dune = Action
(3, 1),  -- Spider-Man = Action
(3, 8),  -- Spider-Man = Sci-Fi
(4, 2),  -- Inside Out 2 = Animation
(4, 3),  -- Inside Out 2 = Comedy
(4, 4),  -- Inside Out 2 = Family
(5, 5),  -- Conjuring = Horror
(5, 6),  -- Conjuring = Thriller
(6, 5),  -- A Quiet Place = Horror
(6, 6),  -- A Quiet Place = Thriller
(7, 3),  -- Barbie = Comedy
(7, 4),  -- Barbie = Family
(8, 1),  -- Dark Knight = Action
(8, 6),  -- Dark Knight = Thriller
(8, 7),  -- Dark Knight = Drama
(9, 1),  -- Inception = Action
(9, 8),  -- Inception = Sci-Fi
(9, 6),  -- Inception = Thriller
(10, 8), -- Avatar 2 = Sci-Fi
(10, 1), -- Avatar 2 = Action
(11, 2), -- Frozen II = Animation
(11, 4), -- Frozen II = Family
(12, 5), -- Exorcist = Horror
(13, 5), -- Smile = Horror
(13, 6), -- Smile = Thriller
(14, 6), -- Knives Out = Thriller
(14, 3), -- Knives Out = Comedy
(14, 7), -- Knives Out = Drama
(15, 1), -- Everything Everywhere = Action
(15, 8), -- Everything Everywhere = Sci-Fi
(15, 3), -- Everything Everywhere = Comedy
(16, 1), -- Top Gun = Action
(16, 7), -- Top Gun = Drama
(17, 2), -- Mario = Animation
(17, 4), -- Mario = Family
(17, 3), -- Mario = Comedy
(18, 1), -- Guardians = Action
(18, 8), -- Guardians = Sci-Fi
(18, 3), -- Guardians = Comedy
(19, 1), -- John Wick = Action
(19, 6), -- John Wick = Thriller
(20, 4), -- Wonka = Family
(20, 3); -- Wonka = Comedy

-- SHOWTIMES 
INSERT INTO Shows (movie_id, auditorium_id, start_time, end_time, format)
VALUES
-- January 15, 2025
(1, 1, '2025-01-15 14:00:00', '2025-01-15 17:00:00', 'regular'),
(1, 4, '2025-01-15 18:00:00', '2025-01-15 21:00:00', '3D'),
(2, 2, '2025-01-15 15:00:00', '2025-01-15 17:46:00', 'regular'),
(2, 5, '2025-01-15 19:00:00', '2025-01-15 21:46:00', 'regular'),
(3, 3, '2025-01-15 16:00:00', '2025-01-15 18:28:00', '3D'),
(4, 6, '2025-01-15 11:00:00', '2025-01-15 12:36:00', 'regular'),
(4, 7, '2025-01-15 14:00:00', '2025-01-15 15:36:00', 'regular'),
(5, 8, '2025-01-15 21:00:00', '2025-01-15 22:52:00', 'regular'),
(6, 9, '2025-01-15 22:00:00', '2025-01-15 23:30:00', '3D'),

-- January 16, 2025
(7, 1, '2025-01-16 13:00:00', '2025-01-16 14:54:00', 'regular'),
(7, 10, '2025-01-16 16:00:00', '2025-01-16 17:54:00', '3D'),
(8, 2, '2025-01-16 18:00:00', '2025-01-16 20:32:00', 'regular'),
(9, 4, '2025-01-16 19:00:00', '2025-01-16 21:28:00', '3D'),
(10, 9, '2025-01-16 17:00:00', '2025-01-16 20:12:00', '3D'),
(11, 7, '2025-01-16 10:00:00', '2025-01-16 11:43:00', 'regular'),
(11, 8, '2025-01-16 13:00:00', '2025-01-16 14:43:00', 'regular'),
(12, 3, '2025-01-16 21:30:00', '2025-01-16 23:31:00', 'regular'),
(13, 5, '2025-01-16 22:00:00', '2025-01-16 23:55:00', 'regular'),

-- January 17, 2025
(14, 1, '2025-01-17 14:00:00', '2025-01-17 16:10:00', 'regular'),
(14, 11, '2025-01-17 18:00:00', '2025-01-17 20:10:00', 'regular'),
(15, 4, '2025-01-17 15:00:00', '2025-01-17 17:19:00', '3D'),
(16, 10, '2025-01-17 19:00:00', '2025-01-17 21:10:00', '3D'),
(17, 7, '2025-01-17 10:00:00', '2025-01-17 11:32:00', 'regular'),
(17, 8, '2025-01-17 12:00:00', '2025-01-17 13:32:00', 'regular'),
(17, 14, '2025-01-17 14:00:00', '2025-01-17 15:32:00', '3D'),
(18, 9, '2025-01-17 16:00:00', '2025-01-17 18:30:00', '3D'),
(19, 2, '2025-01-17 20:00:00', '2025-01-17 22:49:00', 'regular'),
(20, 6, '2025-01-17 11:00:00', '2025-01-17 12:56:00', 'regular'),

-- January 18, 2025 - Multiple showings for VIEW #3 testing
(1, 1, '2025-01-18 10:00:00', '2025-01-18 13:00:00', 'regular'),
(1, 2, '2025-01-18 13:30:00', '2025-01-18 16:30:00', 'regular'),
(1, 3, '2025-01-18 17:00:00', '2025-01-18 20:00:00', '3D'),
(1, 4, '2025-01-18 20:30:00', '2025-01-18 23:30:00', '3D'),
(2, 5, '2025-01-18 11:00:00', '2025-01-18 13:46:00', 'regular'),
(2, 6, '2025-01-18 14:00:00', '2025-01-18 16:46:00', 'regular'),
(2, 7, '2025-01-18 17:00:00', '2025-01-18 19:46:00', '3D'),
(2, 9, '2025-01-18 20:00:00', '2025-01-18 22:46:00', '3D'),
(3, 10, '2025-01-18 12:00:00', '2025-01-18 14:28:00', '3D'),
(3, 11, '2025-01-18 15:00:00', '2025-01-18 17:28:00', 'regular'),
(4, 8, '2025-01-18 10:00:00', '2025-01-18 11:36:00', 'regular'),
(4, 12, '2025-01-18 12:00:00', '2025-01-18 13:36:00', 'regular'),
(4, 13, '2025-01-18 14:00:00', '2025-01-18 15:36:00', 'regular'),
(4, 14, '2025-01-18 16:00:00', '2025-01-18 17:36:00', '3D'),

-- January 19, 2025
(5, 1, '2025-01-19 21:00:00', '2025-01-19 22:52:00', 'regular'),
(6, 2, '2025-01-19 22:00:00', '2025-01-19 23:30:00', 'regular'),
(7, 3, '2025-01-19 13:00:00', '2025-01-19 14:54:00', 'regular'),
(8, 4, '2025-01-19 17:00:00', '2025-01-19 19:32:00', '3D'),
(9, 5, '2025-01-19 18:00:00', '2025-01-19 20:28:00', 'regular'),
(10, 9, '2025-01-19 14:00:00', '2025-01-19 17:12:00', '3D'),
(11, 7, '2025-01-19 10:00:00', '2025-01-19 11:43:00', 'regular'),
(12, 6, '2025-01-19 22:00:00', '2025-01-19 23:51:00', 'regular'),

-- January 20, 2025
(13, 1, '2025-01-20 21:00:00', '2025-01-20 22:55:00', 'regular'),
(14, 2, '2025-01-20 14:00:00', '2025-01-20 16:10:00', 'regular'),
(15, 4, '2025-01-20 16:00:00', '2025-01-20 18:19:00', '3D'),
(16, 10, '2025-01-20 18:00:00', '2025-01-20 20:10:00', '3D'),
(17, 7, '2025-01-20 10:00:00', '2025-01-20 11:32:00', 'regular'),
(18, 9, '2025-01-20 15:00:00', '2025-01-20 17:30:00', '3D'),
(19, 3, '2025-01-20 20:00:00', '2025-01-20 22:49:00', 'regular'),
(20, 8, '2025-01-20 12:00:00', '2025-01-20 13:56:00', 'regular');

-- SEATS 
INSERT INTO Seat (auditorium_id, row_label, seat_number)
VALUES
-- Auditorium 1
(1, 'A', 1), (1, 'A', 2), (1, 'A', 3), (1, 'A', 4), (1, 'A', 5), (1, 'A', 6), (1, 'A', 7), (1, 'A', 8),
(1, 'B', 1), (1, 'B', 2), (1, 'B', 3), (1, 'B', 4), (1, 'B', 5), (1, 'B', 6), (1, 'B', 7), (1, 'B', 8),
(1, 'C', 1), (1, 'C', 2), (1, 'C', 3), (1, 'C', 4), (1, 'C', 5), (1, 'C', 6), (1, 'C', 7), (1, 'C', 8),
(1, 'D', 1), (1, 'D', 2), (1, 'D', 3), (1, 'D', 4), (1, 'D', 5), (1, 'D', 6), (1, 'D', 7), (1, 'D', 8),
-- Auditorium 2
(2, 'A', 1), (2, 'A', 2), (2, 'A', 3), (2, 'A', 4), (2, 'A', 5), (2, 'A', 6),
(2, 'B', 1), (2, 'B', 2), (2, 'B', 3), (2, 'B', 4), (2, 'B', 5), (2, 'B', 6),
(2, 'C', 1), (2, 'C', 2), (2, 'C', 3), (2, 'C', 4), (2, 'C', 5), (2, 'C', 6),
-- Auditorium 3
(3, 'A', 1), (3, 'A', 2), (3, 'A', 3), (3, 'A', 4), (3, 'A', 5), (3, 'A', 6), (3, 'A', 7),
(3, 'B', 1), (3, 'B', 2), (3, 'B', 3), (3, 'B', 4), (3, 'B', 5), (3, 'B', 6), (3, 'B', 7),
(3, 'C', 1), (3, 'C', 2), (3, 'C', 3), (3, 'C', 4), (3, 'C', 5), (3, 'C', 6), (3, 'C', 7),
-- Auditorium 4 (IMAX)
(4, 'A', 1), (4, 'A', 2), (4, 'A', 3), (4, 'A', 4), (4, 'A', 5), (4, 'A', 6), (4, 'A', 7), (4, 'A', 8), (4, 'A', 9), (4, 'A', 10),
(4, 'B', 1), (4, 'B', 2), (4, 'B', 3), (4, 'B', 4), (4, 'B', 5), (4, 'B', 6), (4, 'B', 7), (4, 'B', 8), (4, 'B', 9), (4, 'B', 10),
(4, 'C', 1), (4, 'C', 2), (4, 'C', 3), (4, 'C', 4), (4, 'C', 5), (4, 'C', 6), (4, 'C', 7), (4, 'C', 8), (4, 'C', 9), (4, 'C', 10),
-- Auditorium 5
(5, 'A', 1), (5, 'A', 2), (5, 'A', 3), (5, 'A', 4), (5, 'A', 5),
(5, 'B', 1), (5, 'B', 2), (5, 'B', 3), (5, 'B', 4), (5, 'B', 5),
-- Auditorium 6
(6, 'A', 1), (6, 'A', 2), (6, 'A', 3), (6, 'A', 4), (6, 'A', 5), (6, 'A', 6),
(6, 'B', 1), (6, 'B', 2), (6, 'B', 3), (6, 'B', 4), (6, 'B', 5), (6, 'B', 6),
-- Auditorium 7
(7, 'A', 1), (7, 'A', 2), (7, 'A', 3), (7, 'A', 4), (7, 'A', 5), (7, 'A', 6), (7, 'A', 7),
(7, 'B', 1), (7, 'B', 2), (7, 'B', 3), (7, 'B', 4), (7, 'B', 5), (7, 'B', 6), (7, 'B', 7),
-- Auditorium 8
(8, 'A', 1), (8, 'A', 2), (8, 'A', 3), (8, 'A', 4), (8, 'A', 5),
(8, 'B', 1), (8, 'B', 2), (8, 'B', 3), (8, 'B', 4), (8, 'B', 5),
-- Auditorium 9 (IMAX)
(9, 'A', 1), (9, 'A', 2), (9, 'A', 3), (9, 'A', 4), (9, 'A', 5), (9, 'A', 6), (9, 'A', 7), (9, 'A', 8), (9, 'A', 9), (9, 'A', 10), (9, 'A', 11), (9, 'A', 12),
(9, 'B', 1), (9, 'B', 2), (9, 'B', 3), (9, 'B', 4), (9, 'B', 5), (9, 'B', 6), (9, 'B', 7), (9, 'B', 8), (9, 'B', 9), (9, 'B', 10), (9, 'B', 11), (9, 'B', 12),
(9, 'C', 1), (9, 'C', 2), (9, 'C', 3), (9, 'C', 4), (9, 'C', 5), (9, 'C', 6), (9, 'C', 7), (9, 'C', 8), (9, 'C', 9), (9, 'C', 10), (9, 'C', 11), (9, 'C', 12),
-- Auditorium 10 (IMAX)
(10, 'A', 1), (10, 'A', 2), (10, 'A', 3), (10, 'A', 4), (10, 'A', 5), (10, 'A', 6), (10, 'A', 7), (10, 'A', 8), (10, 'A', 9), (10, 'A', 10),
(10, 'B', 1), (10, 'B', 2), (10, 'B', 3), (10, 'B', 4), (10, 'B', 5), (10, 'B', 6), (10, 'B', 7), (10, 'B', 8), (10, 'B', 9), (10, 'B', 10),
-- Auditorium 11-17 (simplified)
(11, 'A', 1), (11, 'A', 2), (11, 'A', 3), (11, 'A', 4), (11, 'A', 5), (11, 'A', 6), (11, 'A', 7), (11, 'A', 8),
(11, 'B', 1), (11, 'B', 2), (11, 'B', 3), (11, 'B', 4), (11, 'B', 5), (11, 'B', 6), (11, 'B', 7), (11, 'B', 8),
(12, 'A', 1), (12, 'A', 2), (12, 'A', 3), (12, 'A', 4), (12, 'A', 5), (12, 'A', 6),
(12, 'B', 1), (12, 'B', 2), (12, 'B', 3), (12, 'B', 4), (12, 'B', 5), (12, 'B', 6),
(13, 'A', 1), (13, 'A', 2), (13, 'A', 3), (13, 'A', 4), (13, 'A', 5),
(13, 'B', 1), (13, 'B', 2), (13, 'B', 3), (13, 'B', 4), (13, 'B', 5),
(14, 'A', 1), (14, 'A', 2), (14, 'A', 3), (14, 'A', 4), (14, 'A', 5), (14, 'A', 6), (14, 'A', 7),
(14, 'B', 1), (14, 'B', 2), (14, 'B', 3), (14, 'B', 4), (14, 'B', 5), (14, 'B', 6), (14, 'B', 7),
(15, 'A', 1), (15, 'A', 2), (15, 'A', 3), (15, 'A', 4), (15, 'A', 5), (15, 'A', 6), (15, 'A', 7),
(15, 'B', 1), (15, 'B', 2), (15, 'B', 3), (15, 'B', 4), (15, 'B', 5), (15, 'B', 6), (15, 'B', 7),
(16, 'A', 1), (16, 'A', 2), (16, 'A', 3), (16, 'A', 4), (16, 'A', 5),
(16, 'B', 1), (16, 'B', 2), (16, 'B', 3), (16, 'B', 4), (16, 'B', 5),
(17, 'A', 1), (17, 'A', 2), (17, 'A', 3), (17, 'A', 4),
(17, 'B', 1), (17, 'B', 2), (17, 'B', 3), (17, 'B', 4);
