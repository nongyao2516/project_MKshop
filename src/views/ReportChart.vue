<template>
  <div class="container my-5">
    <h2 class="text-center mb-4">📊 รายงานยอดขาย (Bar Chart)</h2>
    <Bar :data="chartData" :options="chartOptions" />
  </div>
</template>

<script>
import { Bar } from 'vue-chartjs'
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
} from 'chart.js'

// ลงทะเบียน components ของ Chart.js
ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
  name: 'ReportChart',
  components: { Bar },
  data() {
    return {
      chartData: {
        labels: [], // จะเติมด้วยข้อมูลจากฐานข้อมูล
        datasets: [
          {
            label: 'ยอดขายรวม (บาท)',
            backgroundColor: '#42A5F5',
            data: [],
          },
        ],
      },
      chartOptions: {
        responsive: true,
        plugins: {
          legend: {
            position: 'top',
          },
          title: {
            display: true,
            text: 'รายงานยอดขายจากตาราง Orders',
          },
        },
      },
    }
  },
  mounted() {
    // โหลดข้อมูลจาก PHP API
    fetch('http://localhost/project_MK/php_api/get_orders_report.php')
      .then((res) => res.json())
      .then((data) => {
        this.chartData.labels = data.map((item) => item.date)
        this.chartData.datasets[0].data = data.map((item) => item.total)
      })
      .catch((err) => console.error('Error:', err))
  },
}
</script>
