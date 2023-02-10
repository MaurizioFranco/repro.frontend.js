<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Header</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-dark">
<ul class="navbar-nav mr-auto">
	<li class="nav-item">
		<img src="./img/Logo-Centauri-Academy-2018.jpg" alt="Logo"  style="width:40px;">
	</li>
	<li>&nbsp;</li>
	<li class="nav-item hover">
		<a class="navbar-brand text-white">Repro.admin.web</a>
	</li>
	<li class="nav-item dropdown">
		 <a class="nav-link dropdown-toggle text-white" role="button" data-toggle="dropdown" aria-expanded="false">Admin</a>
		 <div class="dropdown-menu">
         	<a class="dropdown-item" id="entityButton" data-toggle="modal" data-target="#insertModal"
		 	onclick="showInsertModal(); return false;">Roles</a>
            
            <a class="dropdown-item" id="entityButton" data-toggle="modal" data-target="#insertModal"
		    onclick="showInsertModal(); return false;">Users</a>
          
            <a class="dropdown-item" id="entityButton" data-toggle="modal" data-target="#insertModal"
		    onclick="showInsertModal(); return false;">Candidates</a>
		  
		    <a class="dropdown-item" id="entityButton" data-toggle="modal" data-target="#insertModal"
		    onclick="showInsertModal(); return false;">CandidateStates</a>
		  </div>
	</li>
	<li class="nav-item dropdown">
		 <a class="nav-link dropdown-toggle text-white" role="button" data-toggle="dropdown" aria-expanded="false">Survey</a>
		 <div class="dropdown-menu">
          <a class="dropdown-item" href="surveys.jsp">Surveys</a>
          <a class="dropdown-item" href="surveyreplies.jsp">Survey Replies</a>
          <a class="dropdown-item" href="surveyquestions.jsp">Survey Questions</a>
          <a class="dropdown-item" href="questions.jsp">Questions</a>
		 </div>
	</li>
	<li class="nav-item dropdown">
		 <a class="nav-link dropdown-toggle text-white" role="button" data-toggle="dropdown" aria-expanded="false">Admin (LEGACY)</a>
		 <div class="dropdown-menu">
          <a class="dropdown-item" href="role.jsp">Roles</a>
          <a class="dropdown-item" href="user.jsp">Users</a>
          <a class="dropdown-item" href="candidates.jsp">Candidates</a>
		 <a class="dropdown-item" href="candidatestates.jsp">CandidateStates</a>
		 </div>
	</li>
	<li class="nav-item dropdown">
		 <a class="nav-link dropdown-toggle text-white" role="button" data-toggle="dropdown" aria-expanded="false">Survey (LEGACY)</a>
		 <div class="dropdown-menu">
          <a class="dropdown-item" href="surveys.jsp">Surveys</a>
          <a class="dropdown-item" href="surveyreplies.jsp">Survey Replies</a>
          <a class="dropdown-item" href="surveyquestions.jsp">Survey Questions</a>
          <a class="dropdown-item" href="questions.jsp">Questions</a>
		 </div>
	</li>
   	</ul>
   	<ul class="navbar-nav">
  	<li class="nav-item square rounded p-1">
  		<span class="navbar-text text-white"> Welcome <%= session.getAttribute("userLoggedEmail") %> </span>
   	</li> 
	<li class="nav-item square rounded p-1 hover">
  		<a class="nav-link text-danger ml-auto" href="LogoutServlet">Logout</a>
   	</li> 
   	
   	
  </ul>
</nav>
<br>

<% 
if(request.getAttribute("deleteUser") == "OK"){ %>
	<p> Deleted user </p>
<% } %>
<% 
if(request.getAttribute("deleteUser") == "KO"){ %>
	<p> Unable to delete user </p>
<% } %>

<% 
if(request.getAttribute("deleteRole") == "OK"){ %>
	<p> Deleted role </p>
<% } %>
<% 
if(request.getAttribute("deleteRole") == "KO"){ %>
	<p> Unable to delete role </p>
<% } %>

<% 
if(request.getAttribute("deleteSurveyquestions") == "OK"){ %>
	<p> Deleted Survey Questions </p>
<% } %>
<% 
if(request.getAttribute("deleteSurveyquestions") == "KO"){ %>
	<p> Unable to delete Survey Questions </p>
<% } %>

<% 
if(request.getAttribute("deleteCandidates") == "OK"){ %>
	<p> Deleted Candidates </p>
<% } %>
<% 
if(request.getAttribute("deleteCandidates") == "KO"){ %>
	<p> Unable to delete Candidates </p>
<% } %>

<% 
if(request.getAttribute("updateUser") == "OK"){ %>
	<p> Updated user</p>
<% } %>
<% 
if(request.getAttribute("updateUser") == "KO"){ %>
	<p> Unable to update user  </p>
<% } %>

<% 
if(request.getAttribute("updateRole") == "OK"){ %>
	<p> Updated role </p>
<% } %>
<% 
if(request.getAttribute("updateRole") == "KO"){ %>
	<p> Unable to update role  </p>
<% } %>

<% 
if(request.getAttribute("insertRole") == "OK"){ %>
	<p> Inserted role </p>
<% } %>
<% 
if(request.getAttribute("insertRole") == "KO"){ %>
	<p> Unable to insert role  </p>
<% } %>

<%
if(request.getAttribute("insertSurveyquestions") == "OK"){ %>
	<p> Inserted Survey Questions </p>
<% } %>
<% 
if(request.getAttribute("insertSurveyquestions") == "KO"){ %>
	<p> Unable to insert  Survey Questions  </p>
<% } %>

<%
if(request.getAttribute("insertCandidates") == "OK"){ %>
	<p> Inserted Candidates </p>
<% } %>
<% 
if(request.getAttribute("insertCandidates") == "KO"){ %>
	<p> Unable to insert Candidates  </p>
<% } %>


<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

</body>
</html>