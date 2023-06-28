CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100),
    club_id INT,
    event_datetime DATETIME,
    cost DECIMAL(10, 2),
    contact_email VARCHAR(100),
    event_description TEXT,
    expiry DATETIME,
    FOREIGN KEY (club_id) REFERENCES clubs(club_id)
)