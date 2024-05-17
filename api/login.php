<<<<<<< HEAD
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

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $senha = $_POST['senha'] ?? '';

    if (empty($email) || empty($senha)) {
        echo json_encode(['status' => 'error', 'message' => 'Email ou senha não fornecidos']);
        exit;
    }

    $sql = "SELECT id FROM cadastro WHERE email = ? AND senha = ?";
    $stmt = $pdo->prepare($sql);
    
    if ($stmt->execute([$email, $senha])) {
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user) {
            $token = bin2hex(random_bytes(32)); // Geração simples de token
            $sqlInsertToken = "INSERT INTO tokens (user_id, token) VALUES (?, ?)";
            $stmtInsertToken = $pdo->prepare($sqlInsertToken);
            
            if ($stmtInsertToken->execute([$user['id'], $token])) {
                // Retorna o token como parte da resposta em caso de sucesso
                echo json_encode(['status' => 'success', 'user_id' => $user['id'], 'token' => $token]);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Erro ao criar token']);
            }
        } else {
            // Credenciais inválidas
            echo json_encode(['status' => 'error', 'message' => 'Credenciais inválidas']);
        }
    } else {
        // Erro na consulta SQL
        echo json_encode(['status' => 'error', 'message' => 'Erro ao autenticar usuário']);
    }
}
?>
=======
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
>>>>>>> 8ba72141911d160350fcbf3a74d0d9f3cacce3fb
