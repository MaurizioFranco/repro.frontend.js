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

    backendApplicationPath = backendApplicationPath+"roles";
    
    insertMessageOK = "ruolo correttamente inserito";
    updateMessageOK = "ruolo correttamente modificato";
    deleteMessageOK = "ruolo correttamente eliminato";
        
  //INSERT FUNCTION
	function insert () {
		console.log("insert - START");
		
		var roleLabelToInsert = $("#roleLabelToInsert").val();
		var roleDescriptionToInsert = $("#roleDescriptionToInsert").val();
		var roleLevelToInsert = $("#roleLevelToInsert").val();
		
		console.log("roleLabelToInsert: " + roleLabelToInsert + " - roleDescriptionToInsert: " + roleDescriptionToInsert + " - roleLevelToInsert: " + roleLevelToInsert);
		
		var itemToInsert = {
        		"label":roleLabelToInsert,
        		"description":roleDescriptionToInsert,
        		"level":roleLevelToInsert
        }
	
		insertItem (itemToInsert) ;
	}
    

	function abilitaBottone() {
		console.log("questa è la console");
 		document.getElementById("deleteButton").disabled = false;
 		document.getElementById("updateButton").disabled = false;
	}
	
	//INITIALIZE UPDATE FORM
	function initializeUpdateForm (item) {
		console.log("initializeUpdateForm - START - " + item);
		console.log(item);
		document.getElementById("roleIdToUpdate").value = item.id;
		document.getElementById("roleLabelToUpdate").value = item.label;
		document.getElementById("roleDescriptionToUpdate").value = item.description;
		document.getElementById("roleLevelToUpdate").value = item.level;
	}
	
	//INITIALIZE INSERT FORM
	function initializeInsertForm (item) {
		console.log("initializeInsertForm - START - " + item);
		console.log(item);
		document.getElementById("roleIdToInsert").value = item.id;
		document.getElementById("roleLabelToInsert").value = item.label;
		document.getElementById("roleDescriptionToInsert").value = item.description;
		document.getElementById("roleLevelToInsert").value = item.level;
	}
	
	//UPDATE FUNCTION
	function update () {
		console.log("update - START");
		var idToUpdate = document.getElementById("roleIdToUpdate").value ; 
		var roleLabelToUpdate = document.getElementById("roleLabelToUpdate").value ; 
		var roleDescriptionToUpdate = document.getElementById("roleDescriptionToUpdate").value ; 
		var roleLevelToUpdate = document.getElementById("roleLevelToUpdate").value ; 
		console.log("idToUpdate: " + idToUpdate + " - roleLabelToUpdate: " + roleLabelToUpdate + " - roleDescriptionToUpdate: " + roleDescriptionToUpdate + " - roleLevelToUpdate: " + roleLevelToUpdate);

        var itemToUpdate = {
        		"id":idToUpdate,
        		"label":roleLabelToUpdate,
        		"description":roleDescriptionToUpdate,
        		"level":roleLevelToUpdate
        }
        
        updateItem (itemToUpdate) ;
	}
	
	function initializeRoles (items) {
		if (items != null) {
			
			var dynamicTableContent  = "<table class='table table-striped table-hover  table-bordered'>";
			dynamicTableContent += "<thead class='thead-dark'><tr>";
			dynamicTableContent += "<th scope='col'></th>" ;
			dynamicTableContent += "<th scope='col'>Id</th>" ;
			dynamicTableContent += "<th scope='col'>Label</th>" ;
			dynamicTableContent += "<th scope='col'>Description</th>" ;
			dynamicTableContent += "<th scope='col'>Level</th>" ;
			dynamicTableContent += "</tr></thead>" ;
			if (items.length==0) {
				dynamicTableContent += "<tr><td colspan='5'>NON CI SONO RUOLI</td></tr>" ;
			} else {
				for (var i=0; i<items.length; i++) {
					dynamicTableContent += "<tr><td scope='col'><input type='radio' name='id' onclick='javascript:abilitaBottone();' value='" + items[i].id + "' /></td>" ;
					dynamicTableContent += "<td>" + items[i].id + "</td>" ;
					dynamicTableContent += "<td>" + items[i].label + "</td>" ;
					dynamicTableContent += "<td>" + items[i].description + "</td>" ;
					dynamicTableContent += "<td>" + items[i].level + "</td></tr>" ;
				}
			}
			dynamicTableContent += "</table>" ;
			document.getElementById("tableData").innerHTML = dynamicTableContent ;
		} else {
			document.getElementById("tableData").innerHTML = "ERRORE LATO SERVER. AL MOMENTO NON E' POSSIBILE AVERE LA LISTA DEI RUOLI. RIPROVARE PIU? TARDI.";
		}
	}
	
	function initializeCandidates (items) {
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
<title>List Roles</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

</head>
<body>
	<%@include file="header.jsp"%>
    <div class="container-fluid">
	    <div class="alert alert-success" role="alert" id="successAlert">
		  A simple success alert—check it out!
		</div>
		<div class="alert alert-danger" role="alert" id="dangerAlert">
		  A simple danger alert—check it out!
		</div>
		    
		<h1 style="text-align: left;">Roles List</h1>
		<!-- Button trigger Insert Modal -->
		<div style="text-align: right;"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insertRoleModal"
		onclick="showInsertModal(); return false;">+</button></div>
		<br>
		<form id="formSelectRole">		
			<div id="tableData"></div>		
			<button type="button" class="btn btn-danger"  id="deleteButton" disabled data-toggle="modal" data-target="#deleteItemModal">Cancella</button>
	        <button type="button" class="btn btn-primary" id="updateButton" data-toggle="modal"  data-target="#updateModal" onclick="showUpdateModal(); return false;">MODIFICA</button>
		</form>
    </div>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

<!-- ROLES -->

<!-- Update Role Modal -->
<div class="modal fade" id="updateRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Update Role Modal</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="updateRoleForm">
	      <div class="modal-body">
			
			  	<label>ID</label><br>
		  		<input type="number" name="roleIdToUpdate" id="roleIdToUpdate" value=""><br>
		  		
		  		<label>Label</label><br>
		  		<input type="text" name="roleLabelToUpdate" id="roleLabelToUpdate" value=""><br>
		  		
		  		<label>Description</label><br>
		  		<input type="text" name="roleDescriptionToUpdate" id="roleDescriptionToUpdate" value=""><br>
			
		  		<label>Level</label><br>
		  		<input type="number" name="roleLevelToUpdate" id="roleLevelToUpdate" value=""><br>		  		
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
<div class="modal fade" id="deleteItemModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
 <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Eliminazione elemento</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Sei sicuro di voler rimuovere questo elemento?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="javascript:deleteItem();">SI</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">NO</button>
      </div>
    </div>
  </div>
</div>

<!-- Insert Role Modal -->
<div class="modal fade" id="insertRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Inserimento ruolo</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="insertRoleForm">
	      <div class="modal-body">
			
		  		<label>Label</label><br>
		  		<input type="text" name="roleLabelToInsert" id="roleLabelToInsert" value=""><br>
		  		
		  		<label>Description</label><br>
		  		<input type="text" name="roleDescriptionToInsert" id="roleDescriptionToInsert" value=""><br>
			
		  		<label>Level</label><br>
		  		<input type="number" name="roleLevelToInsert" id="roleLevelToInsert" value=""><br>		  		
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onClick="insert(); return false;">Save</button>
	      </div>
      </form> 
    </div>
  </div>
</div>

<!-- CANDIDATES -->

<!-- Update Modal -->
<div class="modal fade" id="updateModal" tabindex="-1" candidate="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
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
			
<!-- 		  		<label>Candidacy_date_time</label><br> -->
<!-- 		  		<input type="text" name="candidateCandidacy_date_timeToUpdate" id="candidateCandidacy_date_timeToUpdate" value=""><br>		  		 -->
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
<div class="modal fade" id="deleteItemModal" tabindex="-1" candidate="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
 <div class="modal-dialog" candidate="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Eliminazione candidate</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Sei sicuro di voler rimuovere questo candidato?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="javascript:deleteItem();">SI</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">NO</button>
      </div>
    </div>
  </div>
</div>

<!-- Insert Modal -->
<div class="modal fade" id="insertModal" tabindex="-1" candidate="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
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
			
<!-- 		  		<label>Candidacy_date_time</label><br> -->
<!-- 		  		<input type="text" name="candidateCandidacy_date_timeToInsert" id="candidateCandidacy_date_timeToInsert" value=""><br>		  		 -->
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