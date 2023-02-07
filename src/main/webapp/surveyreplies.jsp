<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>



<%
String surveyRepliesEliminato="";
if(request.getAttribute("deleteSurveyReplies") == "OK"){
	surveyRepliesEliminato = "Sei riuscito ad eliminare il surveyreplies selezionato";
}if(request.getAttribute("deleteSurveyReplies") == "KO"){
	surveyRepliesEliminato = "Non sei riuscito ad eliminare il surveyreplies selezionato";
}
%>

<%
String surveyRepliesModificato="";
if(request.getAttribute("updateSurveyreplies") == "OK"){
	surveyRepliesModificato = "Modifica andata a buon fine";
}if(request.getAttribute("updateSurveyreplies") == "KO"){
	surveyRepliesModificato = "Modificata non riuscita";
}
%>


<%
String loginMessage = "";
if(request.getAttribute("loginMessage") != null){
	loginMessage = "" + request.getAttribute("loginMessage");
}else{
	loginMessage = "";
}
%>

<html>

<%-- <%@include file="authentication.jsp"%> --%>

<head>
<meta charset="ISO-8859-1">
<title>SurveyReplies</title>
<link rel="icon" type="image/ico" href="./img/Logo-Centauri-Academy-2018.ico">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="./js/env.js"></script>

<script type="text/javascript">

