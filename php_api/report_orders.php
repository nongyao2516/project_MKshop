<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json; charset=utf-8");
include 'condb.php';

$type = $_GET['type'] ?? 'table'; // default = table

try {
    if ($type === 'daily') {
        $sql = "SELECT DATE(order_date) AS label, SUM(total_price) AS total 
                FROM orders 
                GROUP BY DATE(order_date)
                ORDER BY DATE(order_date)";
    } elseif ($type === 'status') {
        $sql = "SELECT status AS label, COUNT(*) AS total 
                FROM orders 
                GROUP BY status";
    } else {
        // default = table
        $sql = "SELECT table_no AS label, SUM(total_price) AS total 
                FROM orders 
                GROUP BY table_no
                ORDER BY table_no";
    }

    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode(["success" => true, "data" => $data]);
} catch (PDOException $e) {
    echo json_encode(["success" => false, "message" => $e->getMessage()]);
}
?>
