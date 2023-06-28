CREATE TABLE linked_account (
    user_id INT,
    linked_account_id INT,
    linked_account_password VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
)