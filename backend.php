<?php
// config.php - Kết nối MongoDB
require 'vendor/autoload.php';

$client = new MongoDB\Client("mongodb://localhost:27017");
$db = $client->selectDatabase("your_database_name");
$usersCollection = $db->selectCollection("users");

session_start();
?>

<?php
// auth.php - Xử lý đăng nhập
require 'config.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $data = json_decode(file_get_contents("php://input"), true);
    $username = htmlspecialchars($data['username']);
    $password = htmlspecialchars($data['password']);

    $user = $usersCollection->findOne(['username' => $username]);

    if ($user && password_verify($password, $user['password'])) {
        $_SESSION['logged_in'] = true;
        $_SESSION['username'] = $username;
        echo json_encode(["success" => true, "message" => "Đăng nhập thành công!"]);
    } else {
        echo json_encode(["success" => false, "message" => "Sai tài khoản hoặc mật khẩu!"]);
    }
}
?>

<?php
// logout.php - Đăng xuất
session_start();
session_destroy();
echo json_encode(["success" => true, "message" => "Đã đăng xuất!"]);
?>

<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^(.*)$ index.php?$1 [QSA,L]
</IfModule>
