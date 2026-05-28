<?php
/**
 * API REST - Obter todas as instituições cadastradas
 * 
 * Retorna um JSON com todas as instituições do banco de dados
 * para serem exibidas no mapa interativo.
 * 
 * Requisição: GET /api/get_instituicoes.php
 * Resposta: JSON array com instituições
 */

// Configurações de CORS (permitir requisições cross-origin)
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json; charset=utf-8');

// Tratamento de requisições OPTIONS (preflight)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

try {
    // Configurações do Banco de Dados
    $host = '127.0.0.1';
    $user = 'root';
    $pass = '';
    $db = 'pin2026';

    // Conexão com o banco usando PDO
    $pdo = new PDO("mysql:host={$host};dbname={$db};charset=utf8mb4", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Apenas GET é permitido
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        http_response_code(405);
        echo json_encode([
            'success' => false,
            'message' => 'Método não permitido. Use GET.'
        ]);
        exit;
    }

    // Query para buscar todas as instituições
    $sql = "SELECT 
                id,
                nome,
                localizacao as endereco,
                lat as latitude,
                lng as longitude,
                especialidades,
                horario_atendimento,
                contato,
                detalhes,
                url_imagem,
                atualizado_em
            FROM instituicoes
            ORDER BY nome ASC";

    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    
    $instituicoes = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Converter latitude e longitude para float
    foreach ($instituicoes as &$inst) {
        $inst['latitude'] = (float) $inst['latitude'];
        $inst['longitude'] = (float) $inst['longitude'];
    }

    // Retornar sucesso com dados
    http_response_code(200);
    echo json_encode([
        'success' => true,
        'total' => count($instituicoes),
        'data' => $instituicoes
    ]);

} catch (PDOException $e) {
    // Erro de conexão com o banco
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Erro ao conectar ao banco de dados',
        'error' => 'Database connection failed'
    ]);
} catch (Exception $e) {
    // Outros erros
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Erro ao processar requisição',
        'error' => $e->getMessage()
    ]);
}
