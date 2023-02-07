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

    var rolesBackendApplicationPath = backendPath+"roles";

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
	
	//SHOW UPDATE MODAL
	function showUpdateRoleModal () {
		console.log("showUpdateRoleModal!!!");
		const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			  console.log(this.responseText);
			  var role = JSON.parse(this.responseText) ;
			  console.log(role);
			  initializeUpdateForm (role);
		    }
		  var id= document.querySelector('input[name="id"]:checked').value;
		  xhttp.open("GET", rolesBackendApplicationPath+"/id="+id, true);
		  xhttp.send();
	}
	
	//SHOW INSERT MODAL
	function showInsertRoleModal () {
		console.log("showInsertRoleModal!!!");
		const xhttp = new XMLHttpRequest();
		  xhttp.onload = function() {
			  console.log(this.responseText);
			  var role = JSON.parse(this.responseText) ;
			  console.log(role);
			  initializeInsertForm (role);
		    }
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
        
        $.ajax({
			  type: "PUT",
			  url: rolesBackendApplicationPath,
			  data: itemToUpdate,
			  success: function (responseText) {
				  console.log(responseText);
				  if (responseText==='OK') {					 
					  $('#updateRoleModal').modal('hide');	
					  initializeData ();					  
				  }
			  },
			  dataType: "text"
			});

	}
	
	//DELETE FUNCTION
	function deleteRole () {
		console.log("deleteRole - START");
		var idToDelete= document.querySelector('input[name="id"]:checked').value;
		console.log("idToDelete: " + idToDelete);

        var itemToDelete = {
        		"id":idToDelete
        }
        
        $.ajax({
			  type: "DELETE",
			  url: rolesBackendApplicationPath,
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
        
        $.ajax({
			  type: "POST",
			  url: rolesBackendApplicationPath,
			  data: itemToInsert,
			  success: function (responseText) {
				  console.log(responseText);
				  if (responseText==='OK') {					 
					  $('#insertRoleModal').modal('hide');		
					  initializeData ();
				  }
			  },
			  dataType: "text"
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
	    xhttp.open("GET", rolesBackendApplicationPath, true);
	    xhttp.send();
	}
	
	function initializeTable (items) {
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
	
	
	
</script>
<meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>List Roles</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

</head>
<body>
	<%@include file="header.jsp"%>
<div class="container-fluid">
	<h1 style="text-align: left;">Roles List</h1>
	<!-- Button trigger Insert Modal -->
	<div style="text-align: right;"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insertRoleModal"
	onclick="showInsertRoleModal(); return false;">+</button></div>
	<br>
	<form id="formSelectRole">		
		<div id="tableData"></div>		
		<button type="button" class="btn btn-danger"  id="deleteButton" disabled data-toggle="modal" data-target="#deleteRoleModal">Cancella</button>
        <button type="button" class="btn btn-primary" id="updateButton" data-toggle="modal"  data-target="#updateRoleModal" onclick="showUpdateRoleModal(); return false;">MODIFICA</button>
	</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

<!-- Update Modal -->
<div class="modal fade" id="updateRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Update Modal</h5>
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
<div class="modal fade" id="deleteRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
 <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Eliminazione role</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Sei sicuro di volre rimuovere questo role?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="javascript:deleteRole();">SI</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">NO</button>
      </div>
    </div>
  </div>
</div>

<!-- Insert Modal -->
<div class="modal fade" id="insertRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Insert Modal</h5>
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



</body>
</html>
<script>
    initializeData();
</script>