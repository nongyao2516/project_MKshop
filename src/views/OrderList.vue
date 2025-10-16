<template>
  <div class="container my-5">
    <h2 class="text-center mb-4">💰 สรุปยอดตามคำสั่งซื้อและโต๊ะ</h2>

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

    <table v-if="orderSummaries.length > 0" class="table table-bordered table-striped mt-3">
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
        <tr v-for="(order, index) in orderSummaries" :key="index">
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
  </div>
</template>

<script>
import { ref, onMounted, computed } from "vue";

export default {
  name: "OrderTableSummary",
  setup() {
    const orders = ref([]);
    const loading = ref(true);
    const error = ref(null);
    const searchText = ref("");

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

    const filteredOrders = computed(() => {
      if (!searchText.value) return orders.value;
      return orders.value.filter(order =>
        order.table_no.toString().includes(searchText.value) ||
        order.order_id.toString().includes(searchText.value)
      );
    });

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

    // ✅ ฟังก์ชันกำหนดสีข้อความตามสถานะ (อัปเดตให้ครอบคลุม)
    const getStatusClass = (status) => {
      status = status.toLowerCase();

      if (status.includes("สำเร็จ") || status.includes("เสร็จ") || status.includes("เสร็จแล้ว")) {
        return "text-success";
      }
      if (status.includes("รอดำเนินการ") || status.includes("รอ") || status.includes("กำลังทำ")) {
        return "text-warning";
      }
      if (status.includes("ยกเลิก") || status.includes("ผิดพลาด")) {
        return "text-danger";
      }
      return "text-secondary";
    };

    return { orders, loading, error, searchText, orderSummaries, getStatusClass };
  },
};
</script>
