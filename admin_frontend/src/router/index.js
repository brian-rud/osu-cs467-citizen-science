import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/views/Home'
import About from '@/views/About'
import Projects from '@/views/Projects'
import NewProject from '@/views/NewProject'

import Callback from '@/views/Callback'
import ErrorPage from '@/views/Error'

import { routeGuard } from '@/auth'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/about',
    name: 'About',
    component: About,
    //beforeEnter: routeGuard
  },
  {
    path: '/callback',
    name: 'Callback',
    component: Callback
  },
  {
    path: '/error',
    name: 'Error',
    component: ErrorPage,
  },
  {
    path: '/projects',
    name: 'Projects',
    component: Projects,
    beforeEnter: routeGuard
  },
  {
    path: '/project/:id',
    name: 'Project',
    component: About,
    beforeEnter: routeGuard
  },

  {
    path: '/new_project',
    name: 'NewProject',
    component: NewProject,
    beforeEnter: routeGuard
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router