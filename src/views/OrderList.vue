<template>
  <div class="container my-5">
    <h2 class="text-center mb-4">💰 สรุปยอดตามคำสั่งซื้อและโต๊ะ</h2>

    <!-- 🔍 กล่องค้นหา -->
    <div class="mb-3">
      <input
        type="text"
        class="form-control"
        placeholder="🔍 ค้นหาตามโต๊ะหรือรหัสคำสั่งซื้อ..."
        v-model="searchText"
      />
    </div>

    <div v-if="loading" class="text-center">⏳ กำลังโหลดข้อมูล...</div>
    <div v-if="error" class="text-danger text-center">{{ error }}</div>

    <!-- ✅ ตารางสรุป -->
    <table
      v-if="paginatedOrders.length > 0"
      class="table table-bordered table-striped mt-3"
    >
      <thead class="table-primary">
        <tr>
          <th>รหัสคำสั่งซื้อ</th>
          <th>โต๊ะ</th>
          <th>จำนวนรายการ</th>
          <th>ยอดรวมทั้งหมด</th>
          <th>สถานะ</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(order, index) in paginatedOrders" :key="index">
          <td>{{ order.order_id }}</td>
          <td>{{ order.table_no }}</td>
          <td>{{ order.items_count }}</td>
          <td>{{ order.total_amount.toFixed(2) }}</td>
          <td>
            <span
              v-for="(st, i) in order.status.split(', ')"
              :key="i"
              :class="['fw-bold', 'me-2', getStatusClass(st.trim())]"
            >
              {{ st }}
            </span>
          </td>
        </tr>
      </tbody>
    </table>

    <div v-else-if="!loading" class="text-center text-muted">
      ❗ ยังไม่มีข้อมูลคำสั่งซื้อ
    </div>

    <!-- ✅ ตัวควบคุมการแบ่งหน้า -->
    <div v-if="orderSummaries.length > 0" class="d-flex justify-content-between align-items-center mt-4">
      <div>
        แสดง
        <select v-model.number="rowsPerPage" class="form-select d-inline-block w-auto mx-2">
          <option v-for="n in [5, 10, 20, 50]" :key="n" :value="n">{{ n }}</option>
        </select>
        แถวต่อหน้า
      </div>

      <div class="d-flex align-items-center gap-2">
        <button class="btn btn-outline-primary btn-sm" @click="prevPage" :disabled="currentPage === 1">
          ◀ ก่อนหน้า
        </button>

        <span>หน้า {{ currentPage }} / {{ totalPages }}</span>

        <button class="btn btn-outline-primary btn-sm" @click="nextPage" :disabled="currentPage === totalPages">
          ถัดไป ▶
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, computed, watch } from "vue";

export default {
  name: "OrderTableSummary",
  setup() {
    const orders = ref([]);
    const loading = ref(true);
    const error = ref(null);
    const searchText = ref("");

    // 📘 Pagination states
    const currentPage = ref(1);
    const rowsPerPage = ref(10);

    // 📡 ดึงข้อมูล
    const fetchOrders = async () => {
      try {
        const res = await fetch("http://localhost/project_MK/php_api/show_orders.php");
        const data = await res.json();

        if (data.success) {
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

    // 🔎 ค้นหา
    const filteredOrders = computed(() => {
      if (!searchText.value) return orders.value;
      return orders.value.filter(order =>
        order.table_no.toString().includes(searchText.value) ||
        order.order_id.toString().includes(searchText.value)
      );
    });

    // 📊 สรุปยอดตามคำสั่งซื้อ + โต๊ะ
    const orderSummaries = computed(() => {
      const summary = {};
      filteredOrders.value.forEach(order => {
        const key = `${order.order_id}-${order.table_no}`;
        if (!summary[key]) {
          summary[key] = {
            order_id: order.order_id,
            table_no: order.table_no,
            total_amount: 0,
            items_count: 0,
            statusSet: new Set()
          };
        }
        summary[key].total_amount += Number(order.subtotal);
        summary[key].items_count += 1;
        summary[key].statusSet.add(order.status);
      });

      return Object.values(summary).map(s => ({
        order_id: s.order_id,
        table_no: s.table_no,
        total_amount: s.total_amount,
        items_count: s.items_count,
        status: Array.from(s.statusSet).join(", ")
      }));
    });

    // 📄 Pagination
    const totalPages = computed(() => Math.ceil(orderSummaries.value.length / rowsPerPage.value));

    const paginatedOrders = computed(() => {
      const start = (currentPage.value - 1) * rowsPerPage.value;
      return orderSummaries.value.slice(start, start + rowsPerPage.value);
    });

    const nextPage = () => {
      if (currentPage.value < totalPages.value) currentPage.value++;
    };

    const prevPage = () => {
      if (currentPage.value > 1) currentPage.value--;
    };

    // รีเซ็ตไปหน้าแรกเมื่อเปลี่ยนจำนวนแถว
    watch(rowsPerPage, () => {
      currentPage.value = 1;
    });

    // 🎨 ฟังก์ชันกำหนดสีสถานะ
    const getStatusClass = (status) => {
      status = status.toLowerCase();

      if (status.includes("เสร็จ") || status.includes("สำเร็จ")) {
        return "text-success";
      }
      if (status.includes("รอดำเนินการ") || status.includes("กำลังทำ")) {
        return "text-warning";
      }
      if (status.includes("ยกเลิก")) {
        return "text-danger";
      }
      return "text-secondary";
    };

    return {
      orders,
      loading,
      error,
      searchText,
      orderSummaries,
      paginatedOrders,
      currentPage,
      rowsPerPage,
      totalPages,
      nextPage,
      prevPage,
      getStatusClass
    };
  },
};
</script>

<style scoped>
select.form-select {
  min-width: 80px;
}
.table th, .table td {
  vertical-align: middle;
}
</style>
