USE prototype_db;

CREATE TABLE users (
    user_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_name VARCHAR(256) NOT NULL,
    email_address VARCHAR(256) NOT NULL,
    user_password VARCHAR(1024) NOT NULL
);

CREATE TABLE login_sessions (
    login_session_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    session_start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    session_end_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valid_falg ENUM('true', 'false') DEFAULT 'true',
    FOREIGN KEY user_id(user_id) REFERENCES users(user_id)
);

CREATE TABLE attribute_sets (
    attribute_set_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    owner_id INT UNSIGNED NOT NULL,
    attribute_set_name VARCHAR(256) NOT NULL,
    FOREIGN KEY owner_id(owner_id) REFERENCES users(user_id)
);

CREATE TABLE attributes (
    attribute_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    attribute_set_id INT UNSIGNED NOT NULL,
    attribute_name VARCHAR(256) NOT NULL,
    FOREIGN KEY attribute_set_id(attribute_set_id) REFERENCES attribute_sets(attribute_set_id)
);

CREATE TABLE categories (
    category_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    owner_id INT UNSIGNED NOT NULL,
    attribute_set_id INT UNSIGNED NOT NULL,
    parernt_category_id INT UNSIGNED,
    category_name VARCHAR(256) NOT NULL,
    lowest_level_category_flag ENUM('true', 'false') DEFAULT 'false' NOT NULL,
    full_category_phrase VARCHAR(1024) NOT NULL,
    FOREIGN KEY owner_id(owner_id) REFERENCES users(user_id),
    FOREIGN KEY attribute_set_id(attribute_set_id) REFERENCES attribute_sets(attribute_set_id)
);

CREATE TABLE files (
    file_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    lowest_level_category_id INT UNSIGNED NOT NULL,
    file_name VARCHAR(1024) NOT NULL,
    file_path VARCHAR(1024) NOT NULL,
    FOREIGN KEY lowest_level_category_id(lowest_level_category_id) REFERENCES categories(category_id)
);

CREATE TABLE descriptions (
    description_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
    file_id INT UNSIGNED NOT NULL,
    attribute_id INT UNSIGNED NOT NULL,
    content VARCHAR(2048),
    FOREIGN KEY file_id(file_id) REFERENCES files(file_id),
    FOREIGN KEY attribute_id(attribute_id) REFERENCES attributes(attribute_id)
);