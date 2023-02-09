<%@page import="java.util.List"%>
<%@page import="java.nio.file.attribute.UserPrincipalLookupService"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%-- <%@include file="authentication.jsp"%> --%>


<head>

<link rel="icon" href="./img/Logo-Centauri-Academy-2018.ico">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="./js/env.js"></script>
<script src="./js/common.js"></script>

<script type="text/javascript">

backendApplicationPath = backendApplicationPath+"surveyQuestions";

insertMessageOK = "surveyquestions correttamente inserito";
updateMessageOK = "surveyquestions correttamente modificato";
deleteMessageOK = "surveyquestions correttamente eliminato";


//INSERT FUNCTION
function insert () {
	console.log("insert - START");
	var surveyIdToInsert = $("#surveyIdToInsert").val(); 
	var questionIdToInsert = $("#questionIdToInsert").val(); 
	var positionToInsert = $("#positionToInsert").val(); 
	console.log("surveyIdToInsert: " + surveyIdToInsert + " - questionIdToInsert: " + questionIdToInsert + " - positionToInsert: " + positionToInsert);
	
	var itemToInsert = {
			"surveyId":surveyIdToInsert,
			"questionId":questionIdToInsert,
			"position":positionToInsert
			}
    
	insertItem (itemToInsert) ;
}

	function abilitaBottone() {
		console.log("questa è la console");
 		document.getElementById("buttonDelete").disabled = false;
 		document.getElementById("buttonUpdate").disabled = false;
	}
	
	
	//INITIALIZE UPDATE FORM
	function initializeUpdateForm (item) {
		console.log("initializeUpdateForm - START - " + item);
		console.log(item);
		document.getElementById("surveysQuestionsIdToUpdate").value = item.id;
		document.getElementById("surveysQuestionsSurveyIdToUpdate").value = item.surveyId;
		document.getElementById("surveysQuestionsQuestionIdToUpdate").value = item.questionId;
		document.getElementById("surveysQuestionsPositionToUpdate").value = item.position;
		
	}
	
	//INITIALIZE INSERT FORM
	function initializeInsertForm (item) {
		console.log("initializeInsertForm - START - " + item);
		console.log(item);
		document.getElementById("surveysQuestionsSurveyIdToInsert").value = item.surveyId;
		document.getElementById("surveysQuestionsQuestionIdToInsert").value = item.questionId;
		document.getElementById("surveysQuestionsPositionToInsert").value = item.position;
	}
	
	//SHOW UPDATE MODAL
	function showUpdateSurveysQuestionsModal () {
		console.log("showUpdateSurveysQuestionsModal!!!");
		console.log(backendApplicationPath);
		const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			  console.log(this.responseText);
			  var surveyQuestions = JSON.parse(this.responseText) ;
			  console.log(surveyQuestions);
			  initializeUpdateForm (surveyQuestions);
		    }
		  var id= document.querySelector('input[name="id"]:checked').value;
		  console.log(backendApplicationPath+""+id);
		  xhttp.open("GET", backendApplicationPath+"/"+id, true);
		  xhttp.send();
	}
	
	//SHOW INSERT MODAL
	function showInsertSurveysQuestionsModal () {
		console.log("showInsertSurveysQuestionsModal!!!");
		const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			  console.log(this.responseText);
			  var surveyQuestions = JSON.parse(this.responseText) ;
			  console.log(surveyQuestions);
			  initializeInsertForm (surveyQuestions);
		    }
	}
	
	//UPDATE FUNCTION
	function update () {
		console.log("update - START");
		var idToUpdate = $("#surveysQuestionsIdToUpdate").val(); 
		var surveyIdToUpdate = $("#surveysQuestionsSurveyIdToUpdate").val(); 
		var questionIdToUpdate = $("#surveysQuestionsQuestionIdToUpdate").val(); 
		var positionToUpdate = $("#surveysQuestionsPositionToUpdate").val(); 
		console.log("idToUpdate: " + idToUpdate + " - surveyIdToUpdate: " + surveyIdToUpdate + " - questionIdToUpdate: " + questionIdToUpdate + " - positionToUpdate: " + positionToUpdate);
		
		var itemToUpdate = {
				"id":idToUpdate,
				"surveyId":surveyIdToUpdate,
				"questionId":questionIdToUpdate,
				"position":positionToUpdate
				}
		
		updateItem (itemToUpdate) ;
	}
	
	//load remote data
	function initializeData () {
		console.log("initializeData - START");
		document.getElementById("tableData").innerHTML = "<img src='./img/loader/loading.gif' class='mx-auto d-block' style='max-width:10%'/>" ;
		
		const xhttp = new XMLHttpRequest();
	    xhttp.onload = function() {
		  console.log(this.responseText);
		  var items = JSON.parse(this.responseText) ;
		  console.log(items);
		  initializeTable (items);
	    }
	    xhttp.open("GET", backendApplicationPath, true);
	    xhttp.send();
	}
	
	function initializeTable (items) {
		if (items != null) {
			
			var dynamicTableContent  = "<table class='table table-striped table-hover  table-bordered'>";
			dynamicTableContent += "<thead class='thead-dark'><tr>";
			dynamicTableContent += "<th scope='col'></th>" ;
			dynamicTableContent += "<th scope='col'>Id</th>" ;
			dynamicTableContent += "<th scope='col'>Survey Id</th>" ;
			dynamicTableContent += "<th scope='col'>Question Id</th>" ;
			dynamicTableContent += "<th scope='col'>Position</th>" ;
			dynamicTableContent += "</tr></thead>" ;
			if (items.length==0) {
				dynamicTableContent += "<tr><td colspan='5'style='text-align:center;'>NON CI SONO SURVEY QUESTION</td></tr>" ;
			} else {
				for (var i=0; i<items.length; i++) {
					dynamicTableContent += "<tr><td scope='col'><input type='radio' name='id' onclick='javascript:abilitaBottone();' value='" + items[i].id + "' /></td>" ;
					dynamicTableContent += "<td>" + items[i].id + "</td>" ;
					dynamicTableContent += "<td>" + items[i].surveyId + "</td>" ;
					dynamicTableContent += "<td>" + items[i].questionId + "</td>" ;
					dynamicTableContent += "<td>" + items[i].position + "</td></tr>" ;
				}
			}
			//
			dynamicTableContent += "</table>" ;
			document.getElementById("tableData").innerHTML = dynamicTableContent ;
		} else {
			document.getElementById("tableData").innerHTML = "ERRORE LATO SERVER. AL MOMENTO NON E' POSSIBILE AVERE LA LISTA DEI SURVEY QUESTION. RIPROVARE PIU TARDI.";
		}
	}
	
