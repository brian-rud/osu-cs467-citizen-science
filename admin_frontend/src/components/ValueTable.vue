<template>
    <table class="table table-striped">
        <thead>
            <tr>
                <th scope="col" class="justify-content-center">Value</th>
                <th scope="col">Delete</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="(v, index) in values" :key="index">
                <td>{{ v }}</td>
                <td>
                    <button type="button" class="btn btn-danger" @click="$emit('DeleteValue', index)">Delete</button>
                </td>
            </tr>
        </tbody>
    </table>
</template>

<script>
    export default {
        name: "ValueTable",

        props:["values"],

        emits: ["DeleteValue"]
    }
</script>

