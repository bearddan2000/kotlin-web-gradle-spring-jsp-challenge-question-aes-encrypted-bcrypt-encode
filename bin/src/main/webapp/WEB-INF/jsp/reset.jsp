<!DOCTYPE HTML>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Spring Boot Thymeleaf Security Example</title>


    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css"/>
</head>

<body>
  <nav class="navbar navbar-inverse">
      <div class="container">
          <div class="navbar-header">
              <a class="navbar-brand" href="/">Spring Boot</a>
          </div>
          <div id="navbar" class="collapse navbar-collapse">
              <ul class="nav navbar-nav">
                  <li class="active"><a href="/">Index</a></li>
                  <li><a href="/home">Home</a></li>
                  <li><a href="/admin">Admin</a></li>
                  <li><a href="/user">User</a></li>
                  <li><a href="/super">Super</a></li>
                  <li><a href="/about">About</a></li>
              </ul>
          </div>
      </div>
  </nav>
<div class="container">

  <form:form method="POST" class="form-signin" action="#">
    <h2 class="form-signin-heading">Reset your password</h2>
    <div class="form-group">
        <input type="text" name="username" class="form-control" placeholder="Username" autofocus="true"/>
    </div>

    <div class="form-group">
        <input id="password" type="password" name="password" class="form-control" placeholder="Password"/>
    </div>

    <div class="form-group">
        <input id="matchPassword" type="password" class="form-control" placeholder="Confirm Password"/>
    </div>

    <h2 class="form-signin-heading">Verify your account</h2>
    <div class="form-group" modelAttribute="challengeQuestion">
      <select class="form-control" name="question">
        <c:forEach var="item" items="${challengeQuestionList}" varStatus="loop">
          <option value="${loop.index}">${item}</option>
        </c:forEach>
      </select>
      <input type="text" id="challengeQuestionAnswer" name="answer" class="form-control" placeholder="Security question answer"/>
    </div>
    <div id="globalError" class="alert alert-danger col-sm-12" style="display:none">error</div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Submit</button>
  </form:form>
</div>

<!-- /.container -->
<div class="container">
  <footer>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  </footer>
</div>
<script lang="javascript">
let errormsg = ["Username is blank", "Passwords don't match", "Challenge answer is blank"];

$(document).ready(function () {
    $('form').submit(function(event) {
      event.preventDefault();
      if ($("#username").val() == '') {
        // event.preventDefault();
          $("#globalError").show().html(errormsg[0]);
          return ;
      }
      else if ($("#password").val() != $("#matchPassword").val()){
      //  event.preventDefault();
          $("#globalError").show().html(errormsg[1]);
          return ;
      }
      else if ($("#answer").val() == ''){
      //  event.preventDefault();
          $("#globalError").show().html(errormsg[2]);
          return ;
      }
      $.get('/api/reset'
      ,{
        username: $("#username").val(),
        password: $("#password").val(),
        question: $("#question").val(),
        answer: $("#answer").val()
      }
      , function(data) {
        console.log(data);
        location.href = "/" + data;
      })
   });
    $(":password").keyup(function(){
      if ($("#username").val() == '') {
          $("#globalError").show().html(errormsg[0]);
      }
      else if ($("#password").val() != $("#matchPassword").val()){
          $("#globalError").show().html(errormsg[1]);
      }
      else if ($("#answer").val() == ''){
          $("#globalError").show().html(errormsg[2]);
      }
      else{
          $("#globalError").html("").hide();
      }
    });
});

</script>

</body>
</html>
