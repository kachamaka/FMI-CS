<?php
require_once '../db/db.php';
require_once '../auth/checkSession.php';

$res = new stdClass();

if (isset($_SESSION['userID'])) {
    $json_data = file_get_contents("php://input");
    
    $data = json_decode($json_data, true);

    $userID = $data['userID'];
    $password = password_hash($data['password'], PASSWORD_BCRYPT); 

    $adminID = $_SESSION['userID'];

    $db = new Db();
    $connection = $db->getConnection();

    $stmt = $connection->prepare("SELECT role FROM users WHERE ID = ?");
    $stmt->execute([$adminID]);
    $admin = $stmt->fetch();

    if ($admin["role"] != 2) {
        $res->success = false;
        $res->message = "User is not admin";
        json_encode($res);
        exit();
    }

    $stmt = $connection->prepare("UPDATE users SET password = ? WHERE ID = ?");
    $ok = $stmt->execute([$password, $userID]);

    if ($ok) {
        $res->success = true;
        $res->message = "Password changed successfully";
    } else {
        $res->success = false;
        $res->message = "Error changing user password";
    }
} else {
    $res->success = false;
    $res->message = "User not logged in";
}

echo json_encode($res);