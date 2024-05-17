<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require 'config.php'; // Inclui o arquivo de configuração do banco de dados

// Função para verificar o token de autenticação
function verifyAuthToken($token) {
    
    global $conn;

    // Prepara a consulta SQL para verificar se o token existe no banco de dados
    $sql = "SELECT user_id FROM tokens WHERE token = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$token]);

    // Verifica se o token foi encontrado no banco de dados
    if ($stmt->rowCount() > 0) {
        // Retorna o ID do usuário associado ao token
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row['user_id'];
    } else {
        // Retorna false se o token não foi encontrado
        return false;
    }
}

// Recebe os dados da requisição POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Verifica se o token de autenticação foi fornecido
    $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
    if (empty($authHeader)) {
        // Token não fornecido, retorna um erro
        echo json_encode(['status' => 'error', 'message' => 'Token de autenticação não fornecido']);
        exit;
    }

    // Extrai o token do cabeçalho de autorização
    $token = str_replace('Bearer ', '', $authHeader);

    // Verifica se o token de autenticação é válido
    $userId = verifyAuthToken($token);
    if (!$userId) {
        // Token inválido, retorna um erro
        echo json_encode(['status' => 'error', 'message' => 'Token de autenticação inválido']);
        exit;
    }

    // Token válido, continua com o processamento dos dados da caixinha
    $nome_caixinha = $_POST['nome_caixinha'];
    if (empty($nome_caixinha)) {
        // Nome da caixinha não fornecido, retorna um erro
        echo json_encode(['status' => 'error', 'message' => 'Nome da caixinha não fornecido']);
        exit;
    }

    // Prepara a consulta SQL para inserir os dados na tabela caixinha
    $sql = "INSERT INTO criar_caixinha (nome, usuario_id) VALUES (?, ?)";
    $stmt = $conn->prepare($sql);

    if ($stmt->execute([$nome_caixinha, $userId])) {
        // Caixinha criada com sucesso
        echo json_encode(['status' => 'success', 'message' => 'Caixinha criada com sucesso!']);
    } else {
        // Erro ao criar caixinha
        echo json_encode(['status' => 'error', 'message' => 'Erro ao criar caixinha']);
    }
}
?>
