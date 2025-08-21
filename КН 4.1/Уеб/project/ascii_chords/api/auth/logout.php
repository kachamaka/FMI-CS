<?php

$res = new stdClass();

session_start();
session_destroy();

$res->success = true;
$res->message = "Logout successful";

echo json_encode($res);