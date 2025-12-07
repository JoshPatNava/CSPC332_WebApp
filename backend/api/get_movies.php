<?php
require "../config.php";
// This file is used to retrieve all of the movies
$stmt = $pdo->query("SELECT movie_id, title, year, duration_minutes FROM Movie");
echo json_encode($stmt->fetchAll());
?>