<template>
    <div class="container">
        <div class="row mt-4 mb-1">
        <div class="col">
            <h1 style="color:#187bcd">Variable Details</h1>
            <hr style="height:3px;color:green"/>
        </div>
        </div>
        <div class="container">
            <span><strong>IV Name: </strong>{{ projectDetails.ivName }}</span>
        </div>
        <div class="container">
            <span><strong>IV Type: </strong>{{ projectDetails.ivType }}</span>
        </div>
        <div class="container">
            <span><strong>IV Units: </strong>{{ projectDetails.ivUnits }}</span>
        </div>
        <div class="container">
            <span><strong>DV Name: </strong>{{ projectDetails.dvName }}</span>
        </div>
        <div class="container">
            <span><strong>DV Type: </strong>{{ projectDetails.dvType }}</span>
        </div>
        <div class="container">
            <span><strong>DV Units: </strong>{{ projectDetails.dvUnits }}</span>
        </div>
    </div>
</template>

<script>
    export default {
        name: "VariableDetails",
        
        props: ["projectDetails"]
    }
</script>