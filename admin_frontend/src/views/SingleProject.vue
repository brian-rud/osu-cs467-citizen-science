<template>
    <main-layout>
        <div class="container">
            <h1>Project {{project.title}} page coming soon</h1>
        </div>
    </main-layout>
</template>

<script>
import MainLayout from "@/layouts/MainLayout.vue";

export default {
  name: 'SingleProject',
  components: {
    MainLayout
  },
  props: {
      project: Object
  }

}
</script>