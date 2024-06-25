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

    if ($user && $password === $user['password']) {
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