var surveyReplisBackendApplicationPath = backendPath+"surveyreplies";

	function abilitaBottone() {
		console.log("questa � una stampa di console");
		document.getElementById("deleteButton").disabled=false;
		document.getElementById("modificaButton").disabled=false;
	}
	
	//INITIALIZE UPDATE FORM
	function initializeUpdateForm (item) {
		console.log("initializeUpdateForm - START - " + item);
		console.log(item);
		document.getElementById("surveyRepliesIdToUpdate").value = item.id;
		document.getElementById("survey_IdToUpdate").value = item.surveyId;
		document.getElementById("user_IdToUpdate").value = item.userId;
		document.getElementById("answersToUpdate").value = item.answer;
		document.getElementById("pdfFileNameToUpdate").value = item.pdfFileName;
		document.getElementById("pointsToUpdate").value = item.points;
	}
	
	//INITIALIZE INSERT FORM
	function initializeInsertForm (item) {
		console.log("initializeInsertForm - START - " + item);
		console.log(item);
		document.getElementById("survey_IdToInsert").value = item.surveyId;
		document.getElementById("user_IdToInsert").value = item.userId;
		document.getElementById("answersToInsert").value = item.answer;
		document.getElementById("pdfFileNameToInsert").value = item.pdfFileName;
		document.getElementById("pointsToInsert").value = item.points;
	}
	
	//SHOW UPDATE MODAL
	function showUpdateSurveyRepliesModal(){
		console.log("showUpdateSurveyRepliesModal!!!");
		const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			  console.log(this.responseText);
			  var surveyReplies = JSON.parse(this.responseText) ;
			  console.log(surveyReplies);
			  initializeUpdateForm (surveyReplies);
		    }
		  var id = document.querySelector('input[name="id"]:checked').value;
		  xhttp.open("GET", surveyReplisBackendApplicationPath+"/" + id +"", true);
		  xhttp.send();
	}
	
	//SHOW INSERT MODAL
	function showInsertSurveyRepliesModal () {
		console.log("showInsertSurveryRepliesModal!!!");
		const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			  console.log(this.responseText);
			  var surveyReplies = JSON.parse(this.responseText) ;
			  console.log(surveyReplies);
			  initializeInsertForm (role);
		    }
	}
	
	//UPDATE FUNCTION
	function update(){
		console.log("update - START");
		var idToUpdate = $("#surveyRepliesIdToUpdate").val();
		var survey_IdToUpdate = $("#survey_IdToUpdate").val();
		var user_IdToUpdate = $("#user_IdToUpdate").val();
		var answersToUpdate = $("#answersToUpdate").val();
		var pdfFileNameToUpdate = $("#pdfFileNameToUpdate").val();
		var pointsToUpdate = $("#pointsToUpdate").val();
		
		var itemToUpdate = {
		"id":idToUpdate,
		"surveyId":survey_IdToUpdate,
		"userId":user_IdToUpdate,
		"answer":answersToUpdate,
		"pdfFileName":pdfFileNameToUpdate,
		"points":pointsToUpdate
		}
		
		$.ajax({
			type:"PUT",
			url: surveyReplisBackendApplicationPath,
			data: JSON.stringify(itemToUpdate),
			success:function(result){
				console.log(result);
// 				if(result == 'OK'){
		        	$('#updateSurveyRepliesModal').modal('hide');
		        	initializeData ();
// 				}
			},
			headers: {
			      'Content-Type': 'application/json'
			    }
		});

	}
	
	//DELETE FUNCTION
	function deleteSurveyReplies () {
		console.log("deleteSurveyReplies - START");
		var idToDelete= document.querySelector('input[name="id"]:checked').value;
		console.log("idToDelete: " + idToDelete);

        var itemToDelete = {
        		"id":idToDelete
        }
        
        $.ajax({
			  type: "DELETE",
			  url: surveyReplisBackendApplicationPath,
			  data: itemToDelete,
			  success: function (responseText) {
				  console.log(responseText);
				  if (responseText==='OK') {					 
					  $('#deleteSurveyRepliesModal').modal('hide');	
					  initializeData ();					  
				  }
			  },
			  dataType: "text"
			});

	}	
	
	//INSERT FUNCTION
	function insert () {
		console.log("insert - START");
		
		var survey_IdToInsert = $("#survey_IdToInsert").val();
		var user_IdToInsert = $("#user_IdToInsert").val();
		var answersToInsert = $("#answersToInsert").val();
		var pdfFileNameToInsert = $("#pdfFileNameToInsert").val();
		var pointsToInsert = $("#pointsToInsert").val();
		
		console.log("survey_IdToInsert: " + survey_IdToInsert + " - user_IdToInsert: " + user_IdToInsert + " - answersToInsert: " + answersToInsert);
		
		var itemToInsert = {
				"surveyId":survey_IdToInsert,
				"userId":user_IdToInsert,
				"answer":answersToInsert,
				"pdfFileName":pdfFileNameToInsert,
				"points":pointsToInsert
        }
        
        $.ajax({
			  type: "POST",
			  url: surveyReplisBackendApplicationPath,
			  data: JSON.stringify(itemToInsert),
			  success: function (responseText) {
				  console.log(responseText);
// 				  if (responseText==='OK') {					 
					  $('#insertSurveyRepliesModal').modal('hide');		
					  initializeData ();  
// 				  }
			  },
			  headers: {
			      'Content-Type': 'application/json'
			    }
			});
	}
		
		//load remote data
		function initializeData () {
			console.log("initializeData - START");
			document.getElementById("tableData").innerHTML = "<img src='./img/loader/loading.gif' />" ;
			
			const xhttp = new XMLHttpRequest();
		    xhttp.onload = function() {
			  console.log(this.responseText);
			  var items = JSON.parse(this.responseText) ;
			  console.log(items);
			  initializeTable (items);
		    }
		    xhttp.open("GET", surveyReplisBackendApplicationPath, true);
		    xhttp.send();
		}
		
		function initializeTable (items) {
			if (items != null) {
				
				var dynamicTableContent  = "<table class='table table-striped table-hover  table-bordered'>";
				dynamicTableContent += "<thead class='thead-dark'><tr>";
				dynamicTableContent += "<th scope='col'></th>" ;
				dynamicTableContent += "<th scope='col'>Id</th>" ;
				dynamicTableContent += "<th scope='col'>Survey_Id</th>" ;
				dynamicTableContent += "<th scope='col'>User_Id</th>" ;
				dynamicTableContent += "<th scope='col'>StartTime</th>" ;
				dynamicTableContent += "<th scope='col'>EndTime</th>" ;
				dynamicTableContent += "<th scope='col'>Answers</th>" ;
				dynamicTableContent += "<th scope='col'>PdfFileName</th>" ;
				dynamicTableContent += "<th scope='col'>Points</th>" ;
				dynamicTableContent += "</tr></thead>" ;
				if (items.length==0) {
					dynamicTableContent += "<tr><td colspan='5'>NON CI SONO RUOLI</td></tr>" ;
				} else {
					for (var i=0; i<items.length; i++) {
						dynamicTableContent += "<tr><td scope='col'><input type='radio' name='id' onclick='javascript:abilitaBottone();' value='" + items[i].id + "' /></td>" ;
						dynamicTableContent += "<td>" + items[i].id + "</td>" ;
						dynamicTableContent += "<td>" + items[i].surveyId + "</td>" ;
						dynamicTableContent += "<td>" + items[i].userId + "</td>" ;
						dynamicTableContent += "<td>" + items[i].startTime + "</td>" ;
						dynamicTableContent += "<td>" + items[i].endTime + "</td>" ;
						dynamicTableContent += "<td>" + items[i].answer + "</td>" ;
						dynamicTableContent += "<td>" + items[i].pdfFileName + "</td>" ;
						dynamicTableContent += "<td>" + items[i].points + "</td></tr>" ;
					}
				}
				//
				dynamicTableContent += "</table>" ;			
				
				document.getElementById("tableData").innerHTML = dynamicTableContent ;
			} else {
				document.getElementById("tableData").innerHTML = "ERRORE LATO SERVER. AL MOMENTO NON E' POSSIBILE AVERE LA LISTA DEI RUOLI. RIPROVARE PIU? TARDI.";
			}
	}
		
