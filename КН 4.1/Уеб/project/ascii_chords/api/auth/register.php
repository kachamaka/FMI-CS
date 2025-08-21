<?php
require_once '../db/db.php';

$res = new stdClass();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    $json_data = file_get_contents("php://input");
    
    // Decode the JSON data
    $data = json_decode($json_data, true);

    $username = $data['username'];
    $email = $data['email'];
    $password = password_hash($data['password'], PASSWORD_BCRYPT); // Hash the password

    // Validate and insert into the database
    // You should add more validation and error handling here

    $db = new Db();
    $connection = $db->getConnection();
    $stmt = $connection->prepare("INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)");
    $ok = $stmt->execute([$username, $email, $password, 1]);
    if (!$ok) {
        $res->success = false;
        $res->message = 'Error saving user';
    } else {
        session_start();
        $_SESSION['userID'] = $connection->lastInsertId();
        $res->success = true;
        $res->userID = $connection->lastInsertId();
        $res->message = 'Register successful';
    }
} else {
    $res->success = false;
    $res->message = 'Invalid request type';
}

echo json_encode($res);
