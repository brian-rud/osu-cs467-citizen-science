<template>
    <form>
    <div class="mb-3">
        <label for="projectTitle" class="form-label">Project Title</label>
        <input type="text" class="form-control" id="projectTitle" aria-describedby="projectTitle">
        <div id="projectTitldlp" class="form-text">Enter a title for this experiment</div>
    </div>
        <div class="mb-3">
        <label for="projectCategory" class="form-label">Project Category</label>
        <input type ="text" class="form-control" id="projectCategory">
    </div>
    <div class="mb-3">
        <label for="projectDescription" class="form-label">Project Description</label>
        <textarea class="form-control" id="projectDescription"></textarea>
    </div>
        <div class="mb-3">
        <label for="endDate" class="form-label">End Date</label>
        <input type="date" class="form-control" id="endDate">
    </div>
    <div class="mb-3">
        <label for="ivName" class="form-label">Independent Variable Name</label>
        <input type="text" class="form-control" id="ivName">
    </div>
    <div class="mb-3">
        <label for="ivUnits" class="form-label">Independent Variable Units</label>
        <input type="text" class="form-control" id="ivUnits">
    </div>
    <label>Independent Variable Type</label>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="ivType" id="ivTypeString">
        <label class="form-check-label" for="ivTypeString">String</label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="ivType" id="ivTypeNum">
        <label class="form-check-label" for="ivTypeNum">Number</label>
    </div>
    <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="ivRestricted">
        <label class="form-check-label" for="ivRestricted">Restrict Independent Variable Values</label>
    </div>
    <div class="mb-3">
        <label for="dvName" class="form-label">Dependent Variable Name</label>
        <input type="text" class="form-control" id="dvName">
    </div>
    <div class="mb-3">
        <label for="dvUnits" class="form-label">Dependent Variable Units</label>
        <input type="text" class="form-control" id="ivUnits">
    <label>Dependent Variable Type</label>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="ivType" id="dvTypeString">
        <label class="form-check-label" for="dvTypeString">String</label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="ivType" id="dvTypeNum">
        <label class="form-check-label" for="dvTypeNum">Number</label>
    </div>
    </div>
        <div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="dvRestricted">
        <label class="form-check-label" for="dvRestricted">Restrict Dependent Variable Values</label>
    </div>
    
    <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</template>

<script>
</script>