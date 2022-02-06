<template>
 <main-layout>
   <div class="container">
   <h1>Projects</h1>
      <div v-for="project in projects" :key="project.title">
        <router-link :to="{ name: 'Project', params: { id: project.project_id }}">{{ project.title }}</router-link>
      </div>
      <div>
        <router-link to="/new_project">Add new project</router-link>
      </div>
   </div>
 </main-layout>
</template>

<script>
import axios from "axios";
import MainLayout from "@/layouts/MainLayout.vue";

export default {
  name: 'Home',
  components: {
    MainLayout
  },
  data(){
    return {
      userId: this.$auth.user.value.sub,
      projects: new Array()
    }

  },

  mounted(){
    let url = `${process.env.VUE_APP_API_URL}/projects/${this.userId}`;
    axios.get(url).then((response) => {
      this.projects = response.data
    })
  }

}
</script>