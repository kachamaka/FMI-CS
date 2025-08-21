<?php

class Db {
    private $connection;

    public function __construct() {
        $config = parse_ini_file('../../config/db.ini', true);

        $dbhost = $config['database']['host'];
        $dbName = $config['database']['dbname'];
        $userName = $config['database']['username'];
        $userPassword = $config['database']['password'];

        $this->connection = new PDO("mysql:host=$dbhost;dbname=$dbName", $userName, $userPassword, [
                PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8",
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            ]);
    }

    public function getConnection() {
        return $this->connection;
    }
}