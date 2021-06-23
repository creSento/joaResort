<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
  <%
  LocalDate today = LocalDate.now();
  %>
  <nav class="navbar navbar-default nav-justified">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="./index.jsp"><span class="glyphicon glyphicon-glass" aria-hidden="true"></span>Joa Resort</a>
    </div>
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <div>
        <ul class="nav navbar-nav">
          <!-- master menu -->
          <li class="bg-danger"><a href="./mkdata.jsp">초기화</a></li>
          <li class="bg-danger"><a href="#">예약관리</a></li>
          <!-- user menue -->
          <li><a href="./calendar.jsp?year=<%=today.getYear()%>&month=<%=today.getMonthValue()%>">예약하기</a></li>
        </ul>
      </div>
      <div align="right" style="display: block;">
        <!-- logout -->
        <button type="button" class="btn btn-sm btn-default navbar-btn">회원가입</button>
        <button type="button" class="btn btn-sm btn-default navbar-btn">로그인</button>
        <!-- login -->
        <button type="button" class="btn btn-sm btn-default navbar-btn">로그아웃</button>
      </div>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
</body>
</html>