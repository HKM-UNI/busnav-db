CREATE DATABASE busnav;

USE busnav;

CREATE TABLE
    bus_cooperative (
        id INT AUTO_INCREMENT PRIMARY KEY
        , name VARCHAR(50) UNIQUE NOT NULL
        , description VARCHAR(150)
    );

CREATE TABLE
    bus (
        id INT AUTO_INCREMENT PRIMARY KEY
        , number SMALLINT UNIQUE NOT NULL
        , cooperative_id INT
        , average_time_minutes TINYINT UNSIGNED
        , start_terminal INT
        , end_terminal INT
        , FOREIGN KEY (cooperative_id)
            REFERENCES bus_cooperative(id)
            ON DELETE SET NULL
    );

CREATE TABLE
    bus_path (
        id INT AUTO_INCREMENT PRIMARY KEY
        , bus_id INT
        , path LINESTRING NOT NULL
        , backward BIT NOT NULL DEFAULT 0
        , FOREIGN KEY (bus_id)
            REFERENCES bus(id)
            ON DELETE CASCADE
    );

CREATE TABLE
    bus_stop (
        id INT AUTO_INCREMENT PRIMARY KEY
        , bus_id INT
        , name VARCHAR(64)
        , location POINT NOT NULL
        , FOREIGN KEY (bus_id)
            REFERENCES bus(id)
            ON DELETE CASCADE
    );

ALTER TABLE bus
ADD CONSTRAINT fk_st_terminal
FOREIGN KEY (start_terminal)
REFERENCES bus_stop(id)
ON DELETE SET NULL;

ALTER TABLE bus
ADD CONSTRAINT fk_ed_terminal
FOREIGN KEY (end_terminal)
REFERENCES bus_stop(id)
ON DELETE SET NULL;


CREATE TABLE
    bus_driver (
        id INT AUTO_INCREMENT PRIMARY KEY
        , name VARCHAR(32) NOT NULL
    );

CREATE TABLE
    bus_drivers (
        id INT AUTO_INCREMENT PRIMARY KEY
        , bus_id INT NOT NULL
        , driver_id INT NOT NULL
        , FOREIGN KEY (bus_id)
            REFERENCES bus(id)
            ON DELETE CASCADE
        , FOREIGN KEY (driver_id)
            REFERENCES bus_driver(id)
            ON DELETE CASCADE
    );
