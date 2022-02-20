import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/views/Home'
import Projects from '@/views/Projects'
import NewProject from '@/views/NewProject'
import SingleProject from '@/views/SingleProject'

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
    beforeEnter: routeGuard,
    props: true
  },
  {
    path: '/project/:id',
    name: 'Project',
    component: SingleProject,
    beforeEnter: routeGuard,
    props: true
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