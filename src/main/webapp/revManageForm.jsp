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
  <%
  String resv_date = request.getParameter("resv_date");
  String room = request.getParameter("room");
  JoaService js = JoaServiceImpl.getInstance();
  LocalDate resvMonth = LocalDate.parse(resv_date);
  JoaCalendar cal = js.getCalendar(resvMonth.getYear(), resvMonth.getMonthValue());
  boolean[] dailyBooked = js.dailyBooked(cal, resv_date);
  JoaItem resvItem = js.getDaily(LocalDate.parse(resv_date), Integer.parseInt(room));
  session.setAttribute("cal", cal);
  session.setAttribute("dailyBooked", dailyBooked);
  session.setAttribute("resvItem", resvItem);
  session.setAttribute("roomName", JoaItem.ROOMNAME);
  session.setAttribute("processing", JoaItem.PROCESS);
  %>
  <%@ include file="./menu.jsp"%>
  <div class="container">
    <div class="row">
      <div class="col-md-9">
        <form action="./revManage.jsp" method="post">
          <div class="form-group">
            <label for="id">ID</label> <input type="text" name="id"
              id="id" class="form-control" value="<%=resvItem.getId()%>">
          </div>
          <div class="form-group">
            <label for="name">이름</label> <input type="text" name="name"
              id="name" class="form-control" value="<%=resvItem.getName()%>">
          </div>
          <div class="form-group">
            <label for="resv_date">예약일</label> <input type="text" name="resv_date"
              id="resv_date" class="form-control" value="<%=resvItem.getResv_date()%>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="room">방</label> <input type="text" name="room"
              id="room" class="form-control" value="<%=JoaItem.ROOMNAME[resvItem.getRoom()]%>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="addr">주소</label> <input type="text" name="addr"
              id="addr" class="form-control" value="<%=resvItem.getAddr()%>">
          </div>
          <div class="form-group">
            <label for="tel">연락처</label> <input type="tel" name="tel"
              id="tel" class="form-control" value="<%=resvItem.getTel()%>">
          </div>
          <div class="form-group">
            <label for="in_name">입금자명</label> <input type="text"
              name="in_name" id="in_name" class="form-control" value="<%=resvItem.getIn_name()%>">
          </div>
          <div class="form-group">
            <label for="comment">남기실말</label> <input type="text"
              name="comment" id="comment" class="form-control" value="<%=resvItem.getComment()%>">
          </div>
          <div class="form-group">
            <label for="processing">상태</label>
            <select class="form-control" name="processing">
              <c:forEach var="i" begin="0" end="4" varStatus="p">
                <c:choose>
                  <c:when test="${resvItem.processing eq p.index }">
                    <option value="${i }" selected="selected">${processing[p.index] }</option>
                  </c:when>
                  <c:otherwise>
                    <option value="${i }">${processing[p.index] }</option>
                  </c:otherwise>
                </c:choose>
              </c:forEach>
            </select>
          </div>
          <div class="form-group" align="center">
            <button class="btn btn-success">수정</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>