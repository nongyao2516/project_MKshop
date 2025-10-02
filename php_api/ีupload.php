
<?php
include 'condb.php';


if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') exit(0);

if (isset($_FILES['file']) && $_FILES['file']['error'] === 0) {
    $ext = pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION);
    $fileName = uniqid() . '.' . $ext;
    $uploadDir = __DIR__ . '/uploads/';
    if (!is_dir($uploadDir)) mkdir($uploadDir, 0755, true);

    if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadDir . $fileName)) {
        echo json_encode(["success" => true, "fileName" => $fileName]);
    } else {
        echo json_encode(["success" => false, "message" => "ไม่สามารถอัปโหลดไฟล์ได้"]);
    }
} else {
    echo json_encode(["success" => false, "message" => "ไม่พบไฟล์"]);
}
