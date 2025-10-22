import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";

const routes = [
  {
    path: "/home",
    name: "home",
    component: HomeView,
  },
  {
    path: "/about",
    name: "about",
    component: () => import("../views/AboutView.vue"),
  },
  {
    path: "/showproduct",
    name: "showproduct",
    component: () => import("../views/ShowProduct.vue"),
  },
  {
    path: "/customer",
    name: "customer",
    component: () => import("../views/Customer.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/add_customer",
    name: "add_customer",
    component: () => import("../views/Add_customer.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/products",
    name: "products",
    component: () => import("../views/Products.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/add_product",
    name: "add_product",
    component: () => import("../views/Add_product.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/sh_product",
    name: "sh_product",
    component: () => import("../views/sh_product.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/AddProduct",
    name: "AddProduct",
    component: () => import("../views/AddProduct.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/customer_edit",
    name: "customer_edit",
    component: () => import("../views/Customer_edit.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/product_edit",
    name: "product_edit",
    component: () => import("../views/product_edit.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/employee",
    name: "employee",
    component: () => import("../views/Employee.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/add_employee",
    name: "add_employee",
    component: () => import("../views/Add_employee.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/",
    name: "productList",
    component: () => import("../views/ProductList.vue"),
  },
  {
    path: "/orders",
    name: "OrderList",
    component: () => import("../views/OrderList.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/show_orders",
    name: "show_orders",
    component: () => import("../views/Show_Order.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/login",
    name: "login",
    component: () => import("../views/login.vue"),
  },
  {
    path: "/report",
    name: "ReportChart",
    component: () => import("../views/ReportChart.vue"),
    meta: { requiresAuth: true },
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

// 🧠 Navigation Guard — ตรวจสอบการเข้าสู่ระบบ
router.beforeEach((to, from, next) => {
  const isLoggedIn = localStorage.getItem("adminLogin") === "true";

  // ถ้าหน้านั้นต้องล็อกอินก่อน แต่ยังไม่ได้ล็อกอิน
  if (to.meta.requiresAuth && !isLoggedIn) {
    alert("⚠ กรุณาเข้าสู่ระบบก่อนใช้งานหน้านี้");
    next("/login");
  }
  // ถ้าเข้าสู่ระบบแล้วแต่พยายามกลับไปหน้า login อีก → ส่งกลับหน้าแรก
  else if (to.path === "/login" && isLoggedIn) {
    next("/");
  } 
  // อื่น ๆ ไปต่อได้ตามปกติ
  else {
    next();
  }
});

export default router;
