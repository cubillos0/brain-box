<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require 'config.php'; // Inclui o arquivo de configuração do banco de dados

global $conn;

try {
    $conn = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

// Recebe os dados da requisição GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Recebe o token de autenticação do cabeçalho Authorization
    $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
    if (empty($authHeader)) {
        // Token não fornecido, retorna um erro
        echo json_encode(['status' => 'error', 'message' => 'Token de autenticação não fornecido']);
        exit;
    }

    // Extrai o token do cabeçalho de autorização
    $token = str_replace('Bearer ', '', $authHeader);

    // Prepara a consulta SQL para verificar se o token existe no banco de dados
    $sql = "SELECT user_id FROM tokens WHERE token = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$token]);

    // Verifica se o token foi encontrado no banco de dados
    if ($stmt->rowCount() > 0) {
        // Retorna o ID do usuário associado ao token
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        $userId = $row['user_id'];
    } else {
        // Retorna um erro se o token não foi encontrado
        echo json_encode(['status' => 'error', 'message' => 'Token de autenticação inválido']);
        exit;
    }

    // Prepara a consulta SQL para buscar o nome da caixinha associada ao usuário
    $sql = "SELECT nome FROM caixinha WHERE usuario_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$userId]);

    // Verifica se a caixinha foi encontrada
    if ($stmt->rowCount() > 0) {
        $caixinha = $stmt->fetch(PDO::FETCH_ASSOC);
        echo json_encode(['status' => 'success', 'caixinha' => $caixinha]);
    } else {
        // Retorna uma mensagem de erro caso a caixinha não seja encontrada
        echo json_encode(['status' => 'error', 'message' => 'Nenhuma caixinha encontrada para este usuário']);
    }
}

// Fecha a conexão com o banco de dados
$conn = null;
?>
