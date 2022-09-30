--@block Creating new Database
CREATE DATABASE record_company;
USE record_company;
--@block Creating new tables
CREATE TABLE bands (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE albums (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    release_year INT,
    band_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (band_id) REFERENCES bands(id)
);
CREATE TABLE songs (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    length FLOAT NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (album_id) REFERENCES albums(id)
);
--@block Using record_company Database;
USE record_company;
--@block   Changing name as Band Name
SELECT bands.name AS 'Band Name'
FROM bands;
--@block Select the oldest album
SELECT *
FROM albums
WHERE release_year IS NOT NULL
ORDER BY release_year
LIMIT 1;
--@block Get all Bands that have albums
SELECT bands.name AS 'Band Name'
FROM bands
    LEFT JOIN albums ON bands.id = albums.band_id
GROUP BY albums.band_id
HAVING COUNT(albums.id) = 0;
--@BLOCK Get the Longest Album
SELECT albums.name AS NAME,
    albums.release_year AS 'Release Year',
    SUM(songs.length) AS 'Duration'
FROM albums
    JOIN songs on albums.id = songs.album_id
GROUP BY songs.album_id
ORDER BY Duration DESC;
--@block Update the Release Year of the Album with no Year
UPDATE albums
SET release_year = 1986
WHERE id = 4;
--@block Lets see updated information
SELECT *
FROM albums --@block Insert a record for your favorite Band and One of Their Albums
INSERT INTO bands(name)
VALUES ('Dua Lipa');
INSERT INTO albums (name, release_year, band_id)
VALUES ('Dont start now', 2020, 8) --@block
select *
from bands --@block deleting added information from albums
DELETE FROM albums
WHERE id = 8 --@block deleting added information from bands
DELETE FROM bands
WHERE id = 9 --@block get the average length of all songs
SELECT AVG(songs.length) as 'Average song duration'
FROM songs;
--@block Select the longest Song Off each Album
SELECT albums.name AS album,
    albums.release_year AS 'Release Year',
    MAX(songs.length) AS 'Duration'
FROM albums
    JOIN songs ON albums.id = songs.album_id
GROUP BY songs.album_id;
--@block Get the number of songs for each Band
SELECT bands.name as BAND,
    COUNT(songs.id) AS 'Number of Songs'
FROM bands
    JOIN albums ON bands.id = albums.band_id
    JOIN songs ON albums.id = songs.album_id
GROUP BY albums.band_id;