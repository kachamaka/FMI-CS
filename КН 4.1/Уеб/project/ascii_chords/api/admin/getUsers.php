<?php
require_once '../db/db.php';
require_once '../auth/checkSession.php';

$res = new stdClass();

if (isset($_SESSION['userID'])) {
    $userID = $_SESSION['userID'];

    $db = new Db();
    $connection = $db->getConnection();

    $stmt = $connection->prepare("SELECT role FROM users WHERE id = ?");
    $stmt->execute([$userID]);
    $user = $stmt->fetch();

    if ($user) {
        if ($user["role"] == '2') {
            $stmt = $connection->prepare("SELECT ID, username, email FROM users");
            $stmt->execute();
            $users = $stmt->fetchAll();

            $res->success = true;
            $res->message = "Users fetched successfully";
            $res->users = $users;
        }
    } else {
        $res->success = false;
        $res->message = "User not found";
    }
} else {
    $res->success = false;
    $res->message = "User not logged in";
}

echo json_encode($res);