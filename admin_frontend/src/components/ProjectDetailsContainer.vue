<template>
    <div class="container">
        <component :is="currComponent" :projectDetails="projectDetails" @toggleProjectDetailsComponent="toggleComponent"></component>
    </div>
</template>

<script>
import ProjectDetails from "@/components/ProjectDetails"
import ProjectDetailsForm from "@/components/ProjectDetailsForm"

export default {

    name: "ProjectDetailsContainer",
    props: ["projectDetails"],
    emits: ['toggleProjectDetailsComponent'],
    data(){
        return {
            currComponent: ProjectDetails,
            // projectDetails: {
            //     title: "sample title",
            //     prompt: "sample prompt",
            //     category: "sample category",
            //     description: "sample description",
            //     endDate: "2022-02-02",
            //     ivName: "sample ivName",
            //     ivType: "sample ivType",
            //     ivUnits: "sample ivUnits",
            //     dvName: "sample dvName",
            //     dvType: "sample dvType",
            //     dvUnits: "sample dvUnits"
                
            // }
        }
       
    },
    methods: {
        toggleComponent: function() {
            console.log("toggling component - received toggleProjectDetailsComponentEvent")
            this.currComponent.name === "ProjectDetails" ? this.currComponent = ProjectDetailsForm : this.currComponent = ProjectDetails
        }
    }
}
</script>