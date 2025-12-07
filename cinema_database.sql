CREATE DATABASE IF NOT EXISTS cinema_db;
USE cinema_db;


CREATE TABLE Cinema (
  cinema_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  street_num VARCHAR(20),
  street VARCHAR(255) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100) NOT NULL,
  zip VARCHAR(10) NOT NULL
);

CREATE TABLE Role (
  role_id INT AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Rating (
  rating_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE Genre (
  genre_id INT AUTO_INCREMENT PRIMARY KEY,
  genre_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Employee (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  FName VARCHAR(100) NOT NULL,
  LName VARCHAR(100) NOT NULL,
  phone VARCHAR(20),
  email VARCHAR(255) NOT NULL UNIQUE,
  street_num VARCHAR(20),
  street VARCHAR(255) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100) NOT NULL,
  zip VARCHAR(10) NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE EmployeeRole (
  employee_id INT NOT NULL,
  role_id INT NOT NULL,
  PRIMARY KEY (employee_id, role_id),
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
  FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

CREATE TABLE WorkFor (
  cinema_id INT NOT NULL,
  employee_id INT NOT NULL,
  PRIMARY KEY (cinema_id, employee_id),
  FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id),
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Auditorium (
  auditorium_id INT AUTO_INCREMENT PRIMARY KEY,
  cinema_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  capacity INT NOT NULL,
  supports_3d BOOLEAN DEFAULT FALSE,
  supports_imax BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id)
);

CREATE TABLE Seat (
  seat_id INT AUTO_INCREMENT PRIMARY KEY,
  auditorium_id INT NOT NULL,
  row_label VARCHAR(5) NOT NULL,
  seat_number INT NOT NULL,
  UNIQUE (auditorium_id, row_label, seat_number),
  FOREIGN KEY (auditorium_id) REFERENCES Auditorium(auditorium_id)
);

CREATE TABLE Movie (
  movie_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description VARCHAR(500),
  year INT,
  duration_minutes INT,
  release_date DATE,
  rating_id INT,
  FOREIGN KEY (rating_id) REFERENCES Rating(rating_id)
);

CREATE TABLE MovieGenre (
  movie_id INT NOT NULL,
  genre_id INT NOT NULL,
  PRIMARY KEY(movie_id, genre_id),
  FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
  FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

CREATE TABLE Shows (
  show_id INT AUTO_INCREMENT PRIMARY KEY,
  movie_id INT NOT NULL,
  auditorium_id INT NOT NULL,
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  format VARCHAR(10),
  FOREIGN KEY (auditorium_id) REFERENCES Auditorium(auditorium_id),
  FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);
