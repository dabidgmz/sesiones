//bd de ejemplo 
use sesiones;


CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    gmail VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

INSERT INTO roles (role_name) VALUES ('admin');
INSERT INTO roles (role_name) VALUES ('user');


INSERT INTO users (name, lastname, gmail, password, role_id) VALUES ('John', 'Doe', 'teste01@gmail.com', '12345678', 1);
INSERT INTO users (name, lastname, gmail, password, role_id) VALUES ('Jane', 'Smith', 'teste02@gmail.com', '12345678', 2);

