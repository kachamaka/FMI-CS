<?php
require_once '../db/db.php';

$res = new stdClass();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $json_data = file_get_contents("php://input");
    
    $data = json_decode($json_data, true);

    $username = $data['username'];
    $password = $data['password'];

    $db = new Db();
    $connection = $db->getConnection();
    $stmt = $connection->prepare("SELECT * FROM users WHERE username = ?");
    $stmt->execute([$username]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['password'])) {
        session_start();
        $_SESSION['userID'] = $user['ID'];
        session_regenerate_id(true);
        $res->success = true;
        $res->userID = $user['ID'];
        $res->message = 'Login successful';
    } else {
        $res->success = false;
        $res->message = 'Invalid username or password';
    }
} else {
    $res->success = false;
    $res->message = 'Invalid request method';
}

echo json_encode($res);