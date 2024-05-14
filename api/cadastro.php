<?php
header("Access-Control-Allow-Origin: *");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Verifica se os campos obrigatórios foram enviados
    if (isset($_POST['nome'], $_POST['email'], $_POST['senha'])) {
        // Obtém os valores dos campos
        $nome = $_POST['nome'];
        $email = $_POST['email'];
        $senha = $_POST['senha'];

        // Conecta ao banco de dados (substitua os valores conforme a configuração do seu banco)
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "brainbox";

        $conn = new mysqli($servername, $username, $password, $dbname);

        // Verifica a conexão
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        // Sanitiza os dados para prevenir ataques de injeção de SQL
        $nome = $conn->real_escape_string($nome);
        $email = $conn->real_escape_string($email);
        $senha = $conn->real_escape_string($senha);

        // Insere os dados na tabela
        $sql = "INSERT INTO cadastro (nome, email, senha) VALUES ('$nome', '$email', '$senha')";

        if ($conn->query($sql) === TRUE) {
            // Se o cadastro foi bem-sucedido, retorna uma mensagem de sucesso para o aplicativo Flutter
            echo "Cadastro realizado com sucesso!";
        } else {
            // Se houve um erro ao cadastrar, retorna uma mensagem de erro para o aplicativo Flutter
            echo "Erro ao cadastrar: " . $conn->error;
        }

        // Fecha a conexão com o banco de dados
        $conn->close();
    } else {
        // Se algum campo obrigatório estiver faltando, retorna uma mensagem de erro
        echo "Por favor, preencha todos os campos obrigatórios.";
    }
} else {
    // Retorna uma mensagem de erro se a requisição não for do tipo POST
    echo "Método não permitido. Esta API aceita apenas requisições POST.";
}
?>