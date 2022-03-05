<template>
    <div>
        <component :is="currComponent" :projectDetails="projectDetails" @toggleProjectDetailsComponent="toggleComponent"></component>
    </div>
</template>

<script>
    import ProjectDetails from "@/components/ProjectDetails";
    import ProjectDetailsForm from "@/components/ProjectDetailsForm";

    export default {
        name: "ProjectDetailsContainer",

        props: ["projectDetails"],

        emits: ["toggleProjectDetailsComponent"],

        data(){
            return {
                currComponent: ProjectDetails,
            }
        },

        methods: {
            toggleComponent: function() {
                this.currComponent.name === "ProjectDetails" ? this.currComponent = ProjectDetailsForm : this.currComponent = ProjectDetails
            }
        }
    }
</script>