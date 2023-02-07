<%@page import="java.util.List"%>
<%@page import="java.nio.file.attribute.UserPrincipalLookupService"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>

<link rel="icon" href="./img/Logo-Centauri-Academy-2018.ico">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="./js/env.js"></script>
<style>
</style>

<script type="text/javascript">

var candidateStatesBackendApplicationPath = "http://localhost:9000/repro.rest/candidateState";

	function abilitaBottone() {
		console.log("questa è la console");
 		document.getElementById("buttonDelete").disabled = false;
 		document.getElementById("buttonUpdate").disabled = false;
	}
	
	function initializeUpdateForm (item) {
		console.log("initializeUpdateForm - START - " + item);
		console.log(item);
		document.getElementById("idToUpdate").value = item.id;
		document.getElementById("roleIdToUpdate").value = item.role_id;
		document.getElementById("statusCodeToUpdate").value = item.status_code;
		document.getElementById("statusLabelToUpdate").value = item.status_label;
		document.getElementById("statusDescriptionToUpdate").value = item.status_description;
		document.getElementById("statusColorToUpdate").value = item.status_color;
		
	}
	
	function initializeInsertForm (item) {
		console.log("initializeInsertForm - START - " + item);
		console.log(item);
		document.getElementById("idToInsert").value = item.id;
		document.getElementById("roleIdToInsert").value = item.role_id;
		document.getElementById("statusCodeToInsert").value = item.status_code;
		document.getElementById("statusLabelToInsert").value = item.status_label;
		document.getElementById("statusDescriptionToInsert").value = item.status_description;
		document.getElementById("statusColorToInsert").value = item.status_color;
		}
	
	function showUpdateCandidateStatesModal() {
		console.log("showUpdateCandidateStatesModal!!!");
		const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			  console.log(this.responseText);
			  var candidateState = JSON.parse(this.responseText) ;
			  console.log(candidateState);
			  initializeUpdateForm (CandidateState);
		    }
		  var id= document.querySelector('input[name="candidateStatesRadioId"]:checked').value;
		  xhttp.open("GET", "http://localhost:8080/repro.admin.web/GetRoleServlet?id="+id, true);
		  xhttp.send();
	}
	
	function showInsertCandidateStatesModal() {
		console.log("showInsertCandidateStatesModal!!!");
		const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			  console.log(this.responseText);
			  var role = JSON.parse(this.responseText) ;
			  console.log(candidateState);
			  initializeinsertForm (CandidateState);
		    }
		  var id= document.querySelector('input[name="roleRadioId"]:checked').value;
		  xhttp.open("GET", "http://localhost:8080/repro.admin.web/GetCandidateStatesServlet?id="+id, true);
		  xhttp.send();
	}
	
	function update () {
		console.log("update - START");
		console.log(" prova id " + document.getElementById("idToUpdate").value);
		var idToUpdate = document.getElementById("idToUpdate").value ; 
		var statusRoleIdToUpdate = document.getElementById("roleIdToUpdate").value ; 
		var statusCodeToUpdate = document.getElementById("statusCodeToUpdate").value ; 
		var statusLabelToUpdate = document.getElementById("statusLabelToUpdate").value ; 
		var statusDescriptionToUpdate = document.getElementById("statusDescriptionToUpdate").value ; 
		var statusColorToUpdate = document.getElementById("statusColorToUpdate").value ; 
		
		console.log("idToUpdate: " + idToUpdate + " - roleIdToUpdate: " + roleIdToUpdate + " - statusCodeToUpdate: " + statusCodeToUpdate + " - statusLabelToUpdate: " + statusLabelToUpdate + "statusDescriptionToUpdate" + statusDescriptionToUpdate + "statusColorToUpdate" + statusColorToUpdate);
		
        var itemToUpdate = {
        		"id":idToUpdate,
        		"role_id":roleIdToUpdate,
        		"status_code":statusCodeToUpdate,
        		"status_label":statusLabelToUpdate,
        		"status_desciption":statusDescriptionToUpdate,
        		"status_color":statusColorToUpdate
        }
        
        $.ajax({
			  type: "POST",
			  url: "http://localhost:8080/repro.admin.web/UpdateCandidateStatesServlet",
			  data: itemToUpdate,
			  success: function (responseText) {
				  console.log(responseText);
				  if (responseText==='OK') {					 
					  $('#updateRoleModal').modal('hide');		
					  location.reload();
// 					  $('#errorUpdateMessage').show();
// 					  $('#errorUpdateMessage').html(responseText);
// 				  } else {
					  
				  }
			  },
			  dataType: "text"
			});

	}
	
	function insert () {
		console.log("insert - START");
			
		console.log("idToInsert: " + idToInsert + " - roleIdToInsert: " + roleIdToInsert + " - statusCodeToInsert: " + statusCodeToInsert + " - statusLabelToInsert: " + statusLabelToInsert + "statusDescriptionToInsert" + statusDescriptionToInsert + "statusColorToInsert" + statusColorToInsert);
		
		var itemToInsert = {
				"id":idToInsert,
				"role_id":roleIdToInsert,
				"status_code":statusCodeToInsert,
				"status_label":statusLabelToInsert,
				"status_desciption":statusDescriptionToInsert,
				"status_color":statusColorToInsert

        }
        
        $.ajax({
			  type: "POST",
			  url: candidateStatesBackendApplicationPath,
			  data: itemToInsert,
			  success: function (responseText) {
				  console.log(responseText);
				  if (responseText==='OK') {					 
					  $('#insertCandidateStatesModal').modal('hide');		
					  initializeData ();
				  }
			  },
			  dataType: "text"
			});
	}
	
	function deleteCandidateStates () {
		console.log("deleteCandidateStates - START");
		var idToDelete= document.querySelector('input[name="id"]:checked').value;
		console.log("idToDelete: " + idToDelete);

        var itemToDelete = {
        		"id":idToDelete
        }
        
        $.ajax({
			  type: "DELETE",
			  url: candidateStatesBackendApplicationPath,
			  data: itemToDelete,
			  success: function (responseText) {
				  console.log(responseText);
				  if (responseText==='OK') {					 
					  $('#deleteRoleModal').modal('hide');	
					  initializeData ();					  
				  }
			  },
			  dataType: "text"
			});

	}	
	
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
	    xhttp.open("GET", candidateStatesBackendApplicationPath, true);
	    xhttp.send();
	}
	
	function initializeTable (items) {
		if (items != null) {
			
			var dynamicTableContent  = "<table class='table table-striped table-hover  table-bordered'>";
			dynamicTableContent += "<thead class='thead-dark'><tr>";
			dynamicTableContent += "<th scope='col'></th>" ;
			dynamicTableContent += "<th scope='col'>Id</th>" ;
			dynamicTableContent += "<th scope='col'>RoleId</th>" ;
			dynamicTableContent += "<th scope='col'>Status Code</th>" ;
			dynamicTableContent += "<th scope='col'>Label</th>" ;
			dynamicTableContent += "<th scope='col'>Description</th>" ;
			dynamicTableContent += "<th scope='col'>Color</th>" ;
			dynamicTableContent += "</tr></thead>" ;
			if (items.length==0) {
				dynamicTableContent += "<tr><td colspan='5'>NON CI SONO CANDIDATESTATES</td></tr>" ;
			} else {
				for (var i=0; i<items.length; i++) {
					dynamicTableContent += "<tr><td scope='col'><input type='radio' name='id' onclick='javascript:abilitaBottone();' value='" + items[i].id + "' /></td>" ;
					dynamicTableContent += "<td>" + items[i].id + "</td>" ;
					dynamicTableContent += "<td>" + items[i].role_id + "</td>" ;
					dynamicTableContent += "<td>" + items[i].status_code + "</td>" ;
					dynamicTableContent += "<td>" + items[i].status_label + "</td>" ;
					dynamicTableContent += "<td>" + items[i].status_description + "</td></tr>" ;
					dynamicTableContent += "<td>" + items[i].status_color + "</td></tr>" ;
					
}
			}
			
			dynamicTableContent += "</table>" ;
			document.getElementById("tableData").innerHTML = dynamicTableContent ;
		} else {
			document.getElementById("tableData").innerHTML = "ERRORE LATO SERVER. AL MOMENTO NON E' POSSIBILE AVERE LA LISTA DEI RUOLI. RIPROVARE PIU? TARDI.";
		}
	}
	
	
	
