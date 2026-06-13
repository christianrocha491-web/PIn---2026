<?php
// Importação das classes do PHPMailer para o envio via SMTP
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'phpmailer/Exception.php';
require 'phpmailer/PHPMailer.php';
require 'phpmailer/SMTP.php';

// Configurações do Banco de Dados
$host = '127.0.0.1';
$user = 'root';
$pass = '';
$db = 'pin2026';

try {
    $pdo = new PDO("mysql:host=127.0.0.1;dbname=pin2026;charset=utf8", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) { 
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => "Erro de Conexão: " . $e->getMessage()]);
    exit;
}

// Processa as requisições enviadas pelo Fetch
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['acao'])) {
    header('Content-Type: application/json');
    
    // ==========================================
    // LÓGICA DE CADASTRO
    // ==========================================
    if ($_POST['acao'] === 'cadastrar') {
        $senhaHash = password_hash($_POST['senha'], PASSWORD_DEFAULT);

        $sql = "INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        try {
            $stmt->execute([$_POST['nome'], $_POST['email'], $senhaHash]);
            echo json_encode(['success' => true]);
        } catch (Exception $e) {
            echo json_encode(['success' => false, 'message' => 'Email já cadastrado!']);
        }
    }

    // ==========================================
    // LÓGICA DE LOGIN
    // ==========================================
    if ($_POST['acao'] === 'logar') {
        $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE email = ?");
        $stmt->execute([$_POST['email']]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($_POST['senha'], $user['senha'])) {
            echo json_encode(['success' => true, 'user' => ['nome' => $user['nome'], 'email' => $user['email']]]);
        } else {
            echo json_encode(['success' => false, 'message' => 'E-mail ou senha incorretos!']);
        }
    }

    // ==========================================
    // SOLICITAÇÃO DE REDEFINIÇÃO DE SENHA (SMTP)
    // ==========================================
    if ($_POST['acao'] === 'request_reset') {
        $email = $_POST['email'] ?? '';
        $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE email = ?");
        $stmt->execute([$email]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            echo json_encode(['success' => false, 'message' => 'E-mail não cadastrado.']);
            exit;
        }

        // Gerar token e salvar na tabela password_resets
        $token = bin2hex(random_bytes(16));
        $token_hash = hash('sha256', $token);
        $expires = date('Y-m-d H:i:s', time() + 3600); // 1 hora

        // Garantir tabela
        $pdo->exec("CREATE TABLE IF NOT EXISTS password_resets (
            id INT AUTO_INCREMENT PRIMARY KEY,
            email VARCHAR(255) NOT NULL,
            token_hash VARCHAR(255) NOT NULL,
            expires_at DATETIME NOT NULL,
            created_at DATETIME NOT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

        $stmt = $pdo->prepare("INSERT INTO password_resets (email, token_hash, expires_at, created_at) VALUES (?, ?, ?, ?)");
        $stmt->execute([$email, $token_hash, $expires, date('Y-m-d H:i:s')]);

        // Montar link de reset
        $host = $_SERVER['HTTP_HOST'];
        $path = dirname($_SERVER['PHP_SELF']);
        $link = "http://" . $host . $path . "/criar_nova_senha.html?token=" . $token;

        // Instanciando o PHPMailer para envio via SMTP seguro
        $mail = new PHPMailer(true);



        
        try {
            // Configurações do Servidor SMTP (Substitua com os seus dados do Mailtrap ou outro provedor)
            $mail->isSMTP();

$mail->Host = 'smtp.gmail.com';

$mail->SMTPAuth = true;

$mail->Username = 'christianrocha491@gmail.com';

$mail->Password = 'mrrphaokpqbtxnda';

$mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;

$mail->Port = 587;

$mail->CharSet = 'UTF-8';

$mail->setFrom('christianrocha491@gmail.com', 'SaudePira');

$mail->addAddress($email);



           

            // Conteúdo do E-mail em HTML
            $mail->isHTML(true);
            $mail->Subject = '[Saúde Pira] Redefinição de senha';
            $mail->Body     = "Prezado(a),<br><br>Para redefinir sua senha, acesse o link a seguir:<br><br><a href='{$link}' style='color: #007bff; text-decoration: none; font-weight: bold;'>Clique aqui para redefinir sua senha</a><br><br>Ou copie e cole o link no seu navegador:<br>{$link}<br><br>Se você não solicitou essa alteração, ignore esta mensagem.<br><br>Atenciosamente,<br>Saúde Pira";
            $mail->AltBody = "Prezado(a),\n\nPara redefinir sua senha, acesse o link a seguir:\n\n" . $link . "\n\nSe você não solicitou essa alteração, ignore esta mensagem.\n\nAtenciosamente,\nSaúde Pira";

            

            $mail->send();
            echo json_encode(['success' => true, 'message' => 'Se o e-mail estiver cadastrado, você receberá um link para redefinir a senha.']);
        } catch (Exception $e) {
            // Em caso de erro no SMTP, exibe o diagnóstico para você arrumar nas configurações
            echo json_encode(['success' => false, 'message' => "Erro ao enviar e-mail: {$mail->ErrorInfo}"]);
        }
        exit;
    }

    // ==========================================
    // VALIDAR TOKEN
    // ==========================================
    if ($_POST['acao'] === 'validate_token') {
        $token = $_POST['token'] ?? '';
        $token_hash = hash('sha256', $token);
        $stmt = $pdo->prepare("SELECT * FROM password_resets WHERE token_hash = ? AND expires_at > NOW()");
        $stmt->execute([$token_hash]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($row) {
            echo json_encode(['success' => true, 'email' => $row['email']]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Token inválido ou expirado.']);
        }
        exit;
    }

    // ==========================================
    // RECUPERAÇÃO DE SENHA / RESET
    // ==========================================
    if ($_POST['acao'] === 'reset_password') {
        $token = $_POST['token'] ?? '';
        $newSenha = $_POST['senha'] ?? '';
        if (!$token || !$newSenha) {
            echo json_encode(['success' => false, 'message' => 'Dados incompletos.']);
            exit;
        }

        $token_hash = hash('sha256', $token);
        $stmt = $pdo->prepare("SELECT * FROM password_resets WHERE token_hash = ? AND expires_at > NOW()");
        $stmt->execute([$token_hash]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$row) {
            echo json_encode(['success' => false, 'message' => 'Token inválido ou expirado.']);
            exit;
        }

        $novaSenhaHash = password_hash($newSenha, PASSWORD_DEFAULT);

        $stmt = $pdo->prepare("UPDATE usuarios SET senha = ? WHERE email = ?");
        $stmt->execute([$novaSenhaHash, $row['email']]);

        $stmt = $pdo->prepare("DELETE FROM password_resets WHERE email = ?");
        $stmt->execute([$row['email']]);

        echo json_encode(['success' => true, 'message' => 'Senha atualizada com sucesso.']);
        exit;
    }
    exit;
}