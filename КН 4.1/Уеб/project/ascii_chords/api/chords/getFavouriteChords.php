<?php
require_once '../db/db.php';
require_once '../auth/checkSession.php';

$res = new stdClass();

if (isset($_SESSION['userID'])) {
    $db = new Db();
    $connection = $db->getConnection();

    $userID = $_SESSION['userID'];

    $stmt = $connection->prepare("SELECT * FROM favourites_base JOIN base_chords ON favourites_base.chordID = base_chords.ID WHERE userID = ?");
    $stmt->execute([$userID]);
    $baseChords = $stmt->fetchAll();
    
    $stmt = $connection->prepare("SELECT * FROM favourites_user JOIN chords ON favourites_user.chordID = chords.ID WHERE favourites_user.userID = ?");
    $stmt->execute([$userID]);
    $userChords = $stmt->fetchAll();

    $chords = array_merge($baseChords, $userChords);
    if ($chords || sizeof($chords) == 0) {
        $res->success = true;
        $res->message = "Favourite chords fetched successfully";
        $res->chords = $chords;
    } else {
        $res->success = false;
        $res->message = "Error getting chords";
    }
} else {
    $res->success = false;
    $res->message = "User not logged in";
}

echo json_encode($res);