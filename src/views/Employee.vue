<template>
  <div class="container mt-4">
    <h2 class="mb-3">แสดงข้อมูลพนักงาน</h2>
    
    <div class="mb-3">
      <a class="btn btn-primary" href="/add_employee" role="button">Add+</a>
    </div>

    <!-- ตารางแสดงข้อมูลลูกค้า -->
  <table class="table table-bordered table-striped">
  <thead class="table-primary">
    <tr>
      <th>ID</th>
      <th>ชื่อ</th>
      <th>นามสกุล</th>
      <th>ตำแหน่ง</th>
      <th>เงินเดือน</th>
     
    </tr>
  </thead>
  <tbody>
    <tr v-for="employee in employees" :key="employee.emp_id">
      <td>{{ employee.emp_id }}</td>
      <td>{{ employee.firstname }}</td>
      <td>{{ employee.lastname }}</td>
      <td>{{ employee.position }}</td>
      <td>{{ employee.salary }}</td>
    </tr>
  </tbody>
</table>
    <!-- Loading -->
    <div v-if="loading" class="text-center">
      <p>กำลังโหลดข้อมูล...</p>
    </div>

    <!-- Error -->
    <div v-if="error" class="alert alert-danger">
      {{ error }}
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";

export default {
  name: "EmployeeList",
  setup() {
    const employees = ref([]);
    const loading = ref(true);
    const error = ref(null);

    // ฟังก์ชันดึงข้อมูลจาก API ด้วย GET
    const fetchEmployees = async () => {
      try {
        const response = await fetch("http://localhost/project_41970137_week3/php_api/api_employee.php", {
          method: "GET",
          headers: {
            "Content-Type": "application/json"
          }
        });

        if (!response.ok) {
          throw new Error("ไม่สามารถดึงข้อมูลได้");
        }

        const result = await response.json();
        if (result.success) {
          employees.value = result.data;
        } else {
          error.value = result.message;
        }

      } catch (err) {
        error.value = err.message;
      } finally {
        loading.value = false;
      }
    };

    onMounted(() => {
      fetchEmployees();
    });


    return {
      employees,
      loading,
      error
    };
  
  
  
  }
};
</script>