</script>
<meta charset="ISO-8859-1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>List Candidate States</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">

</head>
<body>
	<%@include file="header.jsp"%>
	<div class="container-fluid">
		<h1 style="text-align: left;">CandidateSates List</h1>
		<!-- Button trigger Insert Modal -->
		<div style="text-align: right;">
			<button type="button" class="btn btn-primary" data-toggle="modal"
				data-target="#insertCandidateSatesModal"
				onclick="showInsertCandidateStatesModal(); return false;">+</button>
		</div>
		<br>
		<form id="formSelectRole">
			<div id="tableData"></div>
			<button type="button" class="btn btn-danger" id="deleteButton"
				disabled data-toggle="modal"
				data-target="#deleteCadnidateStatesModal">Cancella</button>
			<button type="button" class="btn btn-primary" id="updateButton"
				data-toggle="modal" data-target="#updateCandidateStatesModal"
				onclick="showUpdateCadnidateStatesModal(); return false;">MODIFICA</button>
		</form>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
		integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
		integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
		crossorigin="anonymous"></script>

	<!-- Modal Update-->
	<div class="modal fade" id="updateCandidateStatesModal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLongTitle"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="updateRoleForm">
					<div class="modal-body">

						<label>ID</label><br> <input type="number" name="idToUpdate"
							id="idToUpdate" value=""><br> <label>Role Id</label><br>
						<input type="number" name="roleIdToUpdate" id="roleIdToUpdate"
							value=""><br> <label>Status code</label><br> <input
							type="number" name="statusCodeToUpdate" id="statusCodeToUpdate"
							value=""><br> <label>Status Label</label><br> <input
							type="text" name="statusLabelToUpdate" id="statusLabelToUpdate"
							value=""><br> <label>Status Description</label><br>
						<input type="text" name="statusDescriptionToUpdate"
							id="statusDescriptionToUpdate" value=""><br> <label>Status
							Color</label><br> <input type="text" name="statusColorToUpdate"
							id="statusColorToUpdate" value=""><br>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary" onClick="update();">Save
							changes</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Modal delete-->
	<div class="modal fade" id="deleteCandidateStatesModal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLongTitle"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Eliminazione CandidateStates</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>Sei sicuro di volre rimuovere questo CandidateStates?</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						onclick="javascript:deleteCandidateStates();">SI</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">NO</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Insert Modal -->
	<div class="modal fade" id="insertRoleModal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLongTitle"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle">Insert
						Modal</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="insertRoleForm">
					<div class="modal-body">

						<label>RoleId</label><br> <input type="text"
							name="roleIdToInsert" id="roleIdToInsert" value=""><br>

						<label>Status Code</label><br> <input type="text"
							name="statusCodeToInsert" id="statusCodeToInsert" value=""><br>

						<label>Status Label</label><br> <input type="text"
							name="statusLabelToInsert" id="statusLabelToInsert" value=""><br>

						<label>Status Description</label><br> <input type="text"
							name="statusDescriptionToInsert" id="statusDescriptionToInsert"
							value=""><br> <label>Status Color</label><br> <input
							type="text" name="statusColorToInsert" id="statusColorToInsert"
							value=""><br>


					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary"
							onClick="insert(); return false;">Save</button>
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