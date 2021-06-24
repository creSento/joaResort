<%@page import="com.reservation.domain.JoaCalendar"%>
<%@page import="com.reservation.domain.JoaItem"%>
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
  <%@ include file="./menu.jsp"%>
  <div class="container">
    <div class="row">
      <div class="col-md-9">
        <%
        String resv_date = request.getParameter("resv_date");
        int room = Integer.parseInt(request.getParameter("room"));
        int refund = Integer.parseInt(request.getParameter("refund"));
        JoaService js = JoaServiceImpl.getInstance();
        JoaItem resv = js.getDaily(LocalDate.parse(resv_date), room);
        int result = 0;
        if (refund == 1) {
          result = js.refundReservation(resv);
        } else {
          result = js.cancleReservation(resv);
        }
        session.setAttribute("refund", refund);
        if (result > 0) {
        %>
        <form>
          <div class="form-group" align="center">
          <c:if test="${refund == 0 }">
            <h3 class="text-success">예약이 취소되었습니다.</h3>
          </c:if>
          <c:if test="${refund == 1 }">
            <h3 class="text-success">환불요청이 접수되었습니다.</h3>
          </c:if>
            이용해주셔서 감사합니다:)
          </div>
          <div class="form-group">
            <label for="name">이름</label> <input type="text" name="name"
              id="name" class="form-control"
              value="<%=resv.getName() %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="resv_date">예약일</label> <input type="text"
              name="resv_date" id="resv_date" class="form-control"
              value="<%=resv.getResv_date() %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="room">방</label> <input type="text" name="room"
              id="room" class="form-control"
              value="<%=JoaItem.ROOMNAME[resv.getRoom()] %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="addr">주소</label> <input type="text" name="addr"
              id="addr" class="form-control"
              value="<%=resv.getAddr() %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="tel">연락처</label> <input type="tel" name="tel"
              id="tel" class="form-control"
              value="<%=resv.getTel() %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="in_name">입금자명</label> <input type="text"
              name="in_name" id="in_name" class="form-control"
              value="<%=resv.getIn_name() %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="comment">남기실말</label> <input type="text"
              name="comment" id="comment" class="form-control"
              value="<%=resv.getComment() %>" readonly="readonly">
          </div>
        </form>
        <%
        } else {
        %>
        <div class="text-danger" align="center">
          <h3>오류가 발생했습니다.</h3>
        </div>
        <%
        }
        %>
      </div>
    </div>
  </div>
</body>
</html>