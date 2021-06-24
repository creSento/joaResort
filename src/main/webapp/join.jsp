<%@page import="com.reservation.domain.JoaUser"%>
<%@page import="com.reservation.service.JoaServiceImpl"%>
<%@page import="com.reservation.service.JoaService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
  <%
  String id = request.getParameter("id");
  String pwd = request.getParameter("pwd");
  String name = request.getParameter("name");
  String tel = request.getParameter("tel");
  JoaService js = JoaServiceImpl.getInstance();
  JoaUser user = new JoaUser(id, pwd, name, tel, false);
  int result = js.join(user);
  // result -1 - not exist user, 0 - wrong password, 1 - success
  if (result > 0) {
      response.sendRedirect("./loginForm.jsp");
  } else {
      
  %>
  <%@ include file="./menu.jsp"%>
  <div class="container-fluid">
    <div class="row" style="float: none; margin: 100 auto;">
      <div class="col-md-3" style="float: none; margin: 0 auto;">
        <div class="text-danger" align="center">
          <h3>오류가 발생했습니다.</h3>
        </div>
      </div>
    </div>
  </div>
  <%
  }
  %>
</body>
</html>