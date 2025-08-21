<?php
require_once '../db/db.php';
require_once '../auth/checkSession.php';

$res = new stdClass();

if (isset($_SESSION['userID'])) {
    $json_data = file_get_contents("php://input");
    
    $data = json_decode($json_data, true);

    $chord_name = $data['chord_name'];
    $acoustic_guitar = $data['acoustic_guitar'];
    $electric_guitar = $data['electric_guitar'];
    $ukulele = $data['ukulele'];

    $userID = $_SESSION['userID'];

    $db = new Db();
    $connection = $db->getConnection();

    $stmt = $connection->prepare("INSERT INTO chords (userID, name, acoustic_guitar, electric_guitar, ukulele) VALUES (?, ?, ?, ?, ?)");
    $ok = $stmt->execute([$userID, $chord_name, $acoustic_guitar, $electric_guitar, $ukulele]);

    if ($ok) {
        $res->success = true;
        $res->message = "Chord added successfully";
    } else {
        $res->success = false;
        $res->message = "Error adding chord";
    }
} else {
    $res->success = false;
    $res->message = "User not logged in";
}

echo json_encode($res);