<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>
<div class="container">
  <div class="row">
    <div class="col-md-9">
      <div class="page-header">
        <h2>公告</h2>
      </div>
        <div id="announcement">
          <div class="panel-group" id="announcementList" role="tablist" aria-multiselectable="true">
            <c:forEach items="${announcementList}" var="announcement" varStatus="status">
            <div class="panel panel-default">
              <div class="panel-heading" role="tab">
                <h4 class="panel-title">
                  <a data-toggle="collapse" id="${announcement.id}" data-parent="#announcementList" href="#c${announcement.id}" aria-expanded="true" aria-controls="c${announcement.id}">
                      ${announcement.title}
                  </a>
                  <span class="badge">${announcement.createdAt.toString().substring(5, 10)}</span>
                  <c:if test='${currentUser == "admin"}'>
                    <button type="button" class="close deleteAnnouncement"><span aria-hidden="true">&times;</span></button>
                  </c:if>
                </h4>
              </div>
              <div id="c${announcement.id}" class='panel-collapse collapse ${status.index == 0 ? "in" : "" }' role="tabpanel" aria-labelledby="${announcement.id}">
                <div class="panel-body">
                    ${announcement.content}
                </div>
              </div>
            </div>
            </c:forEach>
          </div>
        </div>
    </div>
    <div class="col-md-3">
    <c:if test='${currentUser == "admin"}'>
      <div class="well" role="tabpanel">
        <ul class="nav nav-tabs" role="tablist">
          <li role="presentation" class="active"><a href="#post" aria-controls="signup" role="tab" data-toggle="tab">公告</a></li>
        </ul>
        <div class="tab-content">
          <div role="tabpanel" class="tab-pane active" id="post">
            <br/>
            <form action="/announcement" method="post" class="${announcementError}">
              <div class="form-group">
                <label>标题</label>
                <input required type="text" name="title" class="form-control" placeholder="标题" />
              </div>
              <div class="form-group">
                <label>内容</label>
                <textarea required name="content" class="form-control" placeholder="内容" rows="5"></textarea>
              </div>
              <button type="submit" class="btn btn-primary">提交</button>
            </form>
          </div>
        </div>
      </div>
    </c:if>
    </div>
  </div>
</div>
<jsp:include page="footer.jsp" />
<script>
    $('#announcement').on('click', '.deleteAnnouncement', function(){
        $.ajax({
            type: "POST",
            url: "/announcement/delete",
            data: {id: $(this).prev('a').attr('id')},
            success:function(){
                $('#announcement').load('/announcement #announcementList');
            }
        });
    });
</script>