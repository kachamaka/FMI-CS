<?php
require_once '../db/db.php';
// require_once '../auth/checkSession.php';

$res = new stdClass();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $json_data = file_get_contents("php://input");
    
    $data = json_decode($json_data, true);

    $sequence = $data['sequence'];

    $db = new Db();
    $connection = $db->getConnection();

    $stmt = $connection->prepare("INSERT INTO sequences (content) VALUES (?)");
    $ok = $stmt->execute([$sequence]);

    if ($ok) {
        $res->success = true;
        $res->message = "Sequence saved successfully";
        $res->sequenceID = $connection->lastInsertId();
    } else {
        $res->success = false;
        $res->message = "Error saving sequence";
    }
} else {
    $res->success = false;
    $res->message = "Invalid request";
}

echo json_encode($res);