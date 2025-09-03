<?php


// เชื่อมต่อฐานข้อมูล
include 'condb.php';

// อ่านข้อมูล JSON จาก POST body
$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['firstname'], $data['lastname'], $data['phone'], $data['username'], $data['password'])) {
    echo json_encode(["error" => "ข้อมูลไม่ครบ"]);
    exit;
}

// ป้องกัน SQL Injection ด้วย prepare statement
$stmt = $conn->prepare("INSERT INTO Customers (firstname, lastname, phone, username, password) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param($data['firstName'], $data['lastName'], $data['phone'], $data['username'], $data['password']);

if ($stmt->execute()) {
    echo json_encode(["success" => "เพิ่มลูกค้าสำเร็จ", "customer_id" => $stmt->insert_id]);
} else {
    echo json_encode(["error" => $stmt->error]);
}

$stmt->close();
$conn->close();
?>
