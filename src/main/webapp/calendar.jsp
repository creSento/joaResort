<%@page import="com.reservation.domain.JoaCalendar"%>
<%@page import="com.reservation.domain.JoaItem"%>
<%@page import="java.util.List"%>
<%@page import="com.reservation.service.JoaServiceImpl"%>
<%@page import="com.reservation.service.JoaService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
  <%
  String year = request.getParameter("year");
  String month = request.getParameter("month");
  JoaService js = JoaServiceImpl.getInstance();
  JoaCalendar cal = js.getCalendar(year, month);
  int roomSize = js.totalRoom();
  session.setAttribute("cal", cal);
  session.setAttribute("roomName", JoaItem.ROOMNAME);
  %>
  <div class="container-fluid">
    <!-- 월 선택 -->
    <div class="row" align="center">
      <div class="col-md-12" style="padding: 2em;">
        <div class="btn-group btn-group-sm">
          <c:forEach var="i" begin="1" end="12">
            <c:choose>
              <c:when test="${i == cal.month}">
                <button
                  onclick="location.href='./calendar.jsp?year=${cal.year}&month=${i }'"
                  class="btn btn-success btn-sm">${i }월</button>
              </c:when>
              <c:otherwise>
                <button
                  onclick="location.href='./calendar.jsp?year=${cal.year}&month=${i }'"
                  class="btn btn-default btn-sm">${i }월</button>
              </c:otherwise>
            </c:choose>
          </c:forEach>
        </div>
      </div>
    </div>
    <!-- 예약내용 -->
    <div class="row">
      <div class="col-md-12" style="padding: 2em;">
        <table class="table table-condensed table-hover table-bordered" style="text-align: center;">
          <thead>
            <tr>
              <th width="15%" style="text-align: center;">예약일</th>
              <th width="10%" style="text-align: center;">요일</th>
              <c:forEach var="name" items="${roomName }">
                <th width="25%" style="text-align: center;">${name }</th>
              </c:forEach>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="i" begin="0" end="${cal.endOfMonth - 1}" varStatus="dow">
              <tr>
                <td><strong>${cal.dateString[dow.index]}</strong></td>
                <td>${cal.dayOfweek[dow.index] }</td>
                <c:set var="dailyDate" value="${cal.dateString[dow.index] }"/>
                <%
                String dailyDate = pageContext.getAttribute("dailyDate").toString();
                for (int i = 0; i < roomSize; i++) {
                    JoaItem daily = js.getDaily(LocalDate.parse(dailyDate), i);
                    session.setAttribute("daily", daily);
                    session.setAttribute("roomNumber", i);
                %>
                    <c:choose>
                          <c:when test="${cal.dateString[dow.index] eq daily.resv_date && daily.room == roomNumber && daily.processing < 3}">
                            <td>
                              ${daily.name }
                            </td>
                            </c:when>
                          <c:when test="${(cal.dateString[dow.index] eq daily.resv_date && daily.room == -1) || daily.processing >= 3}">
                              <td class="info text-info">
                              <c:if test="${empty login_ok || login_ok != 'login'}">
                                  예약가능
                              </c:if>
                              <c:if test="${login_ok eq 'login'}">
                                <a href="./revForm.jsp?resv_date=${cal.dateString[dow.index] }&room=${roomNumber}">
                                  예약가능
                                </a>
                              </c:if>
                              </td>
                          </c:when>
                    </c:choose>
                <% } %>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</body>
</html>