</script>
<meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>List Survey Questions</title>
<link rel="icon" type="image/ico" href="./img/Logo-Centauri-Academy-2018.ico">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

<link rel="stylesheet" href="css/style.css">

</head>
<body>
	<%@include file="header.jsp"%>
<div class="container-fluid">
<div class="alert alert-success" role="alert" id="successAlert"></div>
<div class="alert alert-danger" role="alert" id="dangerAlert"></div>
	<h1>Survey Question List</h1>
	<!-- Button trigger Insert Modal -->
	<div style="text-align: right;"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insertModal"
	onclick="showInsertSurveysQuestionsModal(); return false;">+</button></div>
	<br>
	<form id="formSelectSurveyquestions">

		<div id="tableData">
	   	</div> 	

		<button type="button" id="buttonDelete" class="btn btn-danger" data-toggle="modal" data-target="#deleteItemModal" disabled>Delete</button>
		<button type="button" id="buttonUpdate" class="btn btn-primary" data-toggle="modal" data-target="#updateModal" disabled onclick="showUpdateSurveysQuestionsModal(); return false;">Update</button>

	</form>
<!--Delete Modal -->
<div class="modal fade" id="deleteItemModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Delete Surveys Questions</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Do you really want to delete?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <input class="btn btn-danger" type="submit" value="Confirm" onclick="javascript:deleteItem();">
      </div>
    </div>
  </div>
</div>
</div>


<!-- Update Modal -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Update Survey Questions</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="updateSurveysQuestionsForm">
	      <div class="modal-body">
			
			  	<label>ID</label><br>
		  		<input type="number" name="surveysQuestionsIdToUpdate" id="surveysQuestionsIdToUpdate" value=""><br>
		  		
		  		<label>Survey ID</label><br>
		  		<input type="number" name="surveysQuestionsSurveyIdToUpdate" id="surveysQuestionsSurveyIdToUpdate" value=""><br>
		  		
		  		<label>Question ID</label><br>
		  		<input type="number" name="surveysQuestionsQuestionIdToUpdate" id="surveysQuestionsQuestionIdToUpdate" value=""><br>
			
		  		<label>Position</label><br>
		  		<input type="number" name="surveysQuestionsPositionToUpdate" id="surveysQuestionsPositionToUpdate" value=""><br>		  		
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onClick="update();">Save changes</button>
	      </div>
      </form> 
    </div>
  </div>
</div>

<!-- Insert Modal -->
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Insert Modal</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="insertSurveyQuestionForm">
	      <div class="modal-body">
			
		  		<label>Survey ID</label><br>
		  		<input type="text" name="surveyIdToInsert" id="surveyIdToInsert" value=""><br>
		  		
		  		<label>Question ID</label><br>
		  		<input type="text" name="questionIdToInsert" id="questionIdToInsert" value=""><br>
			
		  		<label>Position</label><br>
		  		<input type="number" name="positionToInsert" id="positionToInsert" value=""><br>		  		
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onClick="insert(); return false;">Save</button>
	      </div>
      </form> 
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

</body>
</html>

<script>

    initializeData();

</script>