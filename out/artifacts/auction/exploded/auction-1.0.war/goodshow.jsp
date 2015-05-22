<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach items="${goodsinfoList}" var="goodsinfo" >
<div class="col-md-4 goods">
  <div class="thumbnail">
    <a href="/goods/${goodsinfo.id}">
      <img src="/images/upload/${goodsinfo.pic}" alt="${goodsinfo.title}">
    </a>
    <div class="caption">
      <h4><a class="title" href="/goods/${goodsinfo.id}">${goodsinfo.title}</a><a href="/user/${goodsinfo.userId}" class="pull-right"><small>${goodsinfo.name}</small></a></h4>
    </div>
    <a href="/goods/${goodsinfo.id}" class="btn btn-primary btn-block" role="button">${goodsinfo.price} 元起拍</a>
  </div>
  <div class="panel panel-primary content">
    <div class="panel-heading">
      <h3 class="panel-title">${goodsinfo.title}</h3>
    </div>
    <div class="panel-body">
      <pre>${goodsinfo.content}</pre>
    </div>
    <div class="panel-footer text-right">${goodsinfo.deadline.toString().substring(5, 16)} 拍卖结束</div>
  </div>
</div>
</c:forEach>
<style>
  .caption {
    padding: 0px !important;
  }
  .content {
    position: absolute;
    background-color: #fff;
    top: 0px;
    left: 100%;
    z-index: 100;
    width: 100%;
    box-shadow: -2px 2px 12px #333;
  }
  .content blockquote {
    margin: 0;
  }
  .content pre {
    background-color: #fff;
    border: 0;
  }
  .content .panel-body {
    padding: 0;
  }
</style>