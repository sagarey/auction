<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach items="${chatinfoList}" var="chatinfo" >
  <div class="row">
    <div style="padding: 8px" class="label label-${chatinfo.name eq currentUser ? "primary" : "danger" } pull-${chatinfo.name eq currentUser ? "right" : "left" }">
      <a style="color: white" href="/user/${chatinfo.userId}">${chatinfo.name}</a>
    </div>
  </div>
  <div class="row">
    <div style="padding: 12px; margin-top: 12px" class="alert alert-${chatinfo.name eq currentUser ? "info" : "warning" } pull-${chatinfo.name eq currentUser ? "right" : "left" }">${chatinfo.content}</div>
  </div>
  <small style="margin-top: -20px; color: lightgray" class="pull-${chatinfo.name eq currentUser ? "left" : "right" }"> ${chatinfo.createdAt.toString().substring(5, 19)}</small>
  <hr style="margin-top: -3px;"/>
</c:forEach>