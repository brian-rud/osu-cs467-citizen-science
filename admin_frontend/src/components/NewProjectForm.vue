<template>
    <form @submit.prevent>
    <div class="mb-3">
        <label for="projectTitle" class="form-label">Project Title</label>
        <input type="text" v-model="projectTitle" class="form-control" id="projectTitle" aria-describedby="projectTitle">
        <div id="projectTitldlp" class="form-text">Enter a title for this experiment</div>
    </div>
        <div class="mb-3">
        <label for="projectCategory" class="form-label">Project Category</label>
        <input type ="text" v-model="projectCategory" class="form-control" id="projectCategory">
    </div>
    <div class="mb-3">
        <label for="projectDescription" class="form-label">Project Description</label>
        <textarea class="form-control" v-model="projectDescription" id="projectDescription"></textarea>
    </div>
        <div class="mb-3">
        <label for="endDate" class="form-label">End Date</label>
        <input type="date" v-model="endDate" class="form-control" id="endDate">
    </div>
    <div class="mb-3">
        <label for="ivName" class="form-label">Independent Variable Name</label>
        <input type="text" v-model="ivName" class="form-control" id="ivName">
    </div>
    <div class="mb-3">
        <label for="ivUnits" class="form-label">Independent Variable Units</label>
        <input type="text" v-model="ivUnits" class="form-control" id="ivUnits">
    </div>
    <label>Independent Variable Type</label>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="ivType" id="ivTypeString" v-model="ivType" value="String">
        <label class="form-check-label" for="ivTypeString">String</label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="ivType" id="ivTypeNum" v-model="ivType" value="Number">
        <label class="form-check-label" for="ivTypeNum">Number</label>
    </div>
    <div class="mb-3 form-check">
        <input type="checkbox" v-model="ivRestricted" class="form-check-input" id="ivRestricted">
        <label class="form-check-label" for="ivRestricted">Restrict Independent Variable Values</label>
    </div>
    <div class="mb-3">
        <label for="dvName" class="form-label">Dependent Variable Name</label>
        <input type="text" v-model="dvName" class="form-control" id="dvName">
    </div>
    <div class="mb-3">
        <label for="dvUnits" class="form-label">Dependent Variable Units</label>
        <input type="text" v-model="dvUnits" class="form-control" id="ivUnits">
    <label>Dependent Variable Type</label>
    <div class="form-check">
        <input class="form-check-input" v-model="dvType" value="String" type="radio" name="ivType" id="dvTypeString">
        <label class="form-check-label" for="dvTypeString">String</label>
    </div>
    <div class="form-check">
        <input class="form-check-input" v-model="dvType" value="Number" type="radio" name="ivType" id="dvTypeNum">
        <label class="form-check-label" for="dvTypeNum">Number</label>
    </div>
    </div>
        <div class="mb-3 form-check">
        <input type="checkbox" v-model="dvRestricted" class="form-check-input" id="dvRestricted">
        <label class="form-check-label" for="dvRestricted">Restrict Dependent Variable Values</label>
    </div>
    
    <button type="submit" class="btn btn-primary" @click="submit">Submit</button>
    </form>
</template>

<script>
    import axios from "axios"

    export default {
        name: "NewProjectForm",
        data () {
            return {
                projectTitle: "",
                projectCategory: "",
                projectDescription: "",
                endDate: "",
                ivName: "",
                ivUnits: "",
                ivRestricted: false,
                ivType : "",
                dvName: "",
                dvUnits: "",
                dvRestricted: false,
                dvType : ""
            }
        },
        methods: {
            submit: function () {
                let url = `${process.env.VUE_APP_API_URL}/projects/create/${this.$auth.user.value.sub}`;
                let payload = {
                    title: this.projectTitle,
                    description: this.projectDescription,
                    prompt: "",
                    category: this.projectCategory,
                    end_date: this.endDate,
                    iv_name: this.ivName,
                    iv_type: this.ivType,
                    iv_units: this.ivUnits,
                    iv_accepted: {},
                    dv_name: this.dvName,
                    dv_units: this.dvUnits,
                    dv_accepted: [],
                    dv_type: this.dvType
                }
                axios.post(url, payload)
                    .then(function(response) {
                        console.log(response)
                    })
                    .catch(function(error){
                        console.log(error)
                    })
            }
        }
        
    }
</script>