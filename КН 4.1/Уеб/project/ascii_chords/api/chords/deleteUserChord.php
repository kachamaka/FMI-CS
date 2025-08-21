<?php
require_once '../db/db.php';
require_once '../auth/checkSession.php';

$res = new stdClass();

if (isset($_SESSION['userID'])) {
    $json_data = file_get_contents("php://input");
    
    $data = json_decode($json_data, true);

    $chord_name = $data['chord_name'];
    $userID = $_SESSION['userID'];

    $db = new Db();
    $connection = $db->getConnection();

    $stmt = $connection->prepare("DELETE FROM favourites_user WHERE userID = ? AND chordID IN (SELECT ID FROM chords WHERE name = ?)");
    $ok = $stmt->execute([$userID, $chord_name]);
    
    if ($ok) {
        $stmt = $connection->prepare("DELETE FROM chords WHERE userID = ? AND name = ?");
        $ok = $stmt->execute([$userID, $chord_name]);
        
        if ($ok) {
            $res->success = true;
            $res->message = "Chord deleted successfully";
        } else {
            $res->success = false;
            $res->message = "Error deleting chord";
        }
    } else {
        $res->success = false;
        $res->message = "Error adding chord";
    }
} else {
    $res->success = false;
    $res->message = "User not logged in";
}

echo json_encode($res);