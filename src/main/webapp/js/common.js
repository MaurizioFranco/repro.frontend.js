/**
 * common variables and functions
 */
var insertMessageOK = "elemento correttamente inserito";
var updateMessageOK = "elemento correttamente modificato";
var deleteMessageOK = "elemento correttamente eliminato";

function showAlertDialog (messageToShow) {
	$('#successAlert').html(messageToShow);
	$('#successAlert').show();
	setTimeout(function() { 
		$('#successAlert').hide();            
    }, 5000);
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
    xhttp.open("GET", backendApplicationPath, true);
    xhttp.send();
}

//DELETE FUNCTION
function deleteItem () {
	console.log("deleteItem - START");
	var idToDelete= document.querySelector('input[name="id"]:checked').value;
	console.log("idToDelete: " + idToDelete);
    $.ajax({
	  type: "DELETE",
	  url: backendApplicationPath+"/"+idToDelete,
	  success: function (responseText) {
			  $('#deleteItemModal').modal('hide');	
			  showAlertDialog(deleteMessageOK);
			  initializeData ();					  
	  },
	  dataType: "text"
	});
}	

function updateItem (itemToUpdate) {
    $.ajax({
	  type: "PUT",
	  url: backendApplicationPath,
	  data: JSON.stringify(itemToUpdate),
	  success: function (data, textStatus, jqXHR) {
		  $('#updateModal').modal('hide');
		  showAlertDialog(updateMessageOK);
	      initializeData ();
	  },
	  headers: {
	      'Content-Type': 'application/json'
	    }
	});
}

function insertItem (itemToInsert) {
        $.ajax({
		  type: "POST",
		  url: backendApplicationPath,
		  data: JSON.stringify(itemToInsert),
		  success: function (data, textStatus, jqXHR) {
			  $('#insertRoleModal').modal('hide');	
			  showAlertDialog(insertMessageOK);
		      initializeData ();
		  },
		  headers: {
		      'Content-Type': 'application/json'
		    }
		});
}