CREATE TABLE updates (
    update_id INT AUTO_INCREMENT PRIMARY KEY,
    message_subject VARCHAR (100),
    message_body TEXT,
    update_type VARCHAR(10),
    recipients_type VARCHAR(10),
    club_id INT,
    expiry DATETIME,
    FOREIGN KEY (club_id) REFERENCES clubs(club_id)
)