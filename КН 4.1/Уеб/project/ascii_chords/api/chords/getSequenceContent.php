<?php
require_once '../db/db.php';

$res = new stdClass();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $json_data = file_get_contents("php://input");
    
    $data = json_decode($json_data, true);

    $sequenceID = $data['sequence_id'];

    $db = new Db();
    $connection = $db->getConnection();

    $stmt = $connection->prepare("SELECT * FROM sequences WHERE ID = ?");
    $stmt->execute([$sequenceID]);
    $sequence = $stmt->fetch();

    if ($sequence) {
        $res->success = true;
        $res->message = "Sequence fetched successfully";
        $res->sequence = $sequence;
    } else {
        $res->success = false;
        $res->message = "Error getting sequence content";
    }
} else {
    $res->success = false;
    $res->message = "Invalid request";
}

echo json_encode($res);