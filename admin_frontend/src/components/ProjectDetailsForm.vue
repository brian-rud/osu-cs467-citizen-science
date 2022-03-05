<template>
    <div class="container">
        <form @submit.prevent>
            <div class="mb-3">
                <label for="projectTitle">Project Title</label>
                <input type="text" v-model="newProjectDetails.title" class="form-control" :class="{'is-invalid': !newProjectDetails.title && clickedSubmit}" id="projectTitle" aria-describedby="projectTitle" required>
            </div>
            <div class="mb-3">
                <label for="projectCategory" required class="form-label">Project Category</label>
                <input type ="text" v-model="newProjectDetails.category" class="form-control" :class="{'is-invalid': !newProjectDetails.category && clickedSubmit}" id="projectCategory">
                <div id="projCategoryHelp" class="form-text">e.g. Chemistry, Biology, Physics, etc.</div>
            </div>
            <div class="mb-3">
                <label for="projectDescription" class="form-label">Project Description</label>
                <textarea class="form-control" :class="{'is-invalid': !newProjectDetails.description && clickedSubmit}" v-model="newProjectDetails.description" id="projectDescription" required></textarea>
                <div id="projDescHelp" class="form-text">A longer description of the project to help students.</div>
            </div>
            <div class="mb-3">
                <label for="projectPrompt" class="form-label">Project Prompt</label>
                <input type="text" class="form-control" :class="{'is-invalid': !newProjectDetails.prompt && clickedSubmit}" v-model="newProjectDetails.prompt" id="projectPrompt" required>
                <div id="projPromptHelp" class="form-text">Prompt dispayed to students entering obervations e.g. Enter time and temperature readings.</div>
            </div>
                <div class="mb-3">
                <label for="endDate" class="form-label">End Date</label>
                <input type="date" v-model="newProjectDetails.endDate" class="form-control" :class="{'is-invalid': !newProjectDetails.endDate && clickedSubmit}" id="endDate" required>
            </div>
        </form>
        <button type="submit" class="btn btn-primary me-1" @click="submit">Save</button>
        <button type="submit" class="btn btn-danger" @click="$emit('toggleProjectDetailsComponent')">Cancel</button>
    </div>
</template>

<script>
    import axios from "axios";

    export default {
        name: "ProjectDetailsForm",

        props: ["projectDetails"],

        data () {
            return {
                newProjectDetails: {
                    title: this.projectDetails.title,
                    category: this.projectDetails.category,
                    description: this.projectDetails.description,
                    prompt: this.projectDetails.prompt,
                    endDate: this.projectDetails.endDate,
                    ivName: this.projectDetails.ivName,
                    ivType: this.projectDetails.ivType,
                    ivUnits: this.projectDetails.ivUnits,
                    dvName: this.projectDetails.dvName,
                    dvType: this.projectDetails.dvType,
                    dvUnits: this.projectDetails.dvUnits
                },
                clickedSubmit: false
            }
        },

        methods: {
            submit: function() {

                this.clickedSubmit = true;
                let url = `${process.env.VUE_APP_API_URL}/projects/info/${this.projectDetails.id}`;
                let payload = {
                    title: this.newProjectDetails.title,
                    description: this.newProjectDetails.description,
                    prompt: this.newProjectDetails.prompt,
                    category: this.newProjectDetails.category,
                    end_date: this.newProjectDetails.endDate
                };
                
                axios.put(url, payload)
                    .then(() => {
                        this.$store.commit('toggleProjectDetailsChanged');
                        this.$emit('toggleProjectDetailsComponent');
                    })
                    .catch(function(error){
                        console.log(error);
                    })
            }
        },

        emits: ['toggleProjectDetailsComponent']
    }
</script>