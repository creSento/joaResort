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
<script type="text/javascript">
  function cancelChk(resv_date, room) {
	var cancel = confirm("예약을 취소하시겠습니까?");
	if (cancel) {
	  location.href='cancleResv.jsp?resv_date=' + resv_date + '&room=' + room + '&refund=0';
	} else {
	  return;
	}
  }
</script>
</head>
<body>
  <%@ include file="./menu.jsp"%>
  <%
  JoaService js = JoaServiceImpl.getInstance();
  List<JoaItem> myList = js.getMyList(loginID);
  session.setAttribute("myList", myList);
  session.setAttribute("roomName", JoaItem.ROOMNAME);
  session.setAttribute("processing", JoaItem.PROCESS);
  %>
  <div class="container-fluid">
    <!-- 예약내용 -->
    <div class="row" align="center">
      <div class="col-md-12" style="padding: 2em;" align="center">
        <table class="table table-condensed table-hover table-bordered" style="text-align: center;">
          <thead>
            <tr>
              <th width="15%" style="text-align: center;">예약일</th>
              <th width="25%" style="text-align: center;">방</th>
              <th colspan="2" style="text-align: center;">상태</th>
            </tr> 
          </thead>
          <tbody>
          <c:choose>
            <c:when test="${empty myList }">
              <tr>
                <td colspan="4">
                  예약 내역이 없습니다
                </td>
              </tr>
            </c:when>
            <c:otherwise>
              <c:forEach var="item" items="${myList }">
                <tr>
                  <td><strong>${item.resv_date }</strong></td>
                  <c:forEach var="roomName" items="${roomName }"
                    varStatus="r">
                    <c:if test="${item.room eq r.index}">
                      <td>${roomName }</td>
                    </c:if>
                  </c:forEach>
                  <c:forEach var="pro" items="${processing }"
                    varStatus="p">
                    <c:if test="${item.processing eq p.index}">
                      <c:if test="${item.processing == 0 }">
                        <td class="bg-info">${pro }</td>
                      </c:if>
                      <c:if test="${item.processing == 1 }">
                        <td class="bg-success">${pro }</td>
                      </c:if>
                      <c:if test="${item.processing == 2 }">
                        <td class="bg-danger">${pro }</td>
                      </c:if>
                      <c:if test="${item.processing == 3 }">
                        <td class="bg-warning">${pro }</td>
                      </c:if>
                      <c:if test="${item.processing == 4 }">
                        <td class="text-danger">${pro }</td>
                      </c:if>
                    </c:if>
                  </c:forEach>
                  <td>
                  <c:if test="${item.processing == 0 }">
                    <button class="btn btn-sm btn-default"
                      onclick="cancelChk('${item.resv_date }',${item.room})">취소</button>
                  </c:if>
                  <c:if test="${item.processing == 1 }">
                    <button class="btn btn-sm btn-default"
                      onclick="location.href='cancleResv.jsp?resv_date=${item.resv_date }&room=${item.room}&refund=1'">환불요청</button>
                  </c:if>
                  <c:if test="${item.processing == 2 }">
                    <button class="btn btn-sm btn-default">계좌입력</button>
                  </c:if>
                  <c:if test="${item.processing >= 3 }">
                    <button class="btn btn-sm btn-default" disabled="disabled">취소</button>
                  </c:if>
                  </td>
                </tr>
              </c:forEach>
            </c:otherwise>
          </c:choose>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</body>
</html>