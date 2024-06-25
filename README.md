# Práctica de Login con PHP y MySQL

## Descripción
Esta práctica muestra cómo implementar un sistema de login básico utilizando PHP y MySQL. Incluye la creación de las tablas necesarias en la base de datos, la configuración de la conexión a la base de datos en PHP, la creación de un formulario de login con Bootstrap y el manejo de sesiones para autenticar usuarios y redirigirlos según su rol. Además, se explica cómo implementar la funcionalidad de logout.

![Login](images/login.png)

## Requisitos
- Servidor web con soporte para PHP (por ejemplo, Apache)
- Servidor MySQL
- Visual Studio Code (u otro editor de texto)
- Extensión SQL Tools para Visual Studio Code (opcional)

## Pasos Realizados

### 1. Creación de la Base de Datos y Tablas en MySQL
Primero, creamos un archivo SQL (`schema.sql`) para definir las tablas `users` y `roles` en la base de datos `sesiones`.

sql
-- Crear la tabla de roles
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

-- Insertar roles iniciales
INSERT INTO roles (role_name) VALUES ('Admin', 'User');

-- Crear la tabla de usuarios
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    gmail VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- Insertar un usuario de ejemplo con contraseña hasheada
-- Usar password_hash en PHP para obtener el hash de la contraseña '12345678'
INSERT INTO users (name, lastname, gmail, password, role_id) 
VALUES ('John', 'Doe', 'teste01@gmail.com', '$2y$10$eR2e0E1eqE/ZKwU0.kxjG.OPsnOBcDpDZ8RBRN9x/ZW4mD5BPIhX.', 1);


###2 Manejo del Login en PHP
<?php
session_start();
require_once 'conexion.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $gmail = $_POST['gmail'];
    $password = $_POST['password'];

    $conn = new Conexion();
    $pdo = $conn->pdo;

    $stmt = $pdo->prepare('SELECT * FROM users WHERE gmail = :gmail');
    $stmt->bindParam(':gmail', $gmail);
    $stmt->execute();
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    // Verificación de contraseña hasheada
    if ($user && password_verify($password, $user['password'])) {
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['role_id'] = $user['role_id'];
        if ($user['role_id'] == 1) {
            header('Location: adminview.php');
        } else {
            header('Location: userview.php');
        }
        exit;
    } else {
        $_SESSION['error_message'] = "Credenciales incorrectas";
        header('Location: loginview.php');
        exit;
    }
}
?>
###3  Implementar Logout
<?php
session_start();
session_unset();
session_destroy();
header('Location: loginview.php');
exit;
?>
