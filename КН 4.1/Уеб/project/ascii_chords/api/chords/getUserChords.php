<?php
require_once '../db/db.php';
require_once '../auth/checkSession.php';

$res = new stdClass();

if (isset($_SESSION['userID'])) {
    $userID = $_SESSION['userID'];

    $db = new Db();
    $connection = $db->getConnection();

    $stmt = $connection->prepare("SELECT * FROM chords where userID = ?");
    $stmt->execute([$userID]);
    $chords = $stmt->fetchAll();

    if ($chords || sizeof($chords) == 0) {
        $res->success = true;
        $res->message = "User chords fetched successfully";
        $res->chords = $chords;
    } else {
        $res->success = false;
        $res->message = "Error getting user chords";
    }
} else {
    $res->success = false;
    $res->message = "User not logged in";
}

echo json_encode($res);