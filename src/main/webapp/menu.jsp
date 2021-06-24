<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
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
<script type="text/javascript">
  function init() {
	var init = confirm("초기화 하시겠습니까?");
	if (init) {
	  location.href="./mkdata.jsp";
	}
  }
</script>
</head>
<body>
  <%
  request.setCharacterEncoding("utf-8");
  LocalDate today = LocalDate.now();
  String loginOK = (String) session.getAttribute("login_ok");
  String loginID = (String) session.getAttribute("login_id");
  boolean auth = Boolean.parseBoolean((String)session.getAttribute("auth"));
  %>
  <nav class="navbar navbar-default nav-justified" style="margin-bottom: 2em;">
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
          <c:if test="${login_ok eq 'login' && auth }">
          <li class="bg-danger" onclick="init()"><a href="#">초기화</a></li>
          <li class="bg-danger"><a href="./calendarManage.jsp">예약관리</a></li>
          </c:if>
          <!-- user menue -->
          <c:if test="${!auth }">
          <li><a href="./calendar.jsp?year=<%=today.getYear()%>&month=<%=today.getMonthValue()%>">예약하기</a></li>
          </c:if>
          <c:if test="${login_ok eq 'login' && !auth }">
          <li><a href="./myCalendar.jsp">마이페이지</a></li>
          </c:if>
        </ul>
      </div>
      <div align="right" style="display: block;">
        <!-- logout -->
        <c:if test="${empty login_ok || login_ok != 'login'}">
        <a href="./joinForm.jsp">
        <button type="button" class="btn btn-sm btn-default navbar-btn">회원가입</button>
        </a>
        <a href="./loginForm.jsp">
        <button type="button" class="btn btn-sm btn-default navbar-btn">로그인</button>
        </a>
        </c:if>
        <!-- login -->
        <c:if test="${login_ok eq 'login'}">
        <span class="text-info" style="margin-right: 1em;"><%=loginID %> 님, 환영합니다.</span>
        <a href="./logout.jsp">
        <button type="button" class="btn btn-sm btn-default navbar-btn">로그아웃</button>
        </a>
        </c:if>
      </div>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
</body>
</html>