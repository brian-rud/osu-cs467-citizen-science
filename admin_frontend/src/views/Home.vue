<template>
 <main-layout>
   <div class="container my-4">
     <div class="row">
       <div class="col-3">
         <img src="../assets/logo.jpeg" alt="logo" width="210" height="200">
       </div>
       <div class="col-6 align-self-center">
         <h1 style="color:#187bcd">Citizen Science App for Kids</h1>
         <h5 class="text-muted">Enabling science to happen anytime and anywhere!</h5>
       </div>
     </div>
     <hr style="height:3px;color:green"/>
     <div class="row">
       <div class="col-10">
         <h2 style="color:#286a67">
           Welcome!
         </h2>
         <p>
           The Citizen Science App for Kids platform consists of this admin website where you
           can create new science experiments and view their results and a cross-platform 
           mobile app which allows your students to post observations to your experiments.
         </p>
       </div>
     </div>
     <div class="row mt-4">
       <div class="col-10">
         <h2 style="color:#286a67">
           Our Goal
         </h2>
         <p>
           This app aims to both improve the scientific community's research
           capacity and spark an interest in science for kids by allowing them
           to contribute to a real live scientific project!
         </p>
       </div>
     </div>
     <div class="row mt-4">
       <div class="col-10">
         <h2 style="color:#286a67">
           Getting Started
         </h2>
         <p>
           Get started by creating an account and signing in.
           Once you're signed in, try creating an interesting science experiment.
         </p>
         <p>
           Need some ideas? Some example projects include collecting temperature data in different parts of the city,
           observing and counting birds at home, and identifying cloud types and sky color.
         </p> 
         <p>
           After your project has been created, you'll receive a project code.
           Students can enter this code on the mobile field app to post observations to your project from anywhere!
         </p>
       </div>
     </div>
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
