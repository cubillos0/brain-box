<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require 'config.php'; // Inclui o arquivo de configuração do banco de dados

// Função para verificar o token de autenticação
function verifyAuthToken($token, $conn) {
    $sql = "SELECT user_id FROM tokens WHERE token = ? AND expires_at > NOW()";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$token]);
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
    return $result ? $result['user_id'] : false;
}

// Verifica se a requisição é um GET ou POST
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

    // Verifica se o token de autenticação é válido
    $userId = verifyAuthToken($token, $conn);
    if (!$userId) {
        // Token inválido, retorna um erro
        echo json_encode(['status' => 'error', 'message' => 'Token de autenticação inválido']);
        exit;
    }

    // Consulta SQL para buscar os dados da caixinha
    $sql = "SELECT nome FROM caixinha ORDER BY id DESC LIMIT 1";

    // Prepara e executa a consulta
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $caixinha = $stmt->fetch(PDO::FETCH_ASSOC);

    // Verifica se a caixinha foi encontrada
    if ($caixinha) {
        // Retorna os dados da caixinha em formato JSON
        echo json_encode(['status' => 'success', 'caixinha' => $caixinha]);
    } else {
        // Retorna uma mensagem de erro caso a caixinha não seja encontrada
        echo json_encode(['status' => 'error', 'message' => 'Nenhuma caixinha encontrada']);
    }
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Recebe o token de autenticação do cabeçalho Authorization
    $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
    if (empty($authHeader)) {
        // Token não fornecido, retorna um erro
        echo json_encode(['status' => 'error', 'message' => 'Token de autenticação não fornecido']);
        exit;
    }

    // Extrai o token do cabeçalho de autorização
    $token = str_replace('Bearer ', '', $authHeader);

    // Verifica se o token de autenticação é válido
    $userId = verifyAuthToken($token, $conn);
    if (!$userId) {
        // Token inválido, retorna um erro
        echo json_encode(['status' => 'error', 'message' => 'Token de autenticação inválido']);
        exit;
    }

    // Recebe os dados da requisição POST
    $anotacao = $_POST['anotacao'] ?? '';

    // Verifica se os dados necessários foram fornecidos
    if (empty($anotacao)) {
        echo json_encode(['status' => 'error', 'message' => 'Anotação não fornecida']);
        exit;
    }

    // Prepara a consulta SQL para inserir os dados na tabela caixinha_itens
    $sql = "INSERT INTO caixinha_itens (caixinha_id, anotacao) VALUES (?, ?)";

    // Prepara e executa a consulta
    $stmt = $conn->prepare($sql);
    if ($stmt->execute([$anotacao, $caixinha_id])) {
        echo json_encode(['status' => 'success', 'message' => 'Dados da caixinha enviados com sucesso']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Erro ao enviar dados da caixinha']);
    }
}

// Fecha a conexão com o banco de dados
$conn = null;
?>
