<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>
<div class="container" id="contain">
  <div class="row" id="container">
    <div class="col-md-9">
      <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="goods">
          <div class="page-header">
            <h2>我的商品</h2>
          </div>
          <table class="table table-striped table-hover">
            <tr><th>#</th><th>标题</th><th>底价</th><th>状态</th><th>结束日期</th><th>创建日期</th><th></th></tr>
            <c:forEach items="${goodsinfoList}" var="goodsinfo" varStatus="status">
              <tr>
                <td>${status.count}</td><td><a href="/goods/${goodsinfo.id}">${goodsinfo.title}</a></td>
                <td>${goodsinfo.price} 元</td>
                <td>${now > goodsinfo.deadline ? "已结束" : (goodsinfo.status == "check" ? "待审核" : (goodsinfo.status == "normal" ? "竞拍中" : (goodsinfo.status == "frozen" ? "被冻结" : ""))) }</td>
                <td>${goodsinfo.deadline.toString().substring(5, 16)}</td>
                <td>${goodsinfo.createdAt.toString().substring(5, 16)}</td>
                <td><a id="${goodsinfo.id}" class="hidden"></a><button type="button" class="close deleteGoods" aria-label="Close"><span aria-hidden="true">&times;</span></button></td>
              </tr>
            </c:forEach>
          </table>
        </div>
        <div role="tabpanel" class="tab-pane" id="comment">
          <div class="page-header">
            <h2>我的评论</h2>
          </div>
          <table class="table table-striped table-hover">
            <tr><th>#</th><th>商品</th><th>评论</th><th>评论日期</th></tr>
            <c:forEach items="${commentinfoList}" var="commentinfo" varStatus="status">
              <tr>
                <td>${status.count}</td><td><a href="/goods/${commentinfo.goodsId}">${commentinfo.title}</a></td>
                <td>${commentinfo.content}</td>
                <td>${commentinfo.createdAt.toString().substring(5, 16)}</td>
              </tr>
            </c:forEach>
          </table>
        </div>
        <div role="tabpanel" class="tab-pane" id="complain">
          <div class="page-header">
            <h2>我的投诉</h2>
          </div>
          <table class="table table-striped table-hover">
            <tr><th>#</th><th>投诉对象</th><th>理由</th><th>投诉时间</th></tr>
            <c:forEach items="${complaininfoList}" var="complaininfo" varStatus="status">
              <tr>
                <td>${status.count}</td><td><a href="/${complaininfo.type}/${complaininfo.complainId}">${complaininfo.type == 'goods' ? '商品' : '用户'}ID ${complaininfo.complainId}</a>
                </td><td>${complaininfo.content}</td>
                <td>${complaininfo.createdAt.toString().substring(5, 16)}</td>
              </tr>
            </c:forEach>
          </table>
        </div>
        <div role="tabpanel" class="tab-pane" id="shop">
          <div class="page-header">
            <h2>我的竞拍</h2>
          </div>
          <table class="table table-striped table-hover">
            <tr><th>#</th><th>标题</th><th>底价</th><th>我的出价</th><th>状态</th><th>结束日期</th></tr>
            <c:forEach items="${bidinfoList}" var="bidinfo" varStatus="status">
              <tr>
                <td>${status.count}</td><td><a href="/goods/${bidinfo.goodsId}">${bidinfo.title}</a></td>
                <td>${bidinfo.price} 元</td>
                <td>${bidinfo.offer} 元</td>
                <td>${now > bidinfo.deadline ? "已结束" : (bidinfo.status == "check" ? "待审核" : (bidinfo.status == "normal" ? "竞拍中" : (bidinfo.status == "frozen" ? "被冻结" : ""))) }</td>
                <td>${bidinfo.deadline.toString().substring(5, 16)}</td>
              </tr>
            </c:forEach>
          </table>
        </div>
        <div role="tabpanel" class="tab-pane" id="profile">
          <div class="page-header">
            <h2>修改资料</h2>
          </div>
          <form action="/profile" method="post">
            <div class="form-group">
              <label>用户</label>
              <input readonly name="name" type="text" class="form-control" placeholder="用户" value="${user.name}">
            </div>
            <div class="form-group">
              <label>邮箱</label>
              <input readonly name="email" type="email" class="form-control" placeholder="邮箱" value="${user.email}">
            </div>
            <div class="form-group ${profileError}">
              <label>密码</label>
              <input required name="password" type="password" class="form-control" placeholder="密码">
            </div>
            <div class="form-group ${profileError}">
              <label>密码确认</label>
              <input required name="repassword" type="password" class="form-control" placeholder="密码确认">
            </div>
            <button type="submit" class="btn btn-primary">确认修改</button>
          </form>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <ul class="nav nav-pills nav-stacked" role="tablist">
        <li role="presentation" class="active"><a href="#goods" aria-controls="goods" role="tab" data-toggle="tab">我的商品</a></li>
        <li role="presentation"><a href="#shop" aria-controls="shop" role="tab" data-toggle="tab">我的竞拍</a></li>
        <li role="presentation"><a href="#comment" aria-controls="comment" role="tab" data-toggle="tab">我的评论</a></li>
        <li role="presentation"><a href="#complain" aria-controls="complain" role="tab" data-toggle="tab">我的投诉</a></li>
        <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">修改资料</a></li>
      </ul>
    </div>
  </div>
</div>
<jsp:include page="footer.jsp" />
<script>
  $('a[href="#${tab}"]').tab('show');
  $('#contain').on('click', '.deleteGoods', function(){
    id =  $(this).prev('a').attr('id');
    $.ajax({
      type: "POST",
      url: "/goods/delete",
      data: {id: id},
      success:function(){
        $('#contain').load('/profile #container');
      }
    });
  });
</script>