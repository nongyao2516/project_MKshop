<?php


include 'condb.php';


try {
    $method = $_SERVER['REQUEST_METHOD'];

    if ($method == 'POST') {
 // ✅ เพิ่มข้อมูลลูกค้าใหม่
        $data = json_decode(file_get_contents("php://input"), true);

        $password_01  = password_hash($data["password"], PASSWORD_BCRYPT);  //เข้ารหัส password 

        $stmt = $conn->prepare("INSERT INTO customers (firstName, lastName, phone, username,password) 
                                VALUES (:firstName, :lastName, :phone, :username, :password)");

        $stmt->bindParam(":firstName", $data["firstName"]);
        $stmt->bindParam(":lastName", $data["lastName"]);
        $stmt->bindParam(":phone", $data["phone"]);
        $stmt->bindParam(":username", $data["username"]);
        $stmt->bindParam(":password",  $password_01);

        if ($stmt->execute()) {
            echo json_encode(["success" => true, "message" => "เพิ่มข้อมูลเรียบร้อย"]);
        } else {
            echo json_encode(["success" => false, "message" => "ไม่สามารถเพิ่มข้อมูลได้"]);
        }
       
    } else {
        echo json_encode(["success" => false, "message" => "Method not allowed"]);
    }
} catch (Exception $e) {
    echo json_encode(["success" => false, "message" => $e->getMessage()]);
}


?>