<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./style.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
  <%@ include file="./menu.jsp"%>
  <div class="container-fluid">
    <div class="row" style="float: none; margin:100 auto;">
      <div class="col-md-3" style="float: none; margin:0 auto;">
        <form action="./login.jsp" method="post">
          <div class="form-group">
            <label for="id">ID</label> <input type="text" name="id"
              id="id" class="form-control">
          </div>
          <div class="form-group">
            <label for="pwd">PASSWORD</label> <input type="password"
              name="pwd" id="pwd" class="form-control">
          </div>
          <div class="form-group" align="center">
            <button class="btn btn-success">로그인</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>