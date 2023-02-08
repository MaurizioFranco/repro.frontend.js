<%@page import="java.util.List"%>
<%@page import="java.nio.file.attribute.UserPrincipalLookupService"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%-- <%@include file="authentication.jsp"%> --%>


<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="./js/env.js"></script>
<script src="./js/common.js"></script>
<script type="text/javascript">

	backendApplicationPath = backendApplicationPath+"survey";
	updateMessageOK = "Survey correttamente modificato";
	insertMessageOK = "Survey correttamente inserito";
	deleteMessageOK = "Survey correttamente eliminato";

	function abilitaBottone() {
		console.log("questa è la console");
 		document.getElementById("deleteButton").disabled = false;
 		document.getElementById("updateButton").disabled = false;
	}
	
	//INITIALIZE UPDATE FORM
	function initializeUpdateForm (item) {
		console.log("initializeUpdateForm - START - " + item);
		console.log(item);
		document.getElementById("surveyIdToUpdate").value = item.id;
		document.getElementById("surveyLabelToUpdate").value = item.label;
		document.getElementById("surveyTimeToUpdate").value = item.time;
		document.getElementById("surveyDescriptionToUpdate").value = item.description;
	}
	
	//INITIALIZE INSERT FORM
	function initializeInsertForm (item) {
		console.log("initializeInsertForm - START - " + item);
		console.log(item);
		document.getElementById("surveyLabelToInsert").value = item.label;
		document.getElementById("surveyTimeToInsert").value = item.time;
		document.getElementById("surveyDescriptionToInsert").value = item.description;
	}
	
	//UPDATE FUNCTION
	function update() {
		console.log("update - START");
		var idToUpdate = $("#surveyIdToUpdate").val();
		var labelToUpdate = $("#surveyLabelToUpdate").val();
		var timeToUpdate = $("#surveyTimeToUpdate").val();
		var descriptionToUpdate = $("#surveyDescriptionToUpdate").val();
		console.log("idToUpdate"+idToUpdate+"labelToUpdate"+labelToUpdate+"timeToUpdate"+timeToUpdate+"descriptionToUpdate"+descriptionToUpdate);
		
		var itemToUpdate = {
        		"id":idToUpdate,
        		"label":labelToUpdate,
        		"time":timeToUpdate,
        		"description":descriptionToUpdate
        }
		updateItem(itemToUpdate);
	}
	
	//INSERT FUNCTION
	function insert () {
		console.log("insert - START");
		
		var surveyLabelToInsert = $("#surveyLabelToInsert").val();
		var surveyTimeToInsert = $("#surveyTimeToInsert").val();
		var surveyDescriptionToInsert = $("#surveyDescriptionToInsert").val();
		
		console.log("surveyLabelToInsert: " + surveyLabelToInsert + " - surveyTimeToInsert: " + surveyTimeToInsert + " - surveyDescriptionToInsert: " + surveyDescriptionToInsert);
		
		var itemToInsert = {
        		"label":surveyLabelToInsert,
        		"time":surveyTimeToInsert,
        		"description":surveyDescriptionToInsert
        }
        insertItem(itemToInsert);
	}
	
	function initializeTable (items) {
		if (items != null) {
			
			var dynamicTableContent  = "<table class='table table-striped table-hover  table-bordered'>";
			dynamicTableContent += "<thead class='thead-dark'><tr>";
			dynamicTableContent += "<th scope='col'></th>" ;
			dynamicTableContent += "<th scope='col'>Id</th>" ;
			dynamicTableContent += "<th scope='col'>Label</th>" ;
			dynamicTableContent += "<th scope='col'>Time</th>" ;
			dynamicTableContent += "<th scope='col'>Description</th>" ;
			dynamicTableContent += "</tr></thead>" ;
			if (items.length==0) {
				dynamicTableContent += "<tr><td colspan='4'>NON CI SONO SONDAGGI</td></tr>" ;
			} else {
				for (var i=0; i<items.length; i++) {
					dynamicTableContent += "<tr><td scope='col'><input type='radio' name='id' onclick='javascript:abilitaBottone();' value='" + items[i].id + "' /></td>" ;
					dynamicTableContent += "<td>" + items[i].id + "</td>" ;
					dynamicTableContent += "<td>" + items[i].label + "</td>" ;
					dynamicTableContent += "<td>" + items[i].time + "</td>" ;
					dynamicTableContent += "<td>" + items[i].description + "</td></tr>" ;
				}
			}
			//
			dynamicTableContent += "</table>" ;
			document.getElementById("tableData").innerHTML = dynamicTableContent ;
		} else {
			document.getElementById("tableData").innerHTML = "ERRORE LATO SERVER. AL MOMENTO NON E' POSSIBILE AVERE LA LISTA DEI SONDAGGI. RIPROVARE PIU? TARDI.";
		}
	}
	
	
	
