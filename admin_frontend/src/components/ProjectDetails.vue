<template>
    <div class="container">
        <div class="container">
            <span><strong>Title: </strong>{{ projectDetails.title }}</span>
        </div>
        <div class="container">
            <span><strong>Category: </strong>{{ projectDetails.category }}</span>
        </div>
        <div class="container">
            <span><strong>Description: </strong>{{ projectDetails.description }}</span>
        </div>
        <div class="container">
            <span><strong>Prompt: </strong>{{ projectDetails.prompt }}</span>
        </div>
        <div class="container">
            <span><strong>End Date: </strong>{{ projectDetails.endDate }}</span>
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
        <button class="btn btn-primary" @click="$emit('toggleProjectDetailsComponent')">Edit</button>
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal">
            Delete Project
        </button>

        <!-- Modal -->
        <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmDeleteModalLabel">Delete Project</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this project?  This action cannot be undone!
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-danger" @click.prevent="deleteProject">Delete</button>
            </div>
            </div>
        </div>
        </div>

    
    </div>
</template>

<script>
import axios from "axios";


export default {
    name: "ProjectDetails",
    props: ['projectDetails'],
    emits: ['toggleProjectDetailsComponent'],
    data() {
        return {

        }
    },
    methods: {
        deleteProject: function(){
            let url = `${process.env.VUE_APP_API_URL}/projects/info/${this.projectDetails.id}`;
            axios.delete(url).then(() => {
                let modalEl = document.getElementById("confirmDeleteModal")
                let modal = window.bootstrap.Modal.getInstance(modalEl)
                modal.hide();
                this.$router.push({ name: "Projects", params: {successProjDeleteTitle: this.projectDetails.title}})
            });
            
            
        }
    }
}
</script>