import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'


//import "bootstrap/dist/css/bootstrap.css" ;  // bootstrap 5 css
//import "bootstrap/dist/js/bootstrap.bundle.js" ;  // bootstrap 5 js



// ✅ Import Bootstrap ทั้ง CSS และ JS
//import "bootstrap/dist/css/bootstrap.min.css";
//import "bootstrap/dist/js/bootstrap.bundle.min.js"; // รวม Modal, Dropdown, Tooltip ฯลฯ

// ✅ Import Bootstrap
import "bootstrap/dist/css/bootstrap.min.css";
import * as bootstrap from "bootstrap"; // ⭐ import ทั้งโมดูล
window.bootstrap = bootstrap; // ✅ ผูกเข้ากับ global window object



createApp(App).use(store).use(router).mount('#app')
