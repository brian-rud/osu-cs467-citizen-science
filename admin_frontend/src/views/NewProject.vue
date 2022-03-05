<template>
 <main-layout>
   <div class="container">
     <NewProjectForm />
   </div>
 </main-layout>
</template>

<script>
  import MainLayout from "@/layouts/MainLayout.vue";
  import NewProjectForm from "@/components/NewProjectForm";

  export default {
    name: 'Home',
    
    components: {
      MainLayout,
      NewProjectForm
    }
  }
</script>
