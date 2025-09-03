<template>
  <div class="container mt-4">
    <h2>เพิ่มลูกค้าใหม่</h2>

    <!-- Form เพิ่มลูกค้า -->
    <form @submit.prevent="submitForm" class="mt-3">
      <div class="mb-3">
        <label class="form-label">ชื่อ</label>
        <input type="text" class="form-control" v-model="firstName" required />
      </div>

      <div class="mb-3">
        <label class="form-label">นามสกุล</label>
        <input type="text" class="form-control" v-model="lastName" required />
      </div>

      <div class="mb-3">
        <label class="form-label">เบอร์โทร</label>
        <input type="text" class="form-control" v-model="phone" required />
      </div>

      <div class="mb-3">
        <label class="form-label">ชื่อผู้ใช้</label>
        <input type="text" class="form-control" v-model="username" required />
      </div>

      <div class="mb-3">
        <label class="form-label">รหัสผ่าน</label>
        <input type="password" class="form-control" v-model="password" required />
      </div>

      <button type="submit" class="btn btn-primary">เพิ่มลูกค้า</button>
    </form>

    <!-- แสดงผลลัพธ์ -->
    <div v-if="successMessage" class="alert alert-success mt-3">{{ successMessage }}</div>
    <div v-if="errorMessage" class="alert alert-danger mt-3">{{ errorMessage }}</div>
  </div>
</template>

<script>
import { ref } from "vue";

export default {
  name: "AddCustomer",
  setup() {
    // ตัวแปรเก็บข้อมูลจากฟอร์ม
    const firstName = ref("");
    const lastName = ref("");
    const phone = ref("");
    const username = ref("");
    const password = ref("");

    // ตัวแปรแสดงผลลัพธ์
    const successMessage = ref("");
    const errorMessage = ref("");

    // ฟังก์ชันส่งข้อมูลไป API
    const submitForm = async () => {
      successMessage.value = "";
      errorMessage.value = "";

      const newCustomer = {
        firstName: firstName.value,
        lastName: lastName.value,
        phone: phone.value,
        username: username.value,
        password: password.value
      };

      try {
        const response = await fetch("http://localhost/project_41970137_vues/php_api/add_customer.php", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(newCustomer)
        });

        const result = await response.json();

        if (result.success) {
          successMessage.value = "เพิ่มลูกค้าสำเร็จ! ID: " + result.customer_id;

          // ล้างฟอร์ม
          firstName.value = "";
          lastName.value = "";
          phone.value = "";
          username.value = "";
          password.value = "";
        } else {
          errorMessage.value = result.error || "เกิดข้อผิดพลาด";
        }
      } catch (err) {
        errorMessage.value = err.message;
      }
    };

    return {
      firstName,
      lastName,
      phone,
      username,
      password,
      successMessage,
      errorMessage,
      submitForm
    };
  }
};
</script>
