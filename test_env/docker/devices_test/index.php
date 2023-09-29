<?php
function generateRandomIPv4() {
    // Generate a random IPv4 address
    return rand(1, 255) . "." . rand(0, 255) . "." . rand(0, 255) . "." . rand(1, 254);
}

// Sample device names, you can modify them as needed
$devices = array(0, 1, 2);

$deviceData = array(
	"deviceCount" => 3
);

foreach ($devices as $device) {
    // Generate random IPv4 address for each device
    $ipv4 = generateRandomIPv4();

    // Sample router name, you can modify it as needed
    $routerName = "Router-" . rand(1, 10);

    // Sample last log datetime, you can modify it as needed
    $lastLogDatetime = date("Y-m-d H:i:s");

    $deviceData[$device] = array(
        "name" => "device". $device,
        "ipv4" => $ipv4,
        "router" => $routerName,
        "last_log_datetime" => $lastLogDatetime
    );
}

// Convert device data to JSON
$jsonData = json_encode($deviceData, JSON_PRETTY_PRINT);

// Echo the JSON data
header('Content-Type: application/json');
echo $jsonData;
?>

