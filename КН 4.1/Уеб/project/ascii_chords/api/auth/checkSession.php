<?php

if (!isset($_SESSION)) {
    session_start();
}

$res = new stdClass();

if (!isset($_SESSION['userID'])) {
    $res->success = false;
    $res->message = 'User is not logged in';
    echo json_encode($res);
    exit();
} 