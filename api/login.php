<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $senha = $_POST['senha'] ?? '';

    if (empty($email) || empty($senha)) {
        echo json_encode(['status' => 'error', 'message' => 'Email ou senha não fornecidos']);
        exit;
    }

    $sql = "SELECT * FROM cadastro WHERE email = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    if ($user && $user['senha'] === $senha) {
        echo json_encode(['status' => 'success', 'message' => 'Login realizado com sucesso!']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'E-mail ou senha incorretos.']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Método de requisição inválido']);
}
?>
