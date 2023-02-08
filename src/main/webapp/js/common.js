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