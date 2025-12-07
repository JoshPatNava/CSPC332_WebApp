<?php
require "../config.php";
//Display all of the showings without any of the sorting
$sql = "
SELECT 
    Shows.show_id,
    Movie.title,
    Auditorium.name AS auditorium,
    Cinema.name AS cinema,
    Shows.start_time,
    Shows.end_time
FROM Shows
JOIN Movie ON Shows.movie_id = Movie.movie_id
JOIN Auditorium ON Shows.auditorium_id = Auditorium.auditorium_id
JOIN Cinema ON Auditorium.cinema_id = Cinema.cinema_id
ORDER BY Shows.start_time;
";

$stmt = $pdo->query($sql);
echo json_encode($stmt->fetchAll());
?>