</script>
<meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>List Surveys</title>

<link rel="icon" type="image/ico" href="./img/Logo-Centauri-Academy-2018.ico">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

<link rel="stylesheet" href="css/style.css">

</head>
<body>
	<%@include file="header.jsp"%>
<div class="container-fluid">
	<h1 style="text-align: left;">Survey List</h1>
	<!-- Button trigger Insert Modal -->
	<div style="text-align: right;"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insertModal"
	onclick="showInsertModal(); return false;">+</button></div>
	<br>
	<form id="formSelectSurvey">
		<div id="tableData"></div>
		<button type="button" class="btn btn-danger" id="deleteButton" disabled data-toggle="modal" data-target="#deleteItemModal">Cancella</button>
		<button type="button" class="btn btn-primary" id="updateButton" disabled data-toggle="modal" data-target="#updateModal" onclick="showUpdateModal(); return false;">MODIFICA</button>
	</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

<!-- Update Modal -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Update Modal</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form  id="updateSurveyForm">
	      <div class="modal-body">
			
			  	<label>ID</label><br>
		  		<input type="number" name="surveyIdToUpdate" id="surveyIdToUpdate" value=""><br>
		  		
		  		<label>Label</label><br>
		  		<input type="text" name="surveyLabelToUpdate" id="surveyLabelToUpdate" value=""><br>
			
		  		<label>Time</label><br>
		  		<input type="number" name="surveyTimeToUpdate" id="surveyTimeToUpdate" value=""><br>
		  		
		  		<label>Description</label><br>
		  		<input type="text" name="surveyDescriptionToUpdate" id="surveyDescriptionToUpdate" value=""><br>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onclick="update();">Save changes</button>
	      </div>
      </form> 
    </div>
  </div>
</div>


	<!-- Modal DELETE-->
<div class="modal fade" id="deleteItemModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Eliminazione survey</h5>
			    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			    	<span aria-hidden="true">&times;</span>
			    </button>
			</div>
			<div class="modal-body">
				<p>Sei sicuro di volre rimuovere questa survey?</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="javascript:deleteItem();">SI</button>
			   	<button type="button" class="btn btn-primary" data-dismiss="modal">NO</button>
			</div>
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
      <form id="insertSurveyForm">
	      <div class="modal-body">
			
		  		<label>Label</label><br>
		  		<input type="text" name="surveyLabelToInsert" id="surveyLabelToInsert" value=""><br>
		  		
		  		<label>Time</label><br>
		  		<input type="text" name="surveyTimeToInsert" id="surveyTimeToInsert" value=""><br>
			
		  		<label>Description</label><br>
		  		<input type="text" name="surveyDescriptionToInsert" id="surveyDescriptionToInsert" value=""><br>		  		
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onClick="insert(); return false;">Save</button>
	      </div>
      </form> 
    </div>
  </div>
</div>



</body>
</html>
<script>
	initializeData();
</script>