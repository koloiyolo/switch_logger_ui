<?php
$log = <<<EOL
[2023-09-27 08:00:00] %SYS-5-RESTART: System restarted
[2023-09-27 08:02:15] %LINK-3-UPDOWN: Interface GigabitEthernet0/0, changed state to up
[2023-09-27 08:03:30] %LINEPROTO-5-UPDOWN: Line protocol on Interface GigabitEthernet0/0, changed state to up
[2023-09-27 08:05:45] %SEC-6-IPACCESSLOGP: list 101 denied tcp 192.168.1.2(1024) -> 203.0.113.1(80), 1 packet
[2023-09-27 08:10:12] %BGP-5-ADJCHANGE: neighbor 192.168.1.1 Down BGP Notification received
[2023-09-27 08:15:20] %LINK-3-UPDOWN: Interface Serial0/1, changed state to down
[2023-09-27 08:20:01] %SYS-5-CONFIG_I: Configured from console by admin
[2023-09-27 08:25:55] %SYS-5-CONFIG_I: Configured from SSH by user1
[2023-09-27 08:30:40] %SYS-5-CONFIG_I: Configured from TFTP by user2
[2023-09-27 08:35:10] %SYS-5-CONFIG_I: Configured from SNMP by SNMP manager
[2023-09-27 08:40:45] %OSPF-5-ADJCHG: Process 1, Nbr 192.168.2.1 on GigabitEthernet0/1 from FULL to DOWN
[2023-09-27 08:45:55] %SW_MATM-4-MACFLAP_NOTIF: Host 00:1A:2B:3C:4D:5E in vlan 10 is flapping between port GigabitEthernet0/2 and GigabitEthernet0/3
[2023-09-27 08:50:22] %DHCP-4-PING_CONFLICT: IP address 192.168.1.5 is in conflict with 192.168.1.6
[2023-09-27 10:30:15] %SYS-5-RESTART: System restarted
[2023-09-27 10:32:45] %LINK-3-UPDOWN: Interface GigabitEthernet0/0, changed state to down
[2023-09-27 10:35:10] %LINEPROTO-5-UPDOWN: Line protocol on Interface GigabitEthernet0/0, changed state to down
[2023-09-27 10:38:20] %BGP-5-ADJCHANGE: neighbor 192.168.1.1 Up BGP Notification received
[2023-09-27 10:40:55] %SYS-5-CONFIG_I: Configured from console by admin
[2023-09-27 10:45:30] %SEC-6-IPACCESSLOGP: list 101 permitted udp 192.168.2.1(123) -> 0.0.0.0(123), 1 packet
[2023-09-27 10:50:10] %SW_MATM-4-MACFLAP_NOTIF: Host 00:1A:2B:3C:4D:5E in vlan 10 is flapping between port GigabitEthernet0/2 and GigabitEthernet0/3
EOL;

$lines = explode("\n", $log);
$deviceLogs = array(
    "device0" => array(),
    "device1" => array(),
    "device2" => array()
);

$devices = array("device0", "device1", "device2");
$currentIndex = 0;

foreach ($lines as $line) {
    if (preg_match('/^\[(.*?)\] (%\S+): (.*)/', $line, $matches)) {
        $datetime = $matches[1];
        $error = $matches[2];
        $description = $matches[3];

        // Assign the log entry to the current device
        $currentDevice = $devices[$currentIndex];
        $deviceLogs[$currentDevice][] = array(
            "datetime" => $datetime,
            "error" => $error,
            "description" => $description
        );

        // Rotate to the next device
        $currentIndex = ($currentIndex + 1) % count($devices);
    }
}

// Convert device logs to JSON
$jsonData = json_encode($deviceLogs, JSON_PRETTY_PRINT);

// Echo the JSON data
header('Content-Type: application/json');
echo $jsonData;
?>

