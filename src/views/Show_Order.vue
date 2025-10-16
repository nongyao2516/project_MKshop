<template>
  <div class="container my-5">
    <h2 class="text-center mb-4">📋 รายการคำสั่งซื้อทั้งหมด</h2>

    <!-- 🔍 ค้นหาตามหมายเลขโต๊ะ -->
    <div class="mb-3 d-flex justify-content-between align-items-center">
      <input
        type="text"
        class="form-control w-50"
        placeholder="🔍 ค้นหาตามหมายเลขโต๊ะ..."
        v-model="searchTable"
      />

      <!-- 🔢 เลือกจำนวนต่อหน้า -->
      <div>
        <label class="me-2">แสดงต่อหน้า:</label>
        <select v-model.number="rowsPerPage" class="form-select d-inline-block w-auto">
          <option :value="5">5</option>
          <option :value="10">10</option>
          <option :value="20">20</option>
          <option :value="50">50</option>
        </select>
      </div>
    </div>

    <!-- ⏳ กำลังโหลด -->
    <div v-if="loading" class="text-center">⏳ กำลังโหลดข้อมูล...</div>
    <div v-if="error" class="text-danger text-center">{{ error }}</div>

    <!-- 📋 ตารางแสดงข้อมูล -->
    <table v-if="paginatedOrders.length > 0" class="table table-bordered table-striped mt-3">
      <thead class="table-primary text-center">
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
        <tr v-for="(order, index) in paginatedOrders" :key="index">
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

    <!-- ❗ ไม่มีข้อมูล -->
    <div v-else-if="!loading" class="text-center text-muted">
      ❗ ยังไม่มีข้อมูลคำสั่งซื้อ
    </div>

    <!-- 📄 ปุ่มเปลี่ยนหน้า -->
    <div v-if="totalPages > 1" class="d-flex justify-content-center align-items-center mt-4">
      <button
        class="btn btn-secondary me-2"
        :disabled="currentPage === 1"
        @click="currentPage--"
      >
        ⬅ ก่อนหน้า
      </button>

      <span>หน้า {{ currentPage }} จาก {{ totalPages }}</span>

      <button
        class="btn btn-secondary ms-2"
        :disabled="currentPage === totalPages"
        @click="currentPage++"
      >
        ถัดไป ➡
      </button>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, computed, watch } from "vue";

export default {
  name: "OrderList",
  setup() {
    const orders = ref([]);
    const loading = ref(true);
    const error = ref(null);
    const searchTable = ref("");
    const currentPage = ref(1);
    const rowsPerPage = ref(10); // 👈 กำหนดค่าเริ่มต้น 10 แถวต่อหน้า

    const fetchOrders = async () => {
      try {
        const res = await fetch("http://localhost/project_MK/php_api/show_orders.php");
        const data = await res.json();

        if (data.success) {
          orders.value = data.data.map((o) => ({
            ...o,
            status: o.status || "รอดำเนินการ",
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

    // 🔍 กรองตามโต๊ะ
    const filteredOrders = computed(() => {
      if (!searchTable.value) return orders.value;
      return orders.value.filter((order) =>
        order.table_no.toString().includes(searchTable.value)
      );
    });

    // 📄 คำนวณหน้า
    const totalPages = computed(() =>
      Math.ceil(filteredOrders.value.length / rowsPerPage.value)
    );

    // 📋 ข้อมูลเฉพาะหน้านั้น ๆ
    const paginatedOrders = computed(() => {
      const start = (currentPage.value - 1) * rowsPerPage.value;
      return filteredOrders.value.slice(start, start + rowsPerPage.value);
    });

    // 🔄 เมื่อเปลี่ยนแถวต่อหน้า ให้กลับไปหน้า 1
    const resetPage = () => {
      currentPage.value = 1;
    };
    watch(rowsPerPage, resetPage);

    // ✅ อัปเดตสถานะ
    const updateStatus = async (order) => {
      try {
        const res = await fetch("http://localhost/project_MK/php_api/update_order_status.php", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            order_id: order.order_id,
            status: order.status,
          }),
        });
        const data = await res.json();
        if (!data.success) {
          alert("อัปเดตสถานะไม่สำเร็จ: " + data.message);
        }
      } catch (err) {
        alert("เกิดข้อผิดพลาด: " + err.message);
      }
    };

    return {
      orders,
      loading,
      error,
      searchTable,
      currentPage,
      rowsPerPage,
      totalPages,
      paginatedOrders,
      updateStatus,
    };
  },
};
</script>

<style scoped>
.table {
  font-size: 0.95rem;
}
select {
  border-radius: 8px;
  padding: 4px 8px;
}
</style>
