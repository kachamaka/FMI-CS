<?php
require_once '../db/db.php';
require_once '../auth/checkSession.php';

$res = new stdClass();

if (isset($_SESSION['userID'])) {
    $json_data = file_get_contents("php://input");
    
    $data = json_decode($json_data, true);

    $userID = $data['userID'];
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

    $stmt = $connection->prepare("DELETE FROM favourites_user WHERE userID = ?");
    $ok = $stmt->execute([$userID]);

    if (!$ok) {
        $res->success = false;
        $res->message = "Error deleting from favourites_user";
        json_encode($res);
        exit();
    }

    $stmt = $connection->prepare("DELETE FROM favourites_base WHERE userID = ?");
    $ok = $stmt->execute([$userID]);
    
    if (!$ok) {
        $res->success = false;
        $res->message = "Error deleting from favourites_base";
        json_encode($res);
        exit();
    }

    $stmt = $connection->prepare("DELETE FROM chords WHERE userID = ?");
    $ok = $stmt->execute([$userID]);
    
    if (!$ok) {
        $res->success = false;
        $res->message = "Error deleting from chords";
        json_encode($res);
        exit();
    }

    $stmt = $connection->prepare("DELETE FROM users WHERE ID = ?");
    $ok = $stmt->execute([$userID]);
    
    if (!$ok) {
        $res->success = false;
        $res->message = "Error deleting user";
        json_encode($res);
        exit();
    }

    $res->success = true;
    $res->message = "User deleted successfully";
    
} else {
    $res->success = false;
    $res->message = "User not logged in";
}

echo json_encode($res);