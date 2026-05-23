<?php
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
    
    // Lógica de Cadastro
    if ($_POST['acao'] === 'cadastrar') {
        $sql = "INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        try {
            $stmt->execute([$_POST['nome'], $_POST['email'], $_POST['senha']]);
            echo json_encode(['success' => true]);
        } catch (Exception $e) {
            echo json_encode(['success' => false, 'message' => 'Email já cadastrado!']);
        }
    }

    // Lógica de Login
    if ($_POST['acao'] === 'logar') {
        $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE email = ? AND senha = ?");
        $stmt->execute([$_POST['email'], $_POST['senha']]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user) {
            echo json_encode(['success' => true, 'user' => ['nome' => $user['nome'], 'email' => $user['email']]]);
        } else {
            echo json_encode(['success' => false, 'message' => 'E-mail ou senha incorretos!']);
        }
    }

    // Solicitação de redefinição de senha
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

        $subject = '[Saúde Pira] Redefinição de senha';
        $message = "Prezado(a),\n\nPara redefinir sua senha, acesse o link a seguir:\n\n" . $link . "\n\nSe você não solicitou essa alteração, ignore esta mensagem.\n\nAtenciosamente,\nSaúde Pira";
        $headers = 'From: no-reply@' . $host . "\r\n" . 'Content-Type: text/plain; charset=UTF-8';

        // Enviar e-mail (pode não funcionar sem SMTP configurado)
        @mail($email, $subject, $message, $headers);

        echo json_encode(['success' => true, 'message' => 'Se o e-mail estiver cadastrado, você receberá um link para redefinir a senha.']);
        exit;
    }

    // Validar token (opcional)
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

    // Resetar a senha usando token
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

        // Atualizar senha do usuário
        $stmt = $pdo->prepare("UPDATE usuarios SET senha = ? WHERE email = ?");
        $stmt->execute([$newSenha, $row['email']]);

        // Remover tokens pendentes para esse email
        $stmt = $pdo->prepare("DELETE FROM password_resets WHERE email = ?");
        $stmt->execute([$row['email']]);

        echo json_encode(['success' => true, 'message' => 'Senha atualizada com sucesso.']);
        exit;
    }
    exit;
}