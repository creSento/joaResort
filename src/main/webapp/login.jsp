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
  String setAuth = "";
  JoaService js = JoaServiceImpl.getInstance();
  int result = js.login(id, pwd);
  // result -1 - not exist user, 0 - wrong password, 1 - success
  if (result > 0) {
      session.setAttribute("login_ok", "login");
      session.setAttribute("login_id", id);
      if (result == 1) {
          setAuth = "false";
      } else if (result == 2) {
          setAuth = "true";
      }
      session.setAttribute("auth", setAuth);
      response.sendRedirect("./index.jsp");
  }
  session.setAttribute("result", result);
  %>
  <div class="container-fluid">
    <div class="row" style="float: none; margin: 100 auto;">
      <div class="col-md-3" style="float: none; margin: 0 auto;">
        <c:if test="${result == -1 }">
          <script type="text/javascript">
          	alert("존재하지 않는 ID입니다");
          	location.href='./loginForm.jsp';
          </script>
        </c:if>
        <c:if test="${result == 0 }">
        <script type="text/javascript">
          alert("비밀번호 오류입니다");
          location.href='./loginForm.jsp';
        </script>
        </c:if>
      </div>
    </div>
  </div>
</body>
</html>