<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
      <div class="me-1">
        <i class="fas fa-flask"></i>
      </div>
      <button class="navbar-toggler ms-auto justify-content-end" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mb-2 mb-lg-0 flex-grow-1">
          <li class="nav-item">
            <router-link class="nav-link" :class="route === '/' ? 'active' : ''" aria-current="page" to="/">Home</router-link>
          </li>
          <li class="nav-item" v-if="$auth.isAuthenticated.value">
            <router-link class="nav-link" to="/projects" :class="route === '/projects' ? 'active' : ''" :successProjCode="''">Projects</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link" :class="route === '/new_project' ? 'active' : ''" aria-current="page" to="/new_project">Add Project</router-link>
          </li>
          <li class="ms-auto nav-item dropdown" v-if="$auth.isAuthenticated.value">
            <a class="nav-link dropdown-toggle ms-auto" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              {{$auth.user.value.email}}
            </a>
            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
              <li><div class="container"><SignoutButton v-if="$auth.isAuthenticated.value" /></div></li>
            </ul>
          </li>
        </ul>
      </div>
      <form class="d-flex">
        <SigninButton v-if="!$auth.isAuthenticated.value" />
      </form>
    </div>
  </nav>
</template>

<script>
  import SigninButton from "@/components/SigninButton";
  import SignoutButton from "@/components/SignoutButton";

  export default {
      name: "Navbar",

      components: {
          SigninButton,
          SignoutButton
      },
      
      data(){
        return {
          route: this.$route.path
        }
      }
  }
</script>