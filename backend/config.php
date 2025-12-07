<?php
    // This file is meant to create a connection to the database

    //json headers
    header("Access-Control-Allow-Orgin: *");
    header("Access-Control-Allow-Headers: Content-Type");
    header("Access-Control-Allow-Methods: POST, GET");
    header("Content-Type: application/json");

    $host = "localhost";
    $db = "cinema_db";
    $user = "root"; //Need to adjust this later
    $pass = ""; //Need to adjust this later

    //Error Reporting
    try {
        $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8mb4", $user, $pass);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $a) {
        http_response_code(500);
        echo json_encode(["error" => "Database error: " . $e->getMessage()]);
        exit;
    }
?>