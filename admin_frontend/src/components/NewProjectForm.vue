<template>
    <form @submit.prevent>
        <div class="row mt-4 mb-1">
            <div class="col">
                <h1 style="color:#187bcd">Project Details</h1>
                <hr style="height:3px;color:green"/>
            </div>
        </div>
        <div class="container">
            <div class="mb-3">
                <label for="projectTitle">Project Title</label>
                <input type="text" v-model="projectTitle" class="form-control" :class="{'is-invalid': !projectTitle && clickedSubmit}" id="projectTitle" aria-describedby="projectTitle" placeholder="required" required>
            </div>
                <div class="mb-3">
                <label for="projectCategory" required class="form-label">Project Category</label>
                <input type ="text" v-model="projectCategory" class="form-control" :class="{'is-invalid': !projectCategory && clickedSubmit}" id="projectCategory" placeholder="required">
                <div id="projCategoryHelp" class="form-text">e.g. Chemistry, Biology, Physics, etc.</div>
            </div>
            <div class="mb-3">
                <label for="projectDescription" class="form-label">Project Description</label>
                <textarea class="form-control" :class="{'is-invalid': !projectDescription && clickedSubmit}" v-model="projectDescription" id="projectDescription" placeholder="required" required></textarea>
                <div id="projDescHelp" class="form-text">A longer description of the project to help students.</div>
            </div>
            <div class="mb-3">
                <label for="projectPrompt" class="form-label">Project Prompt</label>
                <input type="text" class="form-control" :class="{'is-invalid': !projectPrompt && clickedSubmit}" v-model="projectPrompt" id="projectPrompt" placeholder="required" required>
                <div id="projPromptHelp" class="form-text">Prompt dispayed to students entering obervations e.g. Enter time and temperature readings.</div>
            </div>
                <div class="mb-3">
                <label for="endDate" class="form-label">End Date</label>
                <input type="date" v-model="endDate" class="form-control" :class="{'is-invalid': !endDate && clickedSubmit}" id="endDate" required>
            </div>
        </div>
        <div class="row mt-4 mb-1">
            <div class="col">
                <h1 style="color:#187bcd">Independent Variable (IV)</h1>
                <hr style="height:3px;color:green"/>
            </div>
        </div>
        <div class="container">
            <div class="mb-3">
                <label for="ivName" class="form-label">Independent Variable Name</label>
                <input type="text" v-model="ivName" class="form-control" :class="{'is-invalid': !ivName && clickedSubmit}" id="ivName" placeholder="required" required>
            </div>
            <div class="mb-3">
                <label for="ivUnits" class="form-label">Independent Variable Units</label>
                <input type="text" v-model="ivUnits" class="form-control" id="ivUnits">
            </div>
            <div class="mb-3">
                <label>Independent Variable Type</label>
                <div class="container">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="ivType" id="ivTypeString" v-model="ivType" value="string" checked>
                        <label class="form-check-label" for="ivTypeString">Text</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="ivType" id="ivTypeNum" v-model="ivType" value="number">
                        <label class="form-check-label" for="ivTypeNum">Number</label>
                    </div>
                </div>
            </div>
            <div class="form-check mb-1">
                <input type="checkbox" v-model="ivRestricted" class="form-check-input" id="ivRestricted">
                <label class="form-check-label" for="ivRestricted">Restrict Independent Variable Values</label>
                <div id="restrictIvHelp" class="form-text">Check if you want to limit IV values that can be entered in the field app.</div>
            </div>
            <div class="container" v-if="ivRestricted">
                <div class="container" v-if="ivType === 'number'">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="ivMinMaxSpecify" id="ivMinMax" v-model="ivMinMaxSpecify" value="ivMinMax" checked>
                        <label class="form-check-label" for="ivMinMax">Specify IV Min/Max/Interval Size</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="ivMinMaxSpecify" id="ivSpecify" v-model="ivMinMaxSpecify" value="ivSpecify">
                        <label class="form-check-label" for="ivSpecify">Specify IV Values</label>
                    </div>
                </div>
                <div class="container" v-if="ivMinMaxSpecify === 'ivMinMax' && ivType === 'number'">
                    <div class="container">
                        <div class="mb-3">
                            <label for="ivValueMin" class="form-label">Min Independent Variable Value</label>
                            <input type="number" v-model="ivValues.min" class="form-control" :class="{'is-invalid':!ivValues.min && clickedSubmit}" id="ivValueMin" :required="ivMinMaxSpecify === 'ivMinMax'" placeholder="required">
                        </div>
                        <div class="mb-3">
                            <label for="ivValueMax" class="form-label">Max Independent Variable Value</label>
                            <input type="number" v-model="ivValues.max" class="form-control" :class="{'is-invalid':!ivValues.max && clickedSubmit}" id="ivValueMax" :required="ivMinMaxSpecify === 'ivMinMax'" placeholder="required">
                        </div>
                        <div class="mb-3">
                            <label for="ivValueIntervalSize" class="form-label">Independent Variable Interval Size</label>
                            <input type="number" v-model="ivValues.intSize" class="form-control" :class="{'is-invalid':!ivValues.intSize && clickedSubmit}" id="ivValueIntervalSize" :required="ivMinMaxSpecify === 'ivMinMax' " placeholder="required">
                        </div>
                    </div>
                </div>
                <div class = "container" v-if="ivMinMaxSpecify === 'ivSpecify' || ivType === 'string'">
                    <div class="container mb-3">
                        <label for="ivValues" class="form-label">Independent Variable Values</label>
                        <div class="input-group mb-3">
                            <input :type="ivType === 'string' ? 'text' : 'number'" v-model="currIvValue" class="form-control" :class="{'is-invalid':ivValues.values.length === 0 && clickedSubmit}" id="ivValues" :placeholder="ivValues.values.length === 0 ? 'Add at least one value' : ''">
                            <button class="btn btn-primary" @click.prevent="addValue(ivValues.values, currIvValue, 'iv')">Add</button>
                        </div>
                        <div class="container" v-if="ivValues.values.length > 0">
                            <ValueTable :values="ivValues.values" @delete-value="deleteValue($event, ivValues.values)"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-4 mb-1">
            <div class="col">
                <h1 style="color:#187bcd">Dependent Variable (DV)</h1>
                <hr style="height:3px;color:green"/>
            </div>
        </div>
        <div class="container">
            <div class="mb-3">
                <label for="dvName" class="form-label" >Dependent Variable Name</label>
                <input type="text" v-model="dvName" class="form-control" id="dvName" :class="{'is-invalid': !dvName && clickedSubmit}" required placeholder="required">
            </div>
            <div class="mb-3">
                <label for="dvUnits" class="form-label">Dependent Variable Units</label>
                <input type="text" v-model="dvUnits" class="form-control" id="ivUnits">
            </div>
            <div class="mb-3">
                <label>Dependent Variable Type</label>
                <div class="container">
                    <div class="form-check">
                        <input class="form-check-input" v-model="dvType" value="string" type="radio" name="dvType" id="dvTypeString" checked>
                        <label class="form-check-label" for="dvTypeString">Text</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" v-model="dvType" value="number" type="radio" name="dvType" id="dvTypeNum">
                        <label class="form-check-label" for="dvTypeNum">Number</label>
                    </div>
                </div>
            </div>
            <div class="form-check mb-1">
                <input type="checkbox" v-model="dvRestricted" class="form-check-input" id="dvRestricted">
                <label class="form-check-label" for="dvRestricted">Restrict Dependent Variable Values</label>
                <div id="restrictDvHelp" class="form-text">Check if you want to limit DV values that can be entered in the field app.</div>
            </div>
            <div class="container" v-if="dvRestricted">
                <div class="container" v-if="dvType === 'number'">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="dvMinMaxSpecify" id="dvMinMax" v-model="dvMinMaxSpecify" value="dvMinMax" checked>
                        <label class="form-check-label" for="dvMinMax">Specify DV Min/Max/Interval Size</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="dvMinMaxSpecify" id="dvSpecify" v-model="dvMinMaxSpecify" value="dvSpecify">
                        <label class="form-check-label" for="dvSpecify">Specify DV Values</label>
                    </div>
                </div>
                <div v-if="dvMinMaxSpecify === 'dvMinMax' && dvType === 'number'">
                    <div class="container">
                        <div class="mb-3">
                            <label for="dvValueMin" class="form-label">Min Dependent Variable Value</label>
                            <input type="number" v-model="dvValues.min" class="form-control" :class="{'is-invalid':!dvValues.min && clickedSubmit}" id="dvValueMin" :required="dvMinMaxSpecify === 'dvMinMax'" placeholder="required">
                        </div>
                        <div class="mb-3">
                            <label for="dvValueMax" class="form-label">Max Dependent Variable Value</label>
                            <input type="number" v-model="dvValues.max" class="form-control" :class="{'is-invalid':!dvValues.max && clickedSubmit}" id="dvValueMax" :required="dvMinMaxSpecify === 'dvMinMax'" placeholder="required">
                        </div>
                        <div class="mb-3">
                            <label for="dvValueIntervalSize" class="form-label">Dependent Variable Interval Size</label>
                            <input type="number" v-model="dvValues.intSize" class="form-control" :class="{'is-invalid':!dvValues.intSize && clickedSubmit}" id="dvValueIntervalSize" :required="dvMinMaxSpecify === 'dvMinMax'" placeholder="required">
                        </div>
                    </div>
                </div>
                <div v-if="dvMinMaxSpecify === 'dvSpecify' || dvType === 'string'">
                    <div class=" container mb-3">
                        <label for="dvValues" class="form-label">Dependent Variable Values</label>
                        <div class="input-group mb-3">
                            <input :type="dvType === 'string' ? 'text' : 'number'" v-model="currDvValue" class="form-control" :class="{'is-invalid':dvValues.values.length === 0 && clickedSubmit}" id="dvValues" :required="dvMinMaxSpecify === 'dvSpecify'" :placeholder="dvValues.values.length === 0 ? 'Add at least one value' : ''">
                            <button class="btn btn-primary" @click.prevent="addValue(dvValues.values, currDvValue, 'dv')">Add</button>
                        </div>
                        <div class="container" v-if="dvValues.values.length > 0">
                            <ValueTable :values="dvValues.values" @delete-value="deleteValue($event, dvValues.values)"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr style="height:3px;color:green"/>
        <div class="d-flex justify-content-end">
            <button type="submit" class="btn btn-primary" @click="submit">Create Project</button>
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
                ivMinMaxSpecify: "ivSpecify",
                dvMinMaxSpecify: "dvSpecify",
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
                    iv_accepted.interval_size = this.ivValues.intSize;
                }
                else if(this.ivMinMaxSpecify === "ivSpecify"){
                    iv_accepted.values = [...this.ivValues.values];
                }
               
                if(this.dvMinMaxSpecify === "dvMinMax"){
                    dv_accepted.min = this.dvValues.min;
                    dv_accepted.max = this.dvValues.max;
                    dv_accepted.interval_size = this.dvValues.intSize;
                }
                else if(this.dvMinMaxSpecify === "dvSpecify"){
                    dv_accepted.values = [...this.dvValues.values];
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
                };
              
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

            addValue: function (values, value, type){
                if(!values.includes(value) && value !== ""){
                    values.push(value);
                    values.sort();
                }
                type === 'iv' ? this.currIvValue = "" : this.currDvValue = "";            
            },

            deleteValue: function (index, values){
                values.splice(index, 1);
            }

        },
        components: {
            ValueTable, 
        },

        watch: {
            ivType: function () {
                if(this.ivType === "string"){
                    this.ivMinMaxSpecify = "ivSpecify";
                }
                else{
                    this.ivMinMaxSpecify = "ivMinMax";
                }
                this.ivValues.values = [];
            },

            dvType: function () {
                if(this.dvType === "string"){
                    this.dvMinMaxSpecify = "dvSpecify";
                }
                else{
                    this.dvMinMaxSpecify = "dvMinMax";
                }
                this.dvValues.values = [];
            }
        }
    }
</script>
