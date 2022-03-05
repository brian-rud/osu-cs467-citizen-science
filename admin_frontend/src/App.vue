<template>
  <router-view/>
</template>

<script>
  export default {
    name: 'App',

    methods: {
      login() {
        this.$auth.loginWithRedirect();
      },
      
      // Log the user out
      logout() {
        this.$auth.logout({returnTo: window.location.origin});
      }
    }
  }
</script>

<style lang="scss">
</style>