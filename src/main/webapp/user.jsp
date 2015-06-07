<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="header.jsp" />
<div class="container" id="contain">
  <div class="row" id="container">
    <div class="col-md-9">
      <div class="row">
          <jsp:include page="goodshow.jsp"/>
      </div>
    </div>
    <div class="col-md-3">
    <c:if test="${currentUser == null}" >
      <jsp:include page="login.jsp" />
    </c:if>
    <c:if test="${currentUser != null}" >
      <div class="well" role="tabpanel">
        <ul class="nav nav-tabs" role="tablist">
          <li role="presentation" class="active"><a href="#post" aria-controls="signup" role="tab" data-toggle="tab">用户信息</a></li>
        </ul>
        <div class="tab-content">
          <div role="tabpanel" class="tab-pane active" id="user">
            <br/>
            <ul class="list-group">
              <li class="list-group-item">${user.name} <span class="badge pull-right">用户</span></li>
              <li class="list-group-item">${user.email} <span class="badge pull-right">邮箱</span></li>
            </ul>
            <button id="complainBtn" class="btn btn-danger btn-block" type="submit">投诉用户</button>
            <form class="complain" action="/complain" method="post">
              <input name="type" type="hidden" value="user"/>
              <input name="complainId" type="hidden" value="${user.id}"/>
              <div class="input-group">
              <span class="input-group-btn">
                <button id="complainCancelBtn" class="btn btn-default" type="button">取消</button>
              </span>
                <input required name="content" type="text" class="form-control" placeholder="投诉理由">
              <span class="input-group-btn">
                <button class="btn btn-primary" type="submit">确定</button>
              </span>
              </div>
            </form>
            <div id="admin">
              <div id="adminControl">
                <c:if test="${currentUser == 'admin'}" >
                  <br/>
                  <a class="hidden" id="${user.id}"></a>
                  <c:if test="${user.status == 'normal'}" >
                    <button id="freeze" class="btn btn-danger btn-block" type="submit">冻结用户</button>
                  </c:if>
                  <c:if test="${user.status == 'frozen'}" >
                    <button id="unfreeze" class="btn btn-success btn-block" type="submit">解除冻结</button>
                  </c:if>
                </c:if>
              </div>
            </div>
          </div>
        </div>
      </div>
      </c:if>
    </div>
  </div>
</div>
<jsp:include page="footer.jsp" />
<script>
  $('.content').hide();
  $('.complain').hide();
  $('#contain').on('mouseenter', '.goods', function(){
    $(this).find('.content').fadeIn(200);
    $(this).find('.thumbnail').css("box-shadow","-2px 2px 12px #333");
  });
  $('#contain').on('mouseleave', '.goods', function(){
      $(this).find('.content').fadeOut(10);
      $(this).find('.thumbnail').css("box-shadow","0px 0px 0px #333");
  });
  $('#contain').on('click', '#complainBtn', function(){
    $('#complainBtn').fadeOut(150, function(){
      $('.complain').fadeIn(150);
    });
  });
  $('#contain').on('click', '#complainCancelBtn', function(){
    $('.complain').fadeOut(150, function(){
      $('#complainBtn').fadeIn(150);
    });
  });
  $('#contain').on('click', '#freeze', function(){
    id = $(this).prev('a').attr('id');
    $.ajax({
      type: "POST",
      url: "/update",
      data: {id: id, status: "frozen"},
      success:function(){
        $('#contain').load('/user/' + id + ' #container', function() {
          $('.content').hide();
          $('.complain').hide();
          $('.normal img').width("100%");
          $('.normal img').height($('.normal img').width()/1.7);
        });
      }
    });
  });
  $('#contain').on('click', '#unfreeze', function(){
    id = $(this).prev('a').attr('id');
    $.ajax({
      type: "POST",
      url: "/update",
      data: {id: id, status: "normal"},
      success:function(){
        $('#contain').load('/user/' + id + ' #container', function(){
          $('.content').hide();
          $('.complain').hide();
          $('.normal img').width("100%");
          $('.normal img').height($('.normal img').width()/1.7);
        });
      }
    });
  });
  $('.normal img').width("100%");
  $('.normal img').height($('.normal img').width()/1.7);
  window.onresize = function(){
    $('.normal img').height($('.normal img').width()/1.7);
  }
</script>