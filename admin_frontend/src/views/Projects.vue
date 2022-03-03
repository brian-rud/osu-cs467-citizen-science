<template>
  <main-layout>
    <div class="container">
      <div class="row my-4">
        <div class="col">
          <h1 style="color:#187bcd">Projects</h1>
        </div>
      </div>
      <div class="row my-2">
        <div class="col">
          <router-link to="/new_project">
            <button type="button" class="btn btn-primary">Create New Project</button>
          </router-link>
        </div>
      </div>
      <hr style="height:3px;color:green"/>
      <div class="row row-cols-1 row-cols-4 my-4 g-3">
        <div v-for="project in projects" :key="project.title">
          <div class="col h-100">
            <div class="card h-100">
              <img src="../assets/flask.png" class="card-img-top bg-light p-4">
              <div class="card-body">
                <router-link :to="{ name: 'Project', params: { id: project.project_id, project: project }}">
                  <h5 class="card-title">{{ project.title }}</h5>
                </router-link>
                <p class="card-text">{{ project.description }}</p>
              </div>
              <div class="card-footer">
                <small class="text-muted">Project Code: {{ project.project_code }}</small><br>
                <small class="text-muted">Ends: {{ project.end_date }}</small>
              </div>
            </div>
          </div>
        </div>
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