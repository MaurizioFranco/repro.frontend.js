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