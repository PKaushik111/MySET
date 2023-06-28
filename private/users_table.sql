CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  user_type VARCHAR(15),
  given_name VARCHAR(100),
  last_name VARCHAR(100),
  username VARCHAR(50) UNIQUE,
  email VARCHAR(100) UNIQUE,
  password_hash VARCHAR(100)
);
