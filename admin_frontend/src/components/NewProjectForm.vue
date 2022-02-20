<template>
    <form @submit.prevent>
  
    <div>
        <div class="mb-3">
            <label for="projectTitle">Project Title</label>
            <input type="text" v-model="projectTitle" class="form-control" :class="{'is-invalid': !projectTitle && clickedSubmit}" id="projectTitle" aria-describedby="projectTitle" required>
            <div class="invalid-feedback">Please enter a valid title</div>
            <div id="projectTitldlp" class="form-text">Enter a title for this experiment</div>
        </div>
            <div class="mb-3">
            <label for="projectCategory" required class="form-label">Project Category</label>
            <input type ="text" v-model="projectCategory" class="form-control" :class="{'is-invalid': !projectCategory && clickedSubmit}" id="projectCategory">
        </div>
        <div class="mb-3">
            <label for="projectDescription" class="form-label">Project Description</label>
            <textarea class="form-control" :class="{'is-invalid': !projectDescription && clickedSubmit}" v-model="projectDescription" id="projectDescription" required></textarea>
        </div>
        <div class="mb-3">
            <label for="projectPrompt" class="form-label">Project Prompt</label>
            <input type="text" class="form-control" :class="{'is-invalid': !projectPrompt && clickedSubmit}" v-model="projectPrompt" id="projectPrompt" required>
        </div>
            <div class="mb-3">
            <label for="endDate" class="form-label">End Date</label>
            <input type="date" v-model="endDate" class="form-control" :class="{'is-invalid': !endDate && clickedSubmit}" id="endDate" required>
        </div>
    </div>
  
    <div>
        <div class="mb-3">
            <label for="ivName" class="form-label">Independent Variable Name</label>
            <input type="text" v-model="ivName" class="form-control" :class="{'is-invalid': !ivName && clickedSubmit}" id="ivName" required>
        </div>
        <div class="mb-3">
            <label for="ivUnits" class="form-label">Independent Variable Units</label>
            <input type="text" v-model="ivUnits" class="form-control" id="ivUnits">
        </div>
        <label>Independent Variable Type</label>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="ivType" id="ivTypeString" v-model="ivType" value="string" checked>
            <label class="form-check-label" for="ivTypeString">String</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="ivType" id="ivTypeNum" v-model="ivType" value="number">
            <label class="form-check-label" for="ivTypeNum">Number</label>
        </div>
        <div class="mb-3 form-check">
            <input type="checkbox" v-model="ivRestricted" class="form-check-input" id="ivRestricted">
            <label class="form-check-label" for="ivRestricted">Restrict Independent Variable Values</label>
        </div>
        <div v-if="ivRestricted">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="ivMinMaxSpecify" id="ivMinMax" v-model="ivMinMaxSpecify" value="ivMinMax" checked>
                <label class="form-check-label" for="ivMinMax">Specify IV Min/Max/Num Intervals</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="ivMinMaxSpecify" id="ivSpecify" v-model="ivMinMaxSpecify" value="ivSpecify">
                <label class="form-check-label" for="ivSpecify">Specify IV Values</label>
            </div>
            <div v-if="ivMinMaxSpecify === 'ivMinMax'">
                <div class="mb-3">
                    <label for="ivValueMin" class="form-label">Min Independent Variable Value</label>
                    <input type="text" v-model="ivValues.min" class="form-control" :class="{'is-invalid':!ivValues.min && clickedSubmit}" id="ivValueMin" :required="ivMinMaxSpecify === 'ivMinMax'">
                </div>
                <div class="mb-3">
                    <label for="ivValueMax" class="form-label">Max Independent Variable Value</label>
                    <input type="text" v-model="ivValues.max" class="form-control" :class="{'is-invalid':!ivValues.max && clickedSubmit}" id="ivValueMax" :required="ivMinMaxSpecify === 'ivMinMax'">
                </div>
                <div class="mb-3">
                    <label for="ivValueIntervalSize" class="form-label">Independent Variable Interval Size</label>
                    <input type="text" v-model="ivValues.intSize" class="form-control" :class="{'is-invalid':!ivValues.intSize && clickedSubmit}" id="ivValueIntervalSize" :required="ivMinMaxSpecify === 'ivMinMax'">
                </div>
            </div>
            <div v-if="ivMinMaxSpecify === 'ivSpecify'">
                <div class="mb-3">
                    <label for="ivValues" class="form-label">Independent Variable Values</label>
                    <div class="input-group mb-3">
                        <input type="text" v-model="currIvValue" class="form-control" :class="{'is-invalid':ivValues.values.length === 0 && clickedSubmit}" id="ivValues">
                        <button class="btn btn-primary" @click="addValue(ivValues.values, currIvValue)">Add</button>
                    </div>
                </div>
            </div>
            <div class="container">
                <ValueTable :values="ivValues.values" @delete-value="deleteValue($event, ivValues.values)"/>
            </div>
        </div>
    </div>

    <div>
        <div class="mb-3">
            <label for="dvName" class="form-label" >Dependent Variable Name</label>
            <input type="text" v-model="dvName" class="form-control" id="dvName" :class="{'is-invalid': !dvName && clickedSubmit}" required>
        </div>
        <div class="mb-3">
            <label for="dvUnits" class="form-label">Dependent Variable Units</label>
            <input type="text" v-model="dvUnits" class="form-control" id="ivUnits">
        <label>Dependent Variable Type</label>
        <div class="form-check">
            <input class="form-check-input" v-model="dvType" value="string" type="radio" name="dvType" id="dvTypeString" checked>
            <label class="form-check-label" for="dvTypeString">String</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" v-model="dvType" value="number" type="radio" name="dvType" id="dvTypeNum">
            <label class="form-check-label" for="dvTypeNum">Number</label>
        </div>
        </div>
            <div class="mb-3 form-check">
            <input type="checkbox" v-model="dvRestricted" class="form-check-input" id="dvRestricted">
            <label class="form-check-label" for="dvRestricted">Restrict Dependent Variable Values</label>
        </div>
        <div v-if="dvRestricted">
            <div class="form-check">
                <input class="form-check-input" type="radio" name="dvMinMaxSpecify" id="dvMinMax" v-model="dvMinMaxSpecify" value="dvMinMax" checked>
                <label class="form-check-label" for="dvMinMax">Specify DV Min/Max/Num Intervals</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="dvMinMaxSpecify" id="dvSpecify" v-model="dvMinMaxSpecify" value="dvSpecify">
                <label class="form-check-label" for="dvSpecify">Specify DV Values</label>
            </div>
            <div v-if="dvMinMaxSpecify === 'dvMinMax'">
                <div class="mb-3">
                    <label for="dvValueMin" class="form-label">Min Dependent Variable Value</label>
                    <input type="text" v-model="dvValues.min" class="form-control" :class="{'is-invalid':!dvValues.min && clickedSubmit}" id="dvValueMin" :required="dvMinMaxSpecify === 'dvMinMax'">
                </div>
                <div class="mb-3">
                    <label for="dvValueMax" class="form-label">Max Dependent Variable Value</label>
                    <input type="text" v-model="dvValues.max" class="form-control" :class="{'is-invalid':!dvValues.max && clickedSubmit}" id="dvValueMax" :required="dvMinMaxSpecify === 'dvMinMax'">
                </div>
                <div class="mb-3">
                    <label for="dvValueIntervalSize" class="form-label">Dependent Variable Interval Size</label>
                    <input type="text" v-model="dvValues.intSize" class="form-control" :class="{'is-invalid':!dvValues.intSize && clickedSubmit}" id="dvValueIntervalSize" :required="dvMinMaxSpecify === 'dvMinMax'">
                </div>
            </div>
            <div v-if="dvMinMaxSpecify === 'dvSpecify'">
                <div class="mb-3">
                    <label for="dvValues" class="form-label">Dependent Variable Values</label>
                    <div class="input-group mb-3">
                        <input type="text" v-model="currDvValue" class="form-control" :class="{'is-invalid':dvValues.values.length === 0 && clickedSubmit}" id="dvValues" :required="dvMinMaxSpecify === 'dvSpecify'">
                        <button class="btn btn-primary" @click="addValue(dvValues.values, currDvValue)">Add</button>
                    </div>
                </div>
            </div>
            <div class="container">
                <ValueTable :values="dvValues.values" @delete-value="deleteValue($event, dvValues.values)"/>
            </div>
        </div>
        <button type="submit" class="btn btn-primary" @click="submit">Submit</button>
    </div>


    </form>
  
