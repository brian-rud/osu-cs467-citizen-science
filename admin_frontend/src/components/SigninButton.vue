<template>
    <button class="btn btn-primary" @click="login">Log in</button>

</template>

<script>
    export default {
        name: 'SigninButton',
        methods: {
            login() {
                this.$auth.loginWithRedirect();
            },
        }
    }
</script>