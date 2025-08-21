<?php
require_once '../db/db.php';
require_once 'checkSession.php';

$res = new stdClass();

if (isset($_SESSION['userID'])) {
    $userID = $_SESSION['userID'];

    $db = new Db();
    $connection = $db->getConnection();

    $stmt = $connection->prepare("SELECT ID, username, email, role FROM users WHERE id = ?");
    $stmt->execute([$userID]);
    $user = $stmt->fetch();

    if ($user) {
        $res->success = true;
        $res->message = "User fetched successfully";
        $res->user = $user;
    } else {
        $res->success = false;
        $res->message = "User not found";
    }
} else {
    $res->success = false;
    $res->message = "User not logged in";
}

echo json_encode($res);