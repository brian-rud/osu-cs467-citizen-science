<template>
    <main-layout>
        <div class="container">
            <h1>Project Details</h1>
            <ProjectDetailsContainer :projectDetails="projectDetails" />
            <h1>Observations</h1>
            
            <!-- Button trigger modal -->
            <button v-if="checkedRowKeys.length > 0" type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmDeleteObsModal">
              Delete Selected Observation(s)
            </button>

            <!-- Modal -->
        <div class="modal fade" id="confirmDeleteObsModal" tabindex="-1" aria-labelledby="confirmDeleteObsModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmDeleteObsModalLabel">Delete Observation(s)</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete the selected observation(s)?  This action cannot be undone!
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-danger" @click.prevent="deleteSelectedObservations">Delete</button>
            </div>
            </div>
        </div>
        </div>
            <n-config-provider :theme-overrides="themeOverrides">
            <n-space vertical :size="12">
              <n-data-table
                ref="table"
                :columns="columns"
                :data="obsTableData"
                :pagination="pagination"
                @update:checked-row-keys="handleCheck"
              />
            </n-space>
            </n-config-provider>
            <button v-if="obsTableData.length > 0" class="btn btn-primary" @click="downloadObservations">Download All Observations</button>
        </div>
    </main-layout>
</template>

<script>
import MainLayout from "@/layouts/MainLayout.vue";
import ProjectDetailsContainer from "@/components/ProjectDetailsContainer";
import { NConfigProvider } from 'naive-ui';

import axios from 'axios';

export default {
  name: 'SingleProject',
  components: {
    MainLayout,
    ProjectDetailsContainer,
    NConfigProvider
  },
  data(){
    return{
      projectDetails: {},
      observations: [],
      pagination: { pageSize: 5 },
      checkedRowKeys: [],
      themeOverrides: {
        common: {
          primaryColor: "#0E6DFB",
          primaryColorHover: "#0E6DFB",
          primaryColorPressed: "#0E6DFB",
          primaryColorSuppl: "#0E6DFB",
        }
      }
    }
  },

  watch: {
    projectDetailsChanged(){
      
      if(this.projectDetailsChanged){
        this.getProjectDetails();
      }
    }
  },
  computed:{
    projectDetailsChanged: function(){
      return this.$store.state.projectDetailsChanged
    },
    obsTableData: function(){
      let obsTableData = []
   
      for(const obs of this.observations){
        let obsTableEntry = {
          key: obs.obs_id,
          ivVal: obs.obs_vals.iv_val, 
          dvVal: obs.obs_vals.dv_val,
          obsDate: obs.obs_date,
          deviceId: obs.device_id
        }
        obsTableData.push(obsTableEntry)
      }
      return obsTableData
    },

    columns: function(){
      
      let columns = [
        {
          type: 'selection'
        },
        {
          title: `${this.projectDetails ? this.projectDetails.ivName : ''}${this.projectDetails.ivUnits ? ' (' + this.projectDetails.ivUnits + ')' : ''}`,
          key: 'ivVal',
          defaultSortOrder: 'ascend',
          sorter: 'default'
        },
        {
          title: `${this.projectDetails ? this.projectDetails.dvName : ''}${this.projectDetails.dvUnits ? ' (' + this.projectDetails.dvUnits + ')' : ''}`,
          key: 'dvVal',
          defaultSortOrder: 'ascend',
          sorter: 'default'
        },
        {
          title: 'Observation Date',
          key: 'obsDate',
          defaultSortOrder: 'ascend',
          sorter: 'default'
        },
        {
          title: 'Device ID',
          key: 'deviceId',
          defaultSortOrder: 'ascend',
          sorter: 'default'
        }
      ]
      return columns
    }

  },
  created(){
    this.getProjectDetails()
    this.getResults()
  },
  props: [
      'id'
  ],
  methods: {
    getProjectDetails: function(){
     
     
      axios.get(`${process.env.VUE_APP_API_URL}/projects/info/${this.id}`).then((response) => {
        this.projectDetails.id = this.id;
        this.projectDetails.title = response.data[0].title
        this.projectDetails.description = response.data[0].description
        this.projectDetails.prompt = response.data[0].prompt
        this.projectDetails.category = response.data[0].category
        this.projectDetails.endDate = response.data[0].end_date
        this.projectDetails.ivName = response.data[1].iv_name
        this.projectDetails.ivUnits = response.data[1].iv_units
        this.projectDetails.ivType = response.data[1].iv_type
        this.projectDetails.dvName = response.data[2].dv_name
        this.projectDetails.dvUnits = response.data[2].dv_units
        this.projectDetails.dvType = response.data[2].dv_type
        this.$store.commit('toggleProjectDetailsChanged');
      })
      
    },

    getResults: function(){
      axios.get(`${process.env.VUE_APP_API_URL}/projects/info/${this.id}/results`).then((response) => {
        this.observations = response.data
      })
    },

    handleCheck: function(rowKeys){
        this.checkedRowKeys = rowKeys
    },

    deleteSelectedObservations: function(){
      for(const obsId of this.checkedRowKeys){
        axios.delete(`${process.env.VUE_APP_API_URL}/field_app/${obsId}`).then(() => {
          this.checkedRowKeys = []
          this.observations = this.observations.filter(obs => obs.obs_id !== obsId)
          let modalEl = document.getElementById("confirmDeleteObsModal")
          let modal = window.bootstrap.Modal.getInstance(modalEl)
          modal.hide();
        })
      }
    },

    downloadObservations: function(){
      // source for the code below: https://stackoverflow.com/questions/41938718/how-to-download-files-using-axios
      axios.get(`${process.env.VUE_APP_API_URL}/projects/info/${this.id}/results/download`, {responseType: 'blob'}).then((response) => {
        const type = response.headers['content-type']
        const blob = new Blob([response.data], { type: type, encoding: 'UTF-8' })
        const link = document.createElement('a')
        link.href = window.URL.createObjectURL(blob)
        link.download = 'file.csv'
        link.click()
      })
    }
  },



}
</script>