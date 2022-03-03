<template>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#"><i class="fas fa-flask"></i></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <router-link class="nav-link active" aria-current="page" to="/">Home</router-link>
        </li>
        <li class="nav-item" v-if="$auth.isAuthenticated.value">
          <router-link class="nav-link" to="/projects">Projects</router-link>
        </li>
        
            <li class="nav-item dropdown d-flex me-auto" v-if="$auth.isAuthenticated.value">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                {{$auth.user.value.email}}
                </a>
                <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                <li><a class="dropdown-item" href="#">Account</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><div class="container"><SignoutButton v-if="$auth.isAuthenticated.value" /></div></li>
                </ul>
            </li>
        
      </ul>
      <form class="d-flex">

        <SigninButton v-if="!$auth.isAuthenticated.value" />
        

      </form>
    </div>
  </div>
</nav>
</template>

<script>
import SigninButton from "@/components/SigninButton"
import SignoutButton from "@/components/SignoutButton"
  export default{
      name: "Navbar",

      components: {
          SigninButton,
          SignoutButton
      }
  }
</script>