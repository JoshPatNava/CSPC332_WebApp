CREATE DATABASE IF NOT EXISTS cinema_db;
USE cinema_db;

CREATE TABLE Address (
  address_id INT AUTO_INCREMENT PRIMARY KEY,
  street_num VARCHAR(20),
  street VARCHAR(255) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100) NOT NULL,
  zip VARCHAR(10) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP -- ?
);

CREATE TABLE Cinema (
  cinema_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (address_id) REFERENCES Address(address_id)
);

CREATE TABLE Role (
  role_id INT AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(100) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Employee (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  cinema_id INT NOT NULL,
  address_id INT NOT NULL,
  FName VARCHAR(100) NOT NULL,
  LName VARCHAR(100) NOT NULL,
  Phone VARCHAR(20),
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id),
  FOREIGN KEY (address_id) REFERENCES Address(address_id)
);

CREATE TABLE EmployeeRole (
  employee_id INT NOT NULL,
  role_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (employee_id, role_id),
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
  FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

CREATE TABLE Auditorium (
  auditorium_id INT AUTO_INCREMENT PRIMARY KEY,
  cinema_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  capacity INT NOT NULL,
  supports_3d BOOLEAN DEFAULT FALSE,
  supports_imax BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id)
);

CREATE TABLE Seat (
  seat_id INT AUTO_INCREMENT PRIMARY KEY,
  auditorium_id INT NOT NULL,
  row_label VARCHAR(5) NOT NULL,
  seat_number INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (auditorium_id, row_label, seat_number),
  FOREIGN KEY (auditorium_id) REFERENCES Auditorium(auditorium_id)
);

-- Note: i have genre_id in movie table instead of the other way around,
-- the genre table in entity and relational are a bit different i think
CREATE TABLE Genre (
  genre_id INT AUTO_INCREMENT PRIMARY KEY,
  genre_name VARCHAR(100) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Movie (
  movie_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description VARCHAR(500),
  year INT,
  duration_minutes INT,
  rating VARCHAR(10),
  release_date DATE,
  genre_id INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);


CREATE TABLE Showtime (
  showtime_id INT AUTO_INCREMENT PRIMARY KEY,
  auditorium_id INT NOT NULL,
  movie_id INT NOT NULL,
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  format VARCHAR(50),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (auditorium_id) REFERENCES Auditorium(auditorium_id),
  FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);