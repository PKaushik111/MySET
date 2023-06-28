CREATE TABLE club_managers (
    manager_id INT AUTO_INCREMENT PRIMARY KEY,
    club_id INT,
    user_id INT,
    FOREIGN KEY (club_id) REFERENCES clubs(club_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
)