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

    // Detecta idioma solicitado
    $lang = isset($_GET['lang']) ? strtolower(substr($_GET['lang'],0,2)) : 'pt';

    // Verifica se há colunas traduzidas (_en)
    $has_nome_en = false;
    $colCheck = $pdo->query("SHOW COLUMNS FROM instituicoes LIKE 'nome_en'");
    if($colCheck && $colCheck->rowCount() > 0) $has_nome_en = true;

    if($lang === 'en' && $has_nome_en){
        $sql = "SELECT id, COALESCE(nome_en, nome) AS nome, COALESCE(localizacao_en, localizacao) AS localizacao, COALESCE(especialidades_en, especialidades) AS especialidades, COALESCE(horario_atendimento_en, horario_atendimento) AS horario_atendimento, lat, lng, url_imagem FROM instituicoes ORDER BY nome_en IS NULL, nome_en ASC";
    } else {
        $sql = "SELECT id, nome, localizacao, especialidades, horario_atendimento, lat, lng, url_imagem FROM instituicoes ORDER BY nome ASC";
    }
    $stmt = $pdo->query($sql);
    $unidades = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Entrega os dados formatados para o JavaScript
    echo json_encode($unidades);

} catch(PDOException $e) {
    // Se houver erro na conexão, ele avisa
    echo json_encode(["error" => "Falha na conexão: " . $e->getMessage()]);
}
?>