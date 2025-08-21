<?php
require_once '../db/db.php';
// require_once '../auth/checkSession.php';

$res = new stdClass();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
// if ($isset($_SESSION['userID'])) {
    $db = new Db();
    $connection = $db->getConnection();

    $stmt = $connection->prepare("SELECT * FROM base_chords");
    $stmt->execute();
    $chords = $stmt->fetchAll();

    if ($chords || sizeof($chords) == 0) {
        $res->success = true;
        $res->message = "Base chords fetched successfully";
        $res->chords = $chords;
    } else {
        $res->success = false;
        $res->message = "Error getting base chords";
    }
} else {
    $res->success = false;
    $res->message = "Invalid request";
}

echo json_encode($res);