</template>

<script>
    import axios from "axios";
    import ValueTable from "@/components/ValueTable";



    export default {
        name: "NewProjectForm",
        data () {
            return {
                projectTitle: "",
                projectCategory: "",
                projectDescription: "",
                projectPrompt: "",
                ivValues:{
                    min: null,
                    max: null,
                    intSize: null,
                    values: []
                },
                currIvValue: "",
                endDate: "",
                ivName: "",
                ivUnits: "",
                ivRestricted: false,
                ivType : "string",
                dvName: "",
                dvUnits: "",
                dvRestricted: false,
                dvType : "string",
                dvValues:{
                    min: null,
                    max: null,
                    intSize: null,
                    values: []
                },
                currDvValue: "",
                ivMinMaxSpecify: "ivMinMax",
                dvMinMaxSpecify: "dvMinMax",
                clickedSubmit: false
            }
        },

        methods: {
            submit: function () {
                this.clickedSubmit = true;
                let iv_accepted = {
                    min: null,
                    max: null,
                    interval_size: null,
                    values: null
                };
                let dv_accepted = {
                    min: null,
                    max: null,
                    interval_size: null,
                    values: null
                };

                if(this.ivMinMaxSpecify === "ivMinMax"){
                    iv_accepted.min = this.ivValues.min;
                    iv_accepted.max = this.ivValues.max;
                    iv_accepted.interval_size = this.ivValues.intSize
                }
                else if(this.ivMinMaxSpecify === "ivSpecify"){
                    iv_accepted.values = [...this.ivValues.values]
                }
                if(this.dvMinMaxSpecify === "dvMinMax"){
                    dv_accepted.min = this.dvValues.min;
                    dv_accepted.max = this.dvValues.max;
                    dv_accepted.interval_size = this.dvValues.intSize
                }
                else if(this.dvMinMaxSpecify === "dvSpecify"){
                    dv_accepted.values = [...this.dvValues.values]
                }
       
                let url = `${process.env.VUE_APP_API_URL}/projects/create/${this.$auth.user.value.sub}`;
                let payload = {
                    title: this.projectTitle,
                    description: this.projectDescription,
                    prompt: this.projectPrompt,
                    category: this.projectCategory,
                    end_date: this.endDate,
                    iv_name: this.ivName,
                    iv_type: this.ivType,
                    iv_units: this.ivUnits,
                    iv_accepted: iv_accepted,
                    dv_name: this.dvName,
                    dv_units: this.dvUnits,
                    dv_accepted: dv_accepted,
                    dv_type: this.dvType,
    
                }
                axios.post(url, payload)
                    .then((response) =>  {
                        if(response.status === 200){
                            this.$router.push({ name: "Projects", params: {successProjCode: response.data.project_code }})
                        }
                    })
                    .catch(function(error){
                        console.log(error)
                    })
            },
            addValue: function (values, value){
                if(!values.includes(value) && value !== ""){
                    values.push(value);
                    values.sort()
                }
                this.currIvValue = "";
            },
            deleteValue: function (index, values){
                values.splice(index, 1);
            }
        },
        components: {
            ValueTable, 
        }
        
    }
</script>