</script>

</head>
	<%@include file="./header.jsp"%>
<body>
<div class="container-fluid">
	<h1 style="text-align: left;">Survey Replies List</h1>
	<!-- Button trigger Insert Modal -->
	<div style="text-align: right;"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insertSurveyRepliesModal"
	onclick="showInsertSurveyRepliesModal(); return false;">+</button></div>
	<br>
	<h3 style="text-align:center;"><%= surveyRepliesEliminato%></h3>
	<h3 style="text-align:center;"><%= surveyRepliesModificato%></h3>
	<h3 style="text-align:center;"><%= loginMessage%></h3>

	<form id="formSelezioneSurveyreplies">	
		<div id="tableData">	    
		</div>		
		<button type="button" id="deleteButton"  class="btn btn-danger"  data-toggle="modal" data-target="#deleteSurveyRepliesModal" disabled>ELIMINA</button>
		<button type="button" id="modificaButton" class="btn btn-primary" data-toggle="modal" data-target="#updateSurveyRepliesModal" disabled onclick="showUpdateSurveyRepliesModal(); return false;">MODIFICA</button>


	</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

<!-- Update Modal -->
<div class="modal fade" id="updateSurveyRepliesModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Update Modal</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="updateSurveyRepliesForm">
	      <div class="modal-body">
			
			  	<label>ID</label><br>
		  		<input type="number" name="surveyRepliesIdToUpdate" id="surveyRepliesIdToUpdate" value=""><br>
		  		
		  		<label>Survey ID</label><br>
		  		<input type="text" name="survey_IdToUpdate" id="survey_IdToUpdate" value=""><br>
		  		
		  		<label>User ID</label><br>
		  		<input type="text" name="user_IdToUpdate" id="user_IdToUpdate" value=""><br>
			
		  		<label>Answers</label><br>
		  		<input type="text" name="answersToUpdate" id="answersToUpdate" value=""><br>
		  		
		  		<label>PDF File Name</label><br>
		  		<input type="text" name="pdfFileNameToUpdate" id="pdfFileNameToUpdate" value=""><br>
		  		
		  		<label>Points</label><br>
		  		<input type="text" name="pointsToUpdate" id="pointsToUpdate" value=""><br>
		  		
	      </div>
	      <div class="modal-footer">
	      	<label id="errorUpdateMessage" style="display:none;">ERRORE LA MODIFICA NON � ANDATA A BUON FINE</label>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onClick="update();">Save changes</button>
	      </div>
      </form> 
    </div>
  </div>
</div>

<!-- Modal delete-->
<div class="modal" id=deleteSurveyRepliesModal tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Eliminazione SurveyReplies</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Sei sicuro di volre rimuovere questo Survey Replies</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="javascript:deleteSurveyReplies();">SI</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">NO</button>
      </div>
    </div>
  </div>
</div>

<!-- Insert Modal -->
<div class="modal fade" id="insertSurveyRepliesModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Insert Modal</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="insertSurveyRepliesForm">
	      <div class="modal-body">
			
		  		<label>Survey ID</label><br>
		  		<input type="text" name="survey_IdToInsert" id="survey_IdToInsert" value=""><br>
		  		
		  		<label>User ID</label><br>
		  		<input type="text" name="user_IdToInsert" id="user_IdToInsert" value=""><br>
			
		  		<label>Answers</label><br>
		  		<input type="text" name="answersToInsert" id="answersToInsert" value=""><br>
		  		
		  		<label>PDF File Name</label><br>
		  		<input type="text" name="pdfFileNameToInsert" id="pdfFileNameToInsert" value=""><br>
		  		
		  		<label>Points</label><br>
		  		<input type="text" name="pointsToInsert" id="pointsToInsert" value=""><br>	  		
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onClick="insert(); return false;">Save</button>
	      </div>
      </form> 
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
</body>
</html>

<script>

initializeData();

</script>