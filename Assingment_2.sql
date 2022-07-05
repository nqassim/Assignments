/* Q1*/
SELECT albums.Title as AlbumName, artists.Name AS ArtistName
FROM albums
    JOIN artists
    ON albums.AlbumId = artists.ArtistId
    ORDER BY artists.Name;

/* Q2 */
SELECT artists.Name as ArtistName, COUNT(albums.ArtistId) AS AlbumCount, albums.Title AS AlbumName
FROM artists
JOIN albums
ON (artists.ArtistId = albums.ArtistId)
GROUP BY albums.Title
HAVING AlbumCount >= 1
ORDER BY albums.Title DESC;

/* Q3*/
SELECT artists.Name as ArtistName FROM artists
WHERE artists.ArtistId NOT IN (SELECT albums.ArtistId FROM albums);

/* Q4*/
SELECT artists.Name as ArtistName, COUNT(albums.ArtistId) AS numAlbums
FROM artists
JOIN albums
ON (artists.ArtistId = albums.ArtistId)
GROUP BY artists.Name
ORDER BY numAlbums DESC, artists.Name;


/* Q5 */
SELECT artists.Name as ArtistName, COUNT(albums.ArtistId) as numAlbums
FROM artists
JOIN albums
ON (artists.ArtistId = albums.ArtistId)
GROUP BY artists.Name
HAVING numAlbums >= 10
ORDER BY numAlbums DESC, artists.Name;

/* Q6 */
SELECT artists.Name as ArtistName, COUNT(albums.ArtistId) as numAlbums
FROM artists
JOIN albums
ON (artists.ArtistId = albums.ArtistId)
GROUP BY artists.Name
ORDER BY numAlbums DESC
LIMIT 3;

/* Q7 */
SELECT artists.Name as ArtistName, albums.Title As AlbumTitle ,tracks.Name as Track
FROM artists
JOIN tracks
JOIN albums
WHERE artists.Name = 'Santana' AND artists.ArtistId = albums.ArtistId  AND tracks.AlbumId = albums.AlbumId
ORDER BY TrackID;

/* Q8*/
SELECT employees.EmployeeId as 'Employee ID',
    (SELECT employees.FirstName || ' ' || employees.LastName) AS 'Empyloyee Name',
    employees.Title AS 'Empyloyee Title',
    employees.ReportsTo AS 'Manager ID',
    i.FirstName as 'Manager Name',
    i.Title as 'Manager Title'
    FROM employees
    JOIN employees AS i ON i.EmployeeId = employees.ReportsTo;

/* Q9 */
DROP VIEW IF EXISTS top_employees;

CREATE VIEW top_employees
AS
SELECT employees.EmployeeId as emp_id,
(SELECT employees.FirstName || ' ' ||  employees.LastName) AS emp_name,
COUNT(customers.CustomerId) as cust_count
FROM employees
JOIN customers
ON employees.EmployeeId = customers.SupportRepId
GROUP BY employees.FirstName;

SELECT * FROM top_employees;

SELECT (employees.FirstName || ' ' || employees.LastName) AS emp_name, (customers.FirstName || ' ' ||  customers.LastName) As cust_name
FROM employees
JOIN customers
WHERE employees.EmployeeId = customers.SupportRepId AND employees.EmployeeId=3
ORDER by cust_name;
/* obtained the appropriate employee id from the view */

/* Question 10 */

INSERT INTO media_types (Name) VALUES ("whatever");

CREATE TRIGGER prevent_mp3
BEFORE INSERT ON tracks
FOR EACH ROW
BEGIN
SELECT
CASE WHEN NEW.Name NOT LIKE "%MP3%"
THEN RAISE(ABORT, "CANNOT BE INSERTED")
END;
END;


/* Question 11 */

CREATE TABLE tracks_audit_log (
    operation TEXT,
    datetime DATE,
    username TEXT,
    old_value TEXT,
    new_value TEXT
);

CREATE TRIGGER tracks_audit
AFTER INSERT ON tracks
BEGIN
    INSERT INTO tracks_audit_log (operation, datetime, username, old_value, new_value)
    VALUES ('insert',DATE('now'),'admin',OLD.Title,NEW.Title);
END;

CREATE TRIGGER tracks_audit_update
AFTER UPDATE ON tracks
BEGIN
    INSERT INTO tracks_audit_log (operation, datetime, username, old_value, new_value)
    VALUES ('update',DATE('now'),'admin',OLD.Title,NEW.Title);
END;

CREATE TRIGGER tracks_audit_delete
AFTER DELETE ON tracks
BEGIN
    INSERT INTO tracks_audit_log (operation, datetime, username, old_value, new_value)
    VALUES ('delete',DATE('now'),'admin',OLD.Title,NEW.Title);
END;
