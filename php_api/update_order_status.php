<?php
include 'condb.php';
header('Content-Type: application/json; charset=utf-8');

$data = json_decode(file_get_contents("php://input"), true);
$order_id = $data['order_id'] ?? null;
$status = $data['status'] ?? null;

if ($order_id && $status) {
    try {
        $conn->beginTransaction(); // เริ่ม transaction

        // อัปเดตสถานะใน order_items
        $stmt1 = $conn->prepare("UPDATE order_items SET status = ? WHERE order_id = ?");
        $stmt1->execute([$status, $order_id]);

        // อัปเดตสถานะใน orders
        $stmt2 = $conn->prepare("UPDATE orders SET status = ? WHERE id = ?");
        $stmt2->execute([$status, $order_id]);

        $conn->commit(); // commit transaction

        echo json_encode(["success" => true]);
    } catch (Exception $e) {
        $conn->rollBack(); // rollback ถ้ามี error
        echo json_encode(["success" => false, "message" => $e->getMessage()]);
    }
} else {
    echo json_encode(["success" => false, "message" => "ข้อมูลไม่ครบ"]);
}
?>
