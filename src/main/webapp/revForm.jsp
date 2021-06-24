<%@page import="com.reservation.domain.JoaUser"%>
<%@page import="com.reservation.domain.JoaCalendar"%>
<%@page import="com.reservation.domain.JoaItem"%>
<%@page import="java.util.List"%>
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
<script type="text/javascript">
  $(function() {
	$("#date-option").change(function () {
	  	var changeDate = $(this).val();
    	console.log(changeDate);
    	location.href="./revForm.jsp?resv_date=" + changeDate + "&room=0";
  })
  })
</script>
  <%@ include file="./menu.jsp"%>
  <%
  String resv_date = request.getParameter("resv_date");
  String room = request.getParameter("room");
  JoaService js = JoaServiceImpl.getInstance();
  LocalDate resvMonth = LocalDate.parse(resv_date);
  JoaCalendar cal = js.getCalendar(resvMonth.getYear(), resvMonth.getMonthValue());
  boolean[] dailyBooked = js.dailyBooked(cal, resv_date);
  JoaUser user = js.getUser(loginID);
  session.setAttribute("resv_date", resv_date);
  session.setAttribute("room", room);
  session.setAttribute("cal", cal);
  session.setAttribute("user", user);
  session.setAttribute("dailyBooked", dailyBooked);
  session.setAttribute("roomName", JoaItem.ROOMNAME);
  %>
  <div class="container">
    <div class="row">
      <div class="col-md-9">
        <form action="./reserve.jsp" method="post">
          <div class="form-group">
            <label for="name">이름</label> <input type="text" name="name"
              id="name" class="form-control" value="<%=user.getName()%>">
          </div>
          <div class="form-group">
            <label for="resv_date">예약일</label> 
            <select class="form-control" id="date-option" name="resv_date">
              <c:forEach var="cal" items="${cal.dateString }">
                <c:choose>
                  <c:when test="${cal eq resv_date}">
                    <option value="${cal }" selected="selected">
                      ${cal }
                    </option>
                  </c:when>
                  <c:otherwise>
                    <option value="${cal }">
                      ${cal }
                    </option>
                  </c:otherwise>                
                </c:choose>
              </c:forEach>  
            </select>
          </div>
          <div class="form-group">
            <label for="room">방</label> 
            <select class="form-control" name="room">
              <c:forEach var="item" items="${dailyBooked }"
                varStatus="i">
                <c:choose>
                  <c:when test="${room != i.index && item == false}">
                    <option value="${i.index }">${roomName[i.index] }</option>
                  </c:when>
                  <c:when test="${room == i.index && item == false}">
                    <option value="${i.index }" selected="selected">${roomName[i.index] }</option>
                  </c:when>
                  <c:when test="${item == true}">
                    <option value="${i.index }" disabled="disabled">${roomName[i.index] }</option>
                  </c:when>
                </c:choose>
              </c:forEach>
            </select>
          </div>
          <div class="form-group">
            <label for="name">주소</label> <input type="text" name="addr"
              id="addr" class="form-control">
          </div>
          <div class="form-group">
            <label for="name">연락처</label> <input type="tel" name="tel"
              id="tel" class="form-control" value="<%=user.getTel()%>">
          </div>
          <div class="form-group">
            <label for="name">입금자명</label> <input type="text"
              name="in_name" id="in_name" class="form-control">
          </div>
          <div class="form-group">
            <label for="name">남기실말</label> <input type="text"
              name="comment" id="comment" class="form-control">
          </div>
          <div class="form-group" align="center">
            <button class="btn btn-success">예약하기</button>
            <button class="btn btn-default" onclick="history.back()">취소</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>