CREATE TABLE email_notifications (
    user_id INT,
    content_type VARCHAR(20),
    sent_from VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
)