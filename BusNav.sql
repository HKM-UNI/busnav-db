CREATE DATABASE busnav;

USE busnav;

CREATE TABLE
    bus_stop (
        id INT AUTO_INCREMENT PRIMARY KEY
        , name VARCHAR(32)
        , latitude DECIMAL(9,6) NOT NULL
        , longitude DECIMAL(9,6) NOT NULL
    );

CREATE TABLE
    bus (
        id INT AUTO_INCREMENT PRIMARY KEY
        , number SMALLINT UNIQUE NOT NULL
        , average_time_minutes TINYINT UNSIGNED
        , start_terminal INT
        , end_terminal INT
        , map_data_url varchar(150)
        , FOREIGN KEY (start_terminal)
            REFERENCES bus_stop(id)
            ON DELETE SET NULL
        , FOREIGN KEY (end_terminal)
            REFERENCES bus_stop(id)
            ON DELETE SET NULL
    );

CREATE TABLE
    bus_cooperative (
        id INT AUTO_INCREMENT PRIMARY KEY
        , name VARCHAR(32) UNIQUE NOT NULL
        , description VARCHAR(72)
    );

CREATE TABLE
    cooperative_buses (
        id INT AUTO_INCREMENT PRIMARY KEY
        , cooperative_id INT NOT NULL
        , bus_id INT NOT NULL
        , FOREIGN KEY (cooperative_id)
            REFERENCES bus_cooperative(id)
            ON DELETE CASCADE
        , FOREIGN KEY (bus_id)
            REFERENCES bus(id)
            ON DELETE CASCADE
    );

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
