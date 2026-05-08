<?php
// Define que o arquivo retorna um JSON (formato que o JavaScript entende)
header('Content-Type: application/json');
// Permite que seu HTML acesse este arquivo mesmo rodando no localhost
header('Access-Control-Allow-Origin: *');

// Configurações de conexão com o seu banco de dados em casa
$host = "localhost";
$user = "root";
$pass = "";
$dbname = "pin2026"; // Nome do banco que você importou

try {
    // Tenta conectar ao banco de dados
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Busca todos os dados das instituições, incluindo as novas coordenadas
$stmt = $pdo->query("SELECT id, nome, localizacao, especialidades, horario_atendimento, lat, lng, url_imagem FROM instituicoes ORDER BY nome ASC");
    $unidades = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Entrega os dados formatados para o JavaScript
    echo json_encode($unidades);

} catch(PDOException $e) {
    // Se houver erro na conexão, ele avisa
    echo json_encode(["error" => "Falha na conexão: " . $e->getMessage()]);
}
?>