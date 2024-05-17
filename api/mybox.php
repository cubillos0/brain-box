<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require 'config.php'; // Inclui o arquivo de configuração do banco de dados

// Criação da conexão usando PDO
try {
    $conn = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

// Verifica se a requisição é um GET ou POST
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Consulta SQL para buscar os dados da caixinha
    $sql = "SELECT nome FROM criar_caixinha ORDER BY id DESC LIMIT 1";

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
    // Recebe os dados da requisição POST
    $anotacao = $_POST['anotacao'] ?? '';
    $imagem = $_POST['imagem'] ?? '';
    $documento = $_POST['documento'] ?? '';
    $links = $_POST['links'] ?? '';

    // Verifica se os dados necessários foram fornecidos
    if (empty($anotacao)) {
        echo json_encode(['status' => 'error', 'message' => 'Anotação não fornecida']);
        exit;
    }

    // Prepara a consulta SQL para inserir os dados na tabela caixinha
    $sql = "INSERT INTO caixinha (anotacao, imagem, documento, links, caixinha_id) VALUES (?, ?, ?, ?, ?)";

    // Prepara e executa a consulta
    $stmt = $conn->prepare($sql);
    if ($stmt->execute([$anotacao, $imagem, $documento, $links, $caixinha_id])) {
        echo json_encode(['status' => 'success', 'message' => 'Dados da caixinha enviados com sucesso']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Erro ao enviar dados da caixinha']);
    }
}

// Fecha a conexão com o banco de dados
$conn = null;
?>
