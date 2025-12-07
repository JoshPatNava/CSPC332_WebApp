<?php 
//Most important functionality which is to search for movies based upon the filters
require "../config.php";

$input = json_decode(file_get_contents("php://input"), true);

// Asks for city, date, and time
$city = $input["city"] ?? "";
$date = $input["date"] ?? "";
$time = $input["time"] ?? "00:00:00";

// Search Database based upon the inputs
$sql = "
SELECT 
    Cinema.name AS cinema_name,
    Cinema.city,
    Movie.title,
    Shows.start_time,
    Shows.end_time,
    Auditorium.name AS auditorium
FROM Shows
JOIN Auditorium ON Shows.auditorium_id = Auditorium.auditorium_id
JOIN Cinema ON Auditorium.cinema_id = Cinema.cinema_id
JOIN Movie ON Shows.movie_id = Movie.movie_id
WHERE Cinema.city = ?
  AND DATE(Shows.start_time) = ?
  AND TIME(Shows.start_time) >= ?
ORDER BY Shows.start_time;
";

$stmt = $pdo->prepare($sql);
$stmt->execute([$city, $date, $time]);
$data  = $stmt->fetchAll();

echo json_encode($data);
?>