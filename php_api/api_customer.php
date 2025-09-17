<?php

// เชื่อมต่อฐานข้อมูล
include 'condb.php';

// ✅ จัดการ Preflight request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$response = ["success" => false, "data" => [], "message" => ""];

try {
    $method = $_SERVER['REQUEST_METHOD'];

    if ($method === "GET") {
        // 👉 ดึงข้อมูลลูกค้าทั้งหมด
        $stmt = $conn->prepare("SELECT * FROM customers ORDER BY customer_id ASC");
        $stmt->execute();
        $response["success"] = true;
        $response["data"] = $stmt->fetchAll(PDO::FETCH_ASSOC);

    } elseif ($method === "POST") {
        // 👉 เพิ่มลูกค้าใหม่
        $input = json_decode(file_get_contents("php://input"), true);
        if (!$input) {
            $input = $_POST; // fallback ถ้าเป็น form-data
        }

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
                $errorInfo = $stmt->errorInfo();
                $response["message"] = "Error adding customer: " . $errorInfo[2];
            }
        } else {
            $response["message"] = "Missing required fields";
        }

    } else {
        $response["message"] = "Method not supported";
    }

} catch (PDOException $e) {
    $response["message"] = "Database error: " . $e->getMessage();
}

// ✅ ส่งกลับ JSON
echo json_encode($response);
