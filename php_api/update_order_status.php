<?php
include 'condb.php';
header('Content-Type: application/json; charset=utf-8');

$data = json_decode(file_get_contents("php://input"), true);
$order_id = $data['order_id'] ?? null;
$status = $data['status'] ?? null;

if ($order_id && $status) {
    try {
        // อัปเดตสถานะทั้งหมดใน order_items ของคำสั่งซื้อนั้น
        $stmt = $conn->prepare("UPDATE order_items SET status = ? WHERE order_id = ?");
        $stmt->execute([$status, $order_id]);
        
        echo json_encode(["success" => true]);
    } catch (Exception $e) {
        echo json_encode(["success" => false, "message" => $e->getMessage()]);
    }
} else {
    echo json_encode(["success" => false, "message" => "ข้อมูลไม่ครบ"]);
}
?>
