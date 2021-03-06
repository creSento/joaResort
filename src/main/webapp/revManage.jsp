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
        request.setCharacterEncoding("utf-8");
        String name = request.getParameter("name");
        String resv_date = request.getParameter("resv_date");
        int room = Integer.parseInt(request.getParameter("room"));
        String addr = request.getParameter("addr");
        String tel = request.getParameter("tel");
        String in_name = request.getParameter("in_name");
        String comment = request.getParameter("comment");
        String processing = request.getParameter("processing");
        JoaService js = JoaServiceImpl.getInstance();
        JoaItem newResv = 
                new JoaItem(name, resv_date, room, addr, tel, in_name, comment, Integer.parseInt(processing));
        int result = js.updateReservation(newResv);
        if (result > 0) {
            
        %>
        <form>
          <div class="form-group" align="center">
            <h3 class="text-success">수정 완료</h3>
          </div>
          <div class="form-group">
            <label for="name">이름</label> <input type="text" name="name"
              id="name" class="form-control"
              value="<%=newResv.getName() %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="resv_date">예약일</label> <input type="text"
              name="resv_date" id="resv_date" class="form-control"
              value="<%=newResv.getResv_date() %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="room">방</label> <input type="text" name="room"
              id="room" class="form-control"
              value="<%=JoaItem.ROOMNAME[newResv.getRoom()] %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="addr">주소</label> <input type="text" name="addr"
              id="addr" class="form-control"
              value="<%=newResv.getAddr() %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="tel">연락처</label> <input type="tel" name="tel"
              id="tel" class="form-control"
              value="<%=newResv.getTel() %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="in_name">입금자명</label> <input type="text"
              name="in_name" id="in_name" class="form-control"
              value="<%=newResv.getIn_name() %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="comment">남기실말</label> <input type="text"
              name="comment" id="comment" class="form-control"
              value="<%=newResv.getComment() %>" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="proccesing">상태</label> <input type="text"
              name="proccesing" id="proccesing" class="form-control"
              value="<%=JoaItem.PROCESS[newResv.getProcessing()] %>" readonly="readonly">
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