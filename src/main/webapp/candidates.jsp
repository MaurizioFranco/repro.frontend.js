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
<style>

</style>

<script type="text/javascript">

    var candidatesBackendApplicationPath = backendPath+"candidates";

	function abilitaBottone() {
		console.log("questa � la console");
 		document.getElementById("deleteButton").disabled = false;
 		document.getElementById("updateButton").disabled = false;
	}
	
	//INITIALIZE UPDATE FORM
	function initializeUpdateForm (item) {
		console.log("initializeUpdateForm - START - " + item);
		console.log(item);
		document.getElementById("candidateIdToUpdate").value = item.id;
		document.getElementById("candidateUser_idToUpdate").value = item.user_id;
		document.getElementById("candidateCourse_codeToUpdate").value = item.course_code;
		document.getElementById("candidateCandidacy_date_timeToUpdate").value = item.candidacy_date_time;
	}
	
	//INITIALIZE INSERT FORM
	function initializeInsertForm (item) {
		console.log("initializeInsertForm - START - " + item);
		console.log(item);
		document.getElementById("candidateUser_idToInsert").value = item.user_id;
		document.getElementById("candidateCourse_codeToInsert").value = item.course_code;
		document.getElementById("candidateCandidacy_date_timeToInsert").value = item.candidacy_date_time;
	}
	
	//SHOW UPDATE MODAL
	function showUpdateCandidateModal () {
		console.log("showUpdateCandidateModal!!!");
		const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			  console.log(this.responseText);
			  var candidate = JSON.parse(this.responseText) ;
			  console.log(candidate);
			  initializeUpdateForm (candidate);
		    }
		  var id= document.querySelector('input[name="id"]:checked').value;
		  xhttp.open("GET", candidatesBackendApplicationPath+"/id="+id, true);
		  xhttp.send();
	}
	
	//SHOW INSERT MODAL
	function showInsertCandidateModal () {
		console.log("showInsertCandidateModal!!!");
		const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			  console.log(this.responseText);
			  var candidate = JSON.parse(this.responseText) ;
			  console.log(candidate);
			  initializeInsertForm (candidate);
		    }
	}
	
	//UPDATE FUNCTION
	function update () {
		console.log("update - START");
		var idToUpdate = document.getElementById("candidateIdToUpdate").value ; 
		var candidateUser_idToUpdate = document.getElementById("candidateUser_idToUpdate").value ; 
		var candidateCourse_codeToUpdate = document.getElementById("candidateCourse_codeToUpdate").value ; 
		var candidateCandidacy_date_timeToUpdate = document.getElementById("candidateCandidacy_date_timeToUpdate").value ; 
		console.log("idToUpdate: " + idToUpdate + " - candidateUser_idToUpdate: " + candidateUser_idToUpdate + " - candidateCourse_codeToUpdate: " + candidateCourse_codeToUpdate + " - candidateCandidacy_date_timeToUpdate: " + candidateCandidacy_date_timeToUpdate);

        var itemToUpdate = {
        		"id":idToUpdate,
        		"user_id":candidateUser_idToUpdate,
        		"course_code":candidateCourse_codeToUpdate,
        		"candidacy_date_time":candidateCandidacy_date_timeToUpdate
        }
        
        $.ajax({
			  type: "PUT",
			  url: candidatesBackendApplicationPath,
			  data: itemToUpdate,
			  success: function (responseText) {
				  console.log(responseText);
				  if (responseText==='OK') {					 
					  $('#updateCandidateModal').modal('hide');	
					  initializeData ();					  
				  }
			  },
			  dataType: "text"
			});

	}
	
	//DELETE FUNCTION
	function deleteCandidate () {
		console.log("deleteCandidate - START");
		var idToDelete= document.querySelector('input[name="id"]:checked').value;
		console.log("idToDelete: " + idToDelete);

        var itemToDelete = {
        		"id":idToDelete
        }
        
        $.ajax({
			  type: "DELETE",
			  url: candidatesBackendApplicationPath,
			  data: itemToDelete,
			  success: function (responseText) {
				  console.log(responseText);
				  if (responseText==='OK') {					 
					  $('#deleteCandidateModal').modal('hide');	
					  initializeData ();					  
				  }
			  },
			  dataType: "text"
			});

	}	
	
	//INSERT FUNCTION
	function insert () {
		console.log("insert - START");
		
		var candidateUser_idToInsert = $("#candidateUser_idToInsert").val();
		var candidateCourse_codeToInsert = $("#candidateCourse_codeToInsert").val();
		var candidateCandidacy_date_timeToInsert = $("#candidateCandidacy_date_timeToInsert").val();
		
		console.log("candidateUser_idToInsert: " + candidateUser_idToInsert + " - candidateCourse_codeToInsert: " + candidateCourse_codeToInsert + " - candidateCandidacy_date_timeToInsert: " + candidateCandidacy_date_timeToInsert);
		
		var itemToInsert = {
        		"user_id":candidateUser_idToInsert,
        		"course_code":candidateCourse_codeToInsert,
        		"candidacy_date_time":candidateCandidacy_date_timeToInsert
        }
        
        $.ajax({
			  type: "POST",
			  url: candidatesBackendApplicationPath,
			  data: JSON.stringify(itemToInsert),
			  success: function (data, textStatus, jqXHR) {				 
				  $('#insertCandidateModal').modal('hide');		
			  	  initializeData ();
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
	    xhttp.open("GET", candidatesBackendApplicationPath, true);
	    xhttp.send();
	}
	
	function initializeTable (items) {
		if (items != null) {
			
			var dynamicTableContent  = "<table class='table table-striped table-hover  table-bordered'>";
			dynamicTableContent += "<thead class='thead-dark'><tr>";
			dynamicTableContent += "<th scope='col'></th>" ;
			dynamicTableContent += "<th scope='col'>Id</th>" ;
			dynamicTableContent += "<th scope='col'>User_id</th>" ;
			dynamicTableContent += "<th scope='col'>Course_code</th>" ;
			dynamicTableContent += "<th scope='col'>Candidacy_date_time</th>" ;
			dynamicTableContent += "</tr></thead>" ;
			if (items.length==0) {
				dynamicTableContent += "<tr><td colspan='5'>NON CI SONO CANDIDATI</td></tr>" ;
			} else {
				for (var i=0; i<items.length; i++) {
					dynamicTableContent += "<tr><td scope='col'><input type='radio' name='id' onclick='javascript:abilitaBottone();' value='" + items[i].id + "' /></td>" ;
					dynamicTableContent += "<td>" + items[i].id + "</td>" ;
					dynamicTableContent += "<td>" + items[i].user_id + "</td>" ;
					dynamicTableContent += "<td>" + items[i].course_code + "</td>" ;
					dynamicTableContent += "<td>" + items[i].candidacy_date_time + "</td></tr>" ;
				}
			}
			dynamicTableContent += "</table>" ;
			document.getElementById("tableData").innerHTML = dynamicTableContent ;
		} else {
			document.getElementById("tableData").innerHTML = "ERRORE LATO SERVER. AL MOMENTO NON E' POSSIBILE AVERE LA LISTA DEI CANDIDATI. RIPROVARE PIU? TARDI.";
		}
	}
	
	
	
</script>
<meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>List Candidates</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

</head>
<body>
	<%@include file="header.jsp"%>
<div class="container-fluid">
	<h1 style="text-align: left;">Candidates List</h1>
	<!-- Button trigger Insert Modal -->
	<div style="text-align: right;"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insertCandidateModal"
	onclick="showInsertCandidateModal(); return false;">+</button></div>
	<br>
	<form id="formSelectCandidate">		
		<div id="tableData"></div>		
		<button type="button" class="btn btn-danger"  id="deleteButton" disabled data-toggle="modal" data-target="#deleteCandidateModal">Cancella</button>
        <button type="button" class="btn btn-primary" id="updateButton" data-toggle="modal"  data-target="#updateCandidateModal" onclick="showUpdateCandidateModal(); return false;">MODIFICA</button>
	</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

<!-- Update Modal -->
<div class="modal fade" id="updateCandidateModal" tabindex="-1" candidate="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" candidate="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Update Modal</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="updateCandidateForm">
	      <div class="modal-body">
			
			  	<label>ID</label><br>
		  		<input type="number" name="candidateIdToUpdate" id="candidateIdToUpdate" value=""><br>
		  		
		  		<label>User_id</label><br>
		  		<input type="text" name="candidateUser_idToUpdate" id="candidateUser_idToUpdate" value=""><br>
		  		
		  		<label>Course_code</label><br>
		  		<input type="text" name="candidateCourse_codeToUpdate" id="candidateCourse_codeToUpdate" value=""><br>
			
		  		<label>Candidacy_date_time</label><br>
		  		<input type="text" name="candidateCandidacy_date_timeToUpdate" id="candidateCandidacy_date_timeToUpdate" value=""><br>		  		
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onClick="update();">Save changes</button>
	      </div>
      </form> 
    </div>
  </div>
</div>


<!-- Modal delete-->
<div class="modal fade" id="deleteCandidateModal" tabindex="-1" candidate="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
 <div class="modal-dialog" candidate="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Eliminazione candidate</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Sei sicuro di volre rimuovere questo candidate?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="javascript:deleteCandidate();">SI</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">NO</button>
      </div>
    </div>
  </div>
</div>

<!-- Insert Modal -->
<div class="modal fade" id="insertCandidateModal" tabindex="-1" candidate="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" candidate="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Insert Modal</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="insertCandidateForm">
	      <div class="modal-body">
			
		  		<label>User_id</label><br>
		  		<input type="text" name="candidateUser_idToInsert" id="candidateUser_idToInsert" value=""><br>
		  		
		  		<label>Course_code</label><br>
		  		<input type="text" name="candidateCourse_codeToInsert" id="candidateCourse_codeToInsert" value=""><br>
			
		  		<label>Candidacy_date_time</label><br>
		  		<input type="text" name="candidateCandidacy_date_timeToInsert" id="candidateCandidacy_date_timeToInsert" value=""><br>		  		
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