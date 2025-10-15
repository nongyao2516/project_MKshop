<?php
include 'condb.php';


$data = json_decode(file_get_contents("php://input"), true);
$table = $data['table_no'];
$items = $data['items'];
$total = $data['total'];

try {
    // บันทึกคำสั่งซื้อ
    $stmt = $conn->prepare("INSERT INTO orders (table_no, total_price, order_date) VALUES (?, ?, NOW())");
    $stmt->execute([$table, $total]);
    $order_id = $conn->lastInsertId();

    // บันทึกรายการสินค้า
    foreach ($items as $item) {
        $quantity = $item['quantity'];
        $price = $item['price'];
        $subtotal = $quantity * $price;

        $stmtItem = $conn->prepare("INSERT INTO order_items (order_id, product_id, quantity, price, subtotal) VALUES (?, ?, ?, ?, ?)");
        $stmtItem->execute([$order_id, $item['product_id'], $quantity, $price, $subtotal]);
    }

    echo json_encode(["success" => true, "message" => "บันทึกคำสั่งซื้อเรียบร้อย"]);
} catch (Exception $e) {
    echo json_encode(["success" => false, "message" => $e->getMessage()]);
}
?>
