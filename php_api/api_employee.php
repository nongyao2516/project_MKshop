<?php
header('Content-Type: application/json');
  // เชื่อมต่อฐานข้อมูล
require 'condb.php';

try {
 //ตรวจสอบคำขอที่ได้รับจาก Client  ตามประเภทของคำ ว่าเป็น GET หรือ POST
    $method = $_SERVER['REQUEST_METHOD'];

    if ($method == 'GET') {
        // ดึงข้อมูลลูกค้าทั้งหมด
        $stmt = $conn->prepare("SELECT * FROM employees");
        $stmt->execute();
        $customers = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode(["success" => true, "data" => $customers]);
    } elseif ($method == 'POST') {
        // รับข้อมูลจาก Client
        $data = json_decode(file_get_contents("php://input"), true);

        // ตรวจสอบค่าที่จำเป็น
        if (isset($data['firstname'], $data['lastname'], $data['position'], $data['salary'])) {
            // เพิ่มข้อมูลลูกค้าใหม่
            $stmt = $conn->prepare("INSERT INTO employees (firstname, lastname, position, salary) VALUES (:firstname, :lastname, :position, :salary)");
            $stmt->bindParam(':firstname', $data['firstname']);
            $stmt->bindParam(':lastname', $data['lastname']);
            $stmt->bindParam(':position', $data['position']);
            $stmt->bindParam(':salary', $data['salary']);
           

            if ($stmt->execute()) {
                echo json_encode(["success" => true, "message" => "Employee added successfully"]);
            } else {
                echo json_encode(["success" => false, "message" => "Error adding customer"]);
            }
        } else {
            echo json_encode(["success" => false, "message" => "Missing required fields"]);
        }
    } else {
        echo json_encode(["success" => false, "message" => "Invalid request method"]);
    }
} catch (PDOException $e) {
    echo json_encode(["success" => false, "message" => "Database error: " . $e->getMessage()]);
}
?>
