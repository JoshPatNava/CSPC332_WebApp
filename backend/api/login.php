<?php
// This file is meant to be validating login credentials

$input = json_decode(file_get_contents("php://input"), true);

//Recieve the email and the password
$email = $input["email"] ?? "";
$password = $input["password"] ?? "";

//Look up employee in the database
$stmt = $pdo->prepare("SELECT employee_id, FName, password FROM Employee WHERE email = ?");
$stmt->execute([$email]);
$user = $stmt->fetch();

//Check user 
if (!$user) {
    echo json_encode(["success" => false, "message" => "Invalid credentials"]);
    exit;
}

//Check password
if ($password !== $user["password"]) {
    echo json_encode(["success" => false, "message" => "Invalid credentials"]);
    exit;
}

//Sucess
echo json_encode([
    "success" => true,
    "employee_id" => $user["employee_id"],
    "name" => $user["FName"]
]);
