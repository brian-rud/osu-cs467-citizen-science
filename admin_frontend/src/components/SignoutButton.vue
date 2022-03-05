<template>
    <button class="btn btn-primary" @click="logout">Log out</button>
</template>

<script>
    export default {
        name: 'SignoutButton',
        
        methods: {
            logout() {
                this.$auth.logout({returnTo: window.location.origin});
            }
        }
    }
</script>