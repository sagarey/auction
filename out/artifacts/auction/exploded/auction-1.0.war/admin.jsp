<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>
<div class="container">
  <div class="row">
    <div class="col-md-9">
      <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="complain">
          <div id="complainList">
            <div class="page-header">
              <h2>投诉单</h2>
            </div>
            <table class="table table-striped table-hover">
              <tr><th>#</th><th>用户</th><th>投诉对象</th><th>理由</th><th>投诉时间</th><th></th></tr>
              <c:forEach items="${complaininfoList}" var="complaininfo" varStatus="status">
                <tr>
                  <td>${status.count}</td><td><a href="/user/${complaininfo.userId}">${complaininfo.name}</a></td>
                  <td><a href="/${complaininfo.type}/${complaininfo.complainId}">${complaininfo.type == 'goods' ? '商品' : '用户'}ID ${complaininfo.complainId}</a></td><td>${complaininfo.content}</td>
                  <td>${complaininfo.createdAt.toString().substring(5, 16)}</td>
                  <td><a id="${complaininfo.id}" class="hidden"></a><button type="button" class="close deleteComplain" aria-label="Close"><span aria-hidden="true">&times;</span></button></td>
                </tr>
              </c:forEach>
            </table>
          </div>
        </div>
        <div role="tabpanel" class="tab-pane" id="check">
          <div class="page-header">
            <h2>待审核</h2>
          </div>
          <table class="table table-striped table-hover">
            <tr><th>#</th><th>商品标题</th><th>卖家</th><th>创建时间</th><th>结束时间</th></tr>
            <c:forEach items="${goodsinfoList}" var="goodsinfo" varStatus="status">
              <tr><td>${status.count}</td><td><a href="/goods/${goodsinfo.id}">${goodsinfo.title}</a></td><td><a href="/user/${goodsinfo.userId}">${goodsinfo.name}</a></td>
              <td>${goodsinfo.createdAt.toString().substring(5, 16)}</td><td>${goodsinfo.deadline.toString().substring(5, 16)}</td></tr>
            </c:forEach>
          </table>
        </div>
        <div role="tabpanel" class="tab-pane" id="frozen">
          <div id="frozenList">
            <div class="page-header">
              <h2>冻结中</h2>
            </div>
            <table class="table table-striped table-hover">
              <tr><th>#</th><th>冻结对象</th><th>冻结时间</th></tr>
              <c:forEach items="${frozenUserList}" var="user" varStatus="status">
                <tr>
                  <td>${status.count}</td><td><a href="/user/${user.id}">用户ID ${user.id}</a></td>
                  <td>${user.createdAt.toString().substring(5, 16)}</td>
                </tr>
              </c:forEach>
              <c:forEach items="${frozenGoodsinfoList}" var="goodsinfo" varStatus="status">
                <tr>
                  <td>${status.count + frozenUserList.size()}</td><td><a href="/goods/${goodsinfo.id}">商品ID ${goodsinfo.id}</a></td>
                  <td>${goodsinfo.createdAt.toString().substring(5, 16)}</td>
                </tr>
              </c:forEach>
            </table>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <ul class="nav nav-pills nav-stacked" role="tablist">
        <li role="presentation" class="active"><a href="#complain" aria-controls="complain" role="tab" data-toggle="tab">投诉单</a></li>
        <li role="presentation"><a href="#check" aria-controls="check" role="tab" data-toggle="tab">待审核</a></li>
        <li role="presentation"><a href="#frozen" aria-controls="frozen" role="tab" data-toggle="tab">冻结中</a></li>
      </ul>
    </div>
  </div>
</div>
<jsp:include page="footer.jsp" />
<script>
  $('#complain').on('click', '.deleteComplain', function(){
    $.ajax({
      type: "POST",
      url: "/complain/delete",
      data: {id: $(this).prev('a').attr('id')},
      success:function(){
        $('#complain').load('/admin #complainList');
      }
    });
  });
  var close = "<button type='button' class='close' aria-label='Close' style='margin-top: -3px'><span aria-hidden='true' data-role='end'>&times;</span></button>";
  var tour = new Tour({
    steps: [
      {
        element: "[href='/announcement']",
        title: "公告" + close,
        content: "与普通用户不同，管理员允许管理站点公告。",
        placement: "bottom"
      }
    ]});
  tour.init();
  tour.start();
</script>