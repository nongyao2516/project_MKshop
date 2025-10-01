import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/about',
    name: 'about',
    component: () => import('../views/AboutView.vue')
  },
  {
    path: '/showproduct',
    name: 'showproduct',
    component: () => import('../views/ShowProduct.vue')
  },
  {
    path: '/customer',
    name: 'customer',
    component: () => import('../views/Customer.vue')
  },
   {
    path: '/add_customer',
    name: 'add_customer',
    component: () => import('../views/Add_customer.vue')
  },
     {
    path: '/products',
    name: 'products',
    component: () => import('../views/Products.vue')
  },
   {
    path: '/add_product',
    name: 'add_product',
    component: () => import('../views/Add_product.vue')
  },
     {
    path: '/sh_product',
    name: 'sh_product',
    component: () => import('../views/sh_product.vue')
  },
      {
    path: '/AddProduct',
    name: 'AddProduct',
    component: () => import('../views/AddProduct.vue')
  },
  {
    path: '/customer_edit',
    name: 'customer_edit',
    component: () => import('../views/Customer_edit.vue')
  }





]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
