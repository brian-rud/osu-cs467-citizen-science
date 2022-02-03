<template>
 <main-layout>
   <div class="container">
     <h1>
       This is the projects page
     </h1>
     <router-link to="/new_project">Add new project</router-link>
   </div>
 </main-layout>
</template>

<script>
import MainLayout from "@/layouts/MainLayout.vue"

export default {
  name: 'Home',
  components: {
    MainLayout
  }
}
</script>