<?php

if(!isset($_SESSION)) { 
    session_start(); 
} 

$res = new stdClass();

if (!isset($_SESSION['userID'])) {
    $res->success = false;
    $res->message = 'User is not logged in';
} else {
    $res->success = true;
    $res->message = 'User is logged in';
    $res->userID = $_SESSION['userID'];
}

echo json_encode($res);