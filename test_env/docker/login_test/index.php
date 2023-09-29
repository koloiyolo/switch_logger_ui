<?php

header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

// Check if username and password parameters exist in the URL
if (isset($_GET["username"]) && isset($_GET["password"])) {
    // Retrieve username and password from the URL parameters
    $username = $_GET["username"];
    $password = $_GET["password"];

    // Check if the username and password match "admin" and "admin"
    if ($username === "admin" && $password === "admin") {
        echo "Hello, $username!";
    } else {
        $response = array(
            "error" => true,
            "message" => "Authentication error: Incorrect username or password."
        );
        echo json_encode($response);
    }
} else {
    // If username and password parameters are not provided in the URL, display an error message
    $response = array(
        "error" => true,
        "message" => "Username and password parameters are required."
    );
    echo json_encode($response);
}
?>
