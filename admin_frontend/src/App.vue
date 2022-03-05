<template>
  <router-view/>
</template>

<script>
  export default {
    name: 'App',

    methods: {

      // login/logout methods source: https://github.com/lstyles/vue3-auth0-sample
      login() {
        this.$auth.loginWithRedirect();
      },
      
      logout() {
        this.$auth.logout({returnTo: window.location.origin});
      }
    }
  }
</script>

<style lang="scss">
</style>