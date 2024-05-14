<?php
header("Access-Control-Allow-Origin: *");

// Verifica se a requisição é do tipo POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Recebe os dados enviados pelo aplicativo Flutter
    $email = $_POST['email'];
    $senha = $_POST['senha'];

    // Conecta ao banco de dados (substitua os valores conforme a configuração do seu banco)
    $servername = "localhost"; // Endereço do servidor MySQL
    $username = "root"; // Nome de usuário do MySQL
    $password = ""; // Senha do MySQL
    $dbname = "brainbox"; // Nome do banco de dados

    // Cria a conexão
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Verifica a conexão
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Prepara e executa a query SQL para verificar se o e-mail e a senha existem na tabela
    $sql = "SELECT * FROM cadastro WHERE email='$email' AND senha='$senha'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Se encontrou um registro correspondente, retorna uma mensagem de sucesso para o aplicativo Flutter
        echo "Login realizado com sucesso!";
    } else {
        // Se não encontrou nenhum registro correspondente, retorna uma mensagem de erro para o aplicativo Flutter
        echo "E-mail ou senha incorretos.";
    }

    // Fecha a conexão com o banco de dados
    $conn->close();
} else {
    // Retorna uma mensagem de erro se a requisição não for do tipo POST
    echo "Método não permitido. Esta API aceita apenas requisições POST.";
}
?>
