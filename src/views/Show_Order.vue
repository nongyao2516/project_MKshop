<template>
  <div class="container my-5">
    <h2 class="text-center mb-4">📋 รายการคำสั่งซื้อทั้งหมด</h2>

    <div class="mb-3">
      <input
        type="text"
        class="form-control"
        placeholder="🔍 ค้นหาตามหมายเลขโต๊ะ..."
        v-model="searchTable"
      />
    </div>

    <div v-if="loading" class="text-center">⏳ กำลังโหลดข้อมูล...</div>
    <div v-if="error" class="text-danger text-center">{{ error }}</div>

    <table v-if="filteredOrders.length > 0" class="table table-bordered table-striped mt-3">
      <thead class="table-primary">
        <tr>
          <th>รหัสคำสั่งซื้อ</th>
          <th>โต๊ะ</th>
          <th>รหัสสินค้า</th>
          <th>สินค้า</th>
          <th>จำนวน</th>
          <th>ราคา/หน่วย</th>
          <th>ราคารวม</th>
          <th>วันที่สั่ง</th>
          <th>สถานะ</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(order, index) in filteredOrders" :key="index">
          <td>{{ order.order_id }}</td>
          <td>{{ order.table_no }}</td>
          <td>{{ order.product_id }}</td>
          <td>{{ order.product_name }}</td>
          <td>{{ order.quantity }}</td>
          <td>{{ Number(order.price).toFixed(2) }}</td>
          <td>{{ Number(order.subtotal).toFixed(2) }}</td>
          <td>{{ order.order_date }}</td>
          <td>
            <select v-model="order.status" @change="updateStatus(order)">
              <option value="รอดำเนินการ">รอดำเนินการ</option>
              <option value="ยกเลิก">ยกเลิก</option>
              <option value="เสร็จแล้ว">เสร็จแล้ว</option>
            </select>
          </td>
        </tr>
      </tbody>
    </table>

    <div v-else-if="!loading" class="text-center text-muted">
      ❗ ยังไม่มีข้อมูลคำสั่งซื้อ
    </div>
  </div>
</template>

<script>
import { ref, onMounted, computed } from "vue";

export default {
  name: "OrderList",
  setup() {
    const orders = ref([]);
    const loading = ref(true);
    const error = ref(null);
    const searchTable = ref("");

    const fetchOrders = async () => {
      try {
        const res = await fetch(
          "http://localhost/project_MK/php_api/show_orders.php"
        );
        const data = await res.json();

        if (data.success) {
          // กำหนดค่าเริ่มต้น status ถ้าไม่มี
          orders.value = data.data.map(o => ({
            ...o,
            status: o.status || "รอดำเนินการ"
          }));
        } else {
          error.value = data.message;
        }
      } catch (err) {
        error.value = err.message;
      } finally {
        loading.value = false;
      }
    };

    onMounted(fetchOrders);

    // กรองรายการตามหมายเลขโต๊ะ
    const filteredOrders = computed(() => {
      if (!searchTable.value) return orders.value;
      return orders.value.filter(order =>
        order.table_no.toString().includes(searchTable.value)
      );
    });

    // อัปเดตสถานะคำสั่งซื้อ
    const updateStatus = async (order) => {
      try {
        const res = await fetch(
          "http://localhost/project_MK/php_api/update_order_status.php",
          {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ order_id: order.order_id, status: order.status })
          }
        );
        const data = await res.json();
        if (!data.success) {
          alert("อัปเดตสถานะไม่สำเร็จ: " + data.message);
        }
      } catch (err) {
        alert("เกิดข้อผิดพลาด: " + err.message);
      }
    };

    return { orders, loading, error, searchTable, filteredOrders, updateStatus };
  },
};
</script>
