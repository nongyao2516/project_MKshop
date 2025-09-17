<?php
// เชื่อมต่อฐานข้อมูล
include 'condb.php';



// จัดการ preflight request สำหรับ CORS
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$response = ["success" => false, "data" => [], "message" => ""];

try {
    $method = $_SERVER['REQUEST_METHOD'];

    if ($method === "GET") {
        // ดึงข้อมูลลูกค้าทั้งหมด
        $stmt = $conn->prepare("SELECT * FROM customers ORDER BY customer_id DESC");
        $stmt->execute();
        $response["success"] = true;
        $response["data"] = $stmt->fetchAll(PDO::FETCH_ASSOC);
    } 
    elseif ($method === "POST") {
        // เพิ่มลูกค้าใหม่
        $input = $_POST; // หรือ $_POST ถ้า form-data

        if (isset($input["firstName"], $input["lastName"], $input["phone"], $input["username"], $input["password"])) {
            $firstName = $input["firstName"];
            $lastName  = $input["lastName"];
            $phone     = $input["phone"];
            $username  = $input["username"];
            $password  = password_hash($input["password"], PASSWORD_BCRYPT);

            $stmt = $conn->prepare("INSERT INTO customers (firstName, lastName, phone, username, password) VALUES (?, ?, ?, ?, ?)");
            $result = $stmt->execute([$firstName, $lastName, $phone, $username, $password]);

            if ($result) {
                $response["success"] = true;
                $response["message"] = "Customer added successfully";
            } else {
                $response["message"] = "Error adding customer";
            }
        } else {
            $response["message"] = "Missing required fields";
        }
    } 
    else {
        $response["message"] = "Method not supported";
    }
} catch (PDOException $e) {
    $response["message"] = "Database error: " . $e->getMessage();
}

echo json_encode($response);