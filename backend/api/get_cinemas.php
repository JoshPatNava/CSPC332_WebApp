<?php
require "../config.php";
// This file is meant to retrieve all cinemas
$stmt = $pdo->query("SELECT cinema_id, name, city, state FROM Cinema");
echo json_encode($stmt->fetchAll());
?>