<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="row">
        <div class="col-md-9">
            <c:forEach items="${chatinfoList}" var="chatinfo" >
            <div class="row">
                <div style="padding: 8px" class="label label-${chatinfo.name eq currentUser ? "primary" : "danger" } pull-${chatinfo.name eq currentUser ? "right" : "left" }">
                    <a style="color: white" href="/user/${chatinfo.userId}">${chatinfo.name}</a>
                </div>
                <span class="pull-${chatinfo.name eq currentUser ? "right" : "left" }">&nbsp;&nbsp;</span>
                <div style="padding: 12px" class="alert alert-${chatinfo.name eq currentUser ? "info" : "warning" } pull-${chatinfo.name eq currentUser ? "right" : "left" }">${chatinfo.content}</div>
            </div>
            </c:forEach>
        </div>
        <div class="col-md-3">
            <div class="well" role="tabpanel">
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#post" aria-controls="signup" role="tab" data-toggle="tab">聊天</a></li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="post">
                        <br/>
                        <form action="/chat" method="post" class="${chatError}">
                            <div class="form-group">
                                <label>内容</label>
                                <textarea name="content" class="form-control" placeholder="内容" rows="6"></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">提交</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />