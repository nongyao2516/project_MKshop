<template>
  <div class="container mt-4 col-md-4 bg-body-secondary ">
    <h2 class="text-center mb-3">เพิ่มข้อมูลพนักงาน</h2>
    <form @submit.prevent="addEmployee">
      <div class="mb-2">
        <input type="text" v-model="employee.firstname" class="form-control" placeholder="ชื่อ" required />
      </div>
      <div class="mb-2">
        <input type="text" v-model="employee.lastname" class="form-control" placeholder="นามสกุล" required />
      </div>
      <div class="mb-2">
        <input type="text"  v-model="employee.position" class="form-control" placeholder="ตำแหน่ง" required />
      </div>
      <div class="mb-2">
        <input type="number" v-model="employee.salary" class="form-control" placeholder="เงินเดือน" required />
      </div>
     
      <div class="text-center mt-4 ">
      <button type="submit" class="btn btn-primary mb-4">บันทึก</button> &nbsp;
      <button type="reset" class="btn btn-secondary mb-4">ยกเลิก</button>
      </div>
    </form>

    <div v-if="message" class="alert alert-info mt-3">
      {{ message }}
    </div>
  </div>
</template>


<script>
export default {
  data() {
    return {
      employee: {
        firstname: "",
        lastname: "",
        position: "",
        salary: "",
      },
      message: ""
    };
  },
  methods: {
    async addEmployee() {
      try {
        const res = await fetch("http://localhost/project_41970137_week3/php_api/api_employee.php", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(this.employee)
        });
        const data = await res.json();
        this.message = data.message;

        if (data.success) {
          // ✅ เคลียร์ข้อมูลใน textbox หลังบันทึกสำเร็จ
          this.employee = { firstname: "", lastname: "", position: "", salary: ""};
        }

      } catch (err) {
        this.message = "เกิดข้อผิดพลาด: " + err.message;
      }
    }
  }
}
</script>
