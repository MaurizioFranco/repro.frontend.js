
<%@page import="java.util.List"%>


<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    String deleteStatus = null ; 
    if (request.getAttribute("deleteConfirmed")!=null) { 
	    deleteStatus = ""+request.getAttribute("deleteConfirmed");
    }
	
    String insertStatus = null;
    if(request.getAttribute("insertConfirmed")!=null){
    	insertStatus = ""+request.getAttribute("insertConfirmed");
    }
%>
<html>

<head>
<meta charset="ISO-8859-1">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<%-- 	 <%@include file="authentication.jsp"%> --%>
	 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">

<title>Questions</title>
<link rel="icon" type="image/ico" href="./img/Logo-Centauri-Academy-2018.ico">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="./js/env.js"></script>
<script src="./js/common.js"></script>
<script type="text/javascript">
// 			alert("sono qui");
			
			var backendApplicationPath = backendApplicationPath + "question";
			
			insertMessageOK = "Question correttamente inserita";
		    updateMessageOK = "Question correttamente modificata";
		    deleteMessageOK = "Question correttamente eliminata";
			
			function abilitaButton(){
				console.log("Questa � la funzione");
				document.getElementById("deleteButton").disabled=false;
				document.getElementById("modifyButton").disabled=false;
				
			}			
			
			function modifyQuestion(){
				console.log("modifica");
				showUpdateModal();
			}		

			function initializeUpdateForm (item) {
				console.log("initializeUpdateForm - START - " + item);
				console.log(item);
				document.getElementById("questionIdToUpdate").value = item.id;
				document.getElementById("questionLabelToUpdate").value = item.label;
				document.getElementById("questionDescriptionToUpdate").value = item.description;
			}
			
			//INITIALIZE INSERT FORM
			function initializeInsertForm (item) {
				console.log("initializeInsertForm - START - " + item);
				console.log(item);
				document.getElementById("questionIdToUpdate").value = item.id;
				document.getElementById("questionLabelToUpdate").value = item.label;
				document.getElementById("questionDescriptionToUpdate").value = item.description;
			}

		//UPDATE FUNCTION
		function update() {
			console.log("update - START");
			var idToUpdate = $("#questionIdToUpdate").val();
			var questionLabelToUpdate = $("#questionLabelToUpdate").val();
			var questionDescriptionToUpdate = $("#questionDescriptionToUpdate").val();
			console.log(idToUpdate,questionLabelToUpdate,questionDescriptionToUpdate);
			
			var itemToUpdate = {
				"id":idToUpdate,
				"label":questionLabelToUpdate,
				"description":questionDescriptionToUpdate
			}
			
			updateItem (itemToUpdate);
		}
		
		//INSERT FUNCTION
		function insert() {
			console.log("insert - START");
			var questionLabelToInsert = $("#questionLabelToInsert").val();
			var questionDescriptionToInsert = $("#questionDescriptionToInsert").val();
			
			console.log("questionLabelToInsert: " + questionLabelToInsert + " - questionDescriptionToInsert: " + questionDescriptionToInsert);
			
			var itemToInsert = {
					"label":questionLabelToInsert,
					"description":questionDescriptionToInsert
	        }
	        
			insertItem (itemToInsert);
		}
		
		function initializeTable (items) {
			console.log("initializeTable - START");
			console.log("Item");
			console.log(items.length);
			if (items != null) {
				
				var dynamicTableContent  = "<table class='table table-striped table-hover  table-bordered'>";
				dynamicTableContent += "<thead class='thead-dark'><tr>";
				dynamicTableContent += "<th scope='col'></th>" ;
				dynamicTableContent += "<th scope='col'>Id</th>" ;
				dynamicTableContent += "<th scope='col'>Label</th>" ;
				dynamicTableContent += "<th scope='col'>Description</th>" ;
				dynamicTableContent += "<th scope='col'>Ans_a</th>" ;
				dynamicTableContent += "<th scope='col'>Ans_b</th>" ;
				dynamicTableContent += "<th scope='col'>Ans_c</th>" ;
				dynamicTableContent += "<th scope='col'>Ans_d</th>" ;
				dynamicTableContent += "<th scope='col'>Ans_e</th>" ;
				dynamicTableContent += "<th scope='col'>Ans_f</th>" ;
				dynamicTableContent += "<th scope='col'>Ans_g</th>" ;
				dynamicTableContent += "<th scope='col'>Ans_h</th>" ;
				dynamicTableContent += "<th scope='col'>Cans_a</th>" ;
				dynamicTableContent += "<th scope='col'>Cans_b</th>" ;
				dynamicTableContent += "<th scope='col'>Cans_c</th>" ;
				dynamicTableContent += "<th scope='col'>Cans_d</th>" ;
				dynamicTableContent += "<th scope='col'>Cans_e</th>" ;
				dynamicTableContent += "<th scope='col'>Cans_f</th>" ;
				dynamicTableContent += "<th scope='col'>Cans_g</th>" ;
				dynamicTableContent += "<th scope='col'>Cans_h</th>" ;
				dynamicTableContent += "<th scope='col'>Full answer</th>" ;
				dynamicTableContent += "</tr></thead>" ;
				if (items.length==0) {
					dynamicTableContent += "<tr><td colspan='20'>NON CI SONO DOMANDE</td></tr>" ;
				} else {
					for (var i=0; i<items.length; i++) {
						dynamicTableContent += "<tr><td scope='col'><input type='radio' name='id' onclick='javascript:abilitaButton();' value='" + items[i].id + "' /></td>" ;
						dynamicTableContent += "<td>" + items[i].id + "</td>" ;
						dynamicTableContent += "<td>" + items[i].label + "</td>" ;
						dynamicTableContent += "<td>" + items[i].description + "</td>" ;
						dynamicTableContent += "<td>" + items[i].ansa + "</td>" ;
						dynamicTableContent += "<td>" + items[i].ansb + "</td>" ;
						dynamicTableContent += "<td>" + items[i].ansc + "</td>" ;
						dynamicTableContent += "<td>" + items[i].ansd + "</td>" ;
						dynamicTableContent += "<td>" + items[i].anse + "</td>" ;
						dynamicTableContent += "<td>" + items[i].ansf + "</td>" ;
						dynamicTableContent += "<td>" + items[i].ansg + "</td>" ;
						dynamicTableContent += "<td>" + items[i].ansh + "</td>" ;
						dynamicTableContent += "<td>" + items[i].cansa + "</td>" ;
						dynamicTableContent += "<td>" + items[i].cansb + "</td>" ;
						dynamicTableContent += "<td>" + items[i].cansc + "</td>" ;
						dynamicTableContent += "<td>" + items[i].cansd + "</td>" ;
						dynamicTableContent += "<td>" + items[i].canse + "</td>" ;
						dynamicTableContent += "<td>" + items[i].cansf + "</td>" ;
						dynamicTableContent += "<td>" + items[i].cansg + "</td>" ;
						dynamicTableContent += "<td>" + items[i].cansh + "</td>" ;
						dynamicTableContent += "<td>" + items[i].full_answer + "</td></tr>" ;
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
<body>
<%@include file="header.jsp"%>
				
	<div class="container-fluid">
		<div class="alert alert-success" role="alert" id="successAlert">
		  A simple success alert—check it out!
		</div>
		<div class="alert alert-danger" role="alert" id="dangerAlert">
		  A simple danger alert—check it out!
		</div>
		<h1 style="text-align: left;">Questions List</h1>
		<!-- Button trigger Insert Modal -->
		<div style="text-align: right;">
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insertModal" onclick="showInsertModal(); return false;">+</button>
		</div>
		<br>
		<form id="selectionForm">
				
				<div id="tableData">
			    
				</div>
	
				<button type="button" class="btn btn-danger" id="deleteButton" disabled data-toggle="modal" data-target="#deleteItemModal">Cancella</button>
				<button type="button" class="btn btn-primary" id="modifyButton" disabled data-toggle="modal" data-target="#updateModal" onclick="showUpdateModal(); return false;">MODIFICA</button>
		
		</form>
	</div>
			
	<!-- Modal UPDATE-->
		<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <form action="./UpdateQuestionServlet" method="post">
			      <div class="modal-body">
					
					  	<label>ID</label><br>
				  		<input type="number" name="questionIdToUpdate" id="questionIdToUpdate" value=""><br>
				  		
				  		<label>Label</label><br>
				  		<input type="text" name="questionLabelToUpdate" id="questionLabelToUpdate" value=""><br>
				  		
				  		<label>Description</label><br>
				  		<input type="text" name="questionDescriptionToUpdate" id="questionDescriptionToUpdate" value=""><br>
					
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <button type="button" class="btn btn-primary" onClick="update();">Save changes</button>
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
		        <h5 class="modal-title">Eliminazione question</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <p>Sei sicuro di volre rimuovere questa Question?</p>
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
     			<form id="insertRoleForm">
	      		<div class="modal-body">
			
		  		<label>Label</label><br>
		  		<input type="text" name="roleLabelToInsert" id="questionLabelToInsert" value=""><br>
		  		
		  		<label>Description</label><br>
		  		<input type="text" name="roleDescriptionToInsert" id="questionDescriptionToInsert" value=""><br>
					  		
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