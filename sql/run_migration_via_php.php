<?php
// Run migration SQL file via PDO. Configure credentials below if needed.
$host = '127.0.0.1';
$db   = 'pin2026';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';
$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

$sqlFile = __DIR__ . '/migrations/2026_add_en_columns_and_examples.sql';
if(!file_exists($sqlFile)){
    echo "Arquivo SQL não encontrado: $sqlFile\n";
    exit(1);
}

try{
    $pdo = new PDO($dsn, $user, $pass, $options);
    $sql = file_get_contents($sqlFile);
    // Split statements by semicolon; naive but acceptable for simple migrations
    $statements = array_filter(array_map('trim', explode(';', $sql)));
    foreach($statements as $stmt){
        if($stmt==='') continue;
        // Skip comments
        if(strpos($stmt,'--')===0) continue;
        try{
            $pdo->exec($stmt);
            echo "OK: " . (strlen($stmt)>50?substr($stmt,0,50).'...':$stmt) . "\n";
        }catch(PDOException $e){
            echo "ERRO ao executar statement: " . $e->getMessage() . "\n";
        }
    }
    echo "Migração finalizada.\n";
}catch(PDOException $e){
    echo "Falha de conexão: " . $e->getMessage() . "\n";
    exit(1);
}
