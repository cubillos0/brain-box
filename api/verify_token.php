<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require 'config.php';

try {
    $conn = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

// Verificar se o token foi fornecido no cabeçalho Authorization
$headers = apache_request_headers();
$authHeader = isset($headers['Authorization']) ? $headers['Authorization'] : null;

if ($authHeader) {
    // Extrair o token do cabeçalho
    list($token) = sscanf($authHeader, 'Bearer %s');

    if ($token) {
        // Verificar se o token está presente no banco de dados
        $sql = "SELECT * FROM tokens WHERE token = ?";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$token]);
        $tokenData = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($tokenData) {
            echo json_encode(['status' => 'success', 'message' => 'Token válido']);
            exit;
        }
    }
}

echo json_encode(['status' => 'error', 'message' => 'Token inválido ou ausente']);
?>
