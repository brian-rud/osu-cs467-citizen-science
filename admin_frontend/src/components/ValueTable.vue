<template>
    <table>
        <tr v-for="(v, index) in values" :key="index">
            <td>{{ v }}</td>
            <td>
                <button type="button" class="btn btn-danger" @click="$emit('DeleteValue', index)">Delete</button>
            </td>

        </tr>
    </table>
</template>

<script>

    export default {
        name: "ValueTable",
        props:[
            "values" 
        ],
        emits: ['DeleteValue']

    }
</script>

