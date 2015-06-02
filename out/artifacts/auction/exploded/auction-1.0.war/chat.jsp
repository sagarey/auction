<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="row">
        <div class="col-md-9">
            <div class="row">
                <div class="col-md-12">
                    <h5 class="text-center" style="margin-bottom: 5px">
                        <small><button id="more" name="${page + 1}" class="btn-link">历史信息</button></small></h5>
                    <hr style="margin-top: 0px"/>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12" id="message">
                    <jsp:include page="message.jsp"/>
                </div>
            </div>
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
<script>
    $("#more").click(function(){
        page = $(this).attr("name");
        $.ajax({
            url:"/chat/message",
            async:false,
            data: { page: page },
            success: function(data){
                $("#more").attr("name", Number(page) + 1);
                $("#message").prepend(data);
            }
        });
    });
</script>