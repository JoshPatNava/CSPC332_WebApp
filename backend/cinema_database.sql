DROP DATABASE IF EXISTS cinema_db;
CREATE DATABASE cinema_db;
USE cinema_db;

CREATE TABLE Cinema (
  cinema_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  street_num VARCHAR(20) NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100) NOT NULL,
  zip VARCHAR(10) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Role (
  role_id INT AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(100) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Rating (
  rating_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Genre (
  genre_id INT AUTO_INCREMENT PRIMARY KEY,
  genre_name VARCHAR(100) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Employee (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  FName VARCHAR(100) NOT NULL,
  LName VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  street_num VARCHAR(20) NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100) NOT NULL,
  zip VARCHAR(10) NOT NULL,
  password VARCHAR(255) NOT NULL,
  CHECK (CHAR_LENGTH(password) >= 8),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE EmployeeRole (
  employee_id INT NOT NULL,
  role_id INT NOT NULL,
  PRIMARY KEY (employee_id, role_id),
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
  FOREIGN KEY (role_id) REFERENCES Role(role_id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE WorkFor (
  cinema_id INT NOT NULL,
  employee_id INT NOT NULL,
  PRIMARY KEY (cinema_id, employee_id),
  FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id),
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Auditorium (
  auditorium_id INT AUTO_INCREMENT PRIMARY KEY,
  cinema_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  capacity INT NOT NULL,
  supports_3d BOOLEAN NOT NULL DEFAULT FALSE,
  supports_imax BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Seat (
  seat_id INT AUTO_INCREMENT PRIMARY KEY,
  auditorium_id INT NOT NULL,
  row_label VARCHAR(5) NOT NULL,
  seat_number INT NOT NULL,
  UNIQUE (auditorium_id, row_label, seat_number),
  FOREIGN KEY (auditorium_id) REFERENCES Auditorium(auditorium_id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Movie (
  movie_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description VARCHAR(500) NOT NULL,
  year INT NOT NULL,
  duration_minutes INT NOT NULL,
  release_date DATE NOT NULL,
  rating_id INT NOT NULL,
  FOREIGN KEY (rating_id) REFERENCES Rating(rating_id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE MovieGenre (
  movie_id INT NOT NULL,
  genre_id INT NOT NULL,
  PRIMARY KEY(movie_id, genre_id),
  FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
  FOREIGN KEY (genre_id) REFERENCES Genre(genre_id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Shows (
  show_id INT AUTO_INCREMENT PRIMARY KEY,
  movie_id INT NOT NULL,
  auditorium_id INT NOT NULL,
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  format ENUM('regular', '3D') NOT NULL DEFAULT 'regular',
  FOREIGN KEY (auditorium_id) REFERENCES Auditorium(auditorium_id),
  FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);