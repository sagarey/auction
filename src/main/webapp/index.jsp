<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="header.jsp" />
<div class="container">
    <div class="row">
        <div class="col-md-9" id="goods">
            <div class="row" id="goodsList">
                ${goodsinfoList.size() == 0 ? "<h3>没有符合条件的结果!</h3>" : ""}
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
                    <li role="presentation" class="active"><a href="#post" aria-controls="signup" role="tab" data-toggle="tab">搜索</a></li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="post">
                        <br/>
                            <div class="form-group">
                                <div class="input-group">
                                    <input required type="text" class="form-control" id="keyword" placeholder="商品标题">
                                      <span class="input-group-btn">
                                        <button class="btn btn-primary search" type="button">搜索</button>
                                      </span>
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
    $(document).ready(function(){
        $('a[href="#${tab}"]').tab('show');
        $('#goods').on('mouseenter', '.goods', function(){
            $(this).find('.content').fadeIn(200);
            $(this).find('.thumbnail').css("box-shadow","-2px 2px 12px #333");
        });
        $('#goods').on('mouseleave', '.goods', function(){
            $(this).find('.content').fadeOut(10);
            $(this).find('.thumbnail').css("box-shadow","0px 0px 0px #333");
        });
        $('.search').click(function(){
            keyword = $("#keyword").val();
                $('#goods').load('/?keyword=' + keyword + ' #goodsList', function() {
                    $('.thumbnail img').width("100%");
                    $('.thumbnail img').height($('.thumbnail img').width()/1.7);
                    re = new RegExp("(" + keyword + ")","ig");
                    $(".title").each(function(){
                        $(this).html($(this).html().replace(re, "<span style='color: #d9534f'>$1</span>"));
                    });
                });
        });
        $('.thumbnail img').width("100%");
        $('.thumbnail img').height($('.thumbnail img').width()/1.7);
        window.onresize = function(){
            $('.thumbnail img').height($('.thumbnail img').width()/1.7);
        }

        <c:if test="${currentUser != null}" >
        var close = "<button type='button' class='close' aria-label='Close' style='margin-top: -3px'><span aria-hidden='true' data-role='end'>&times;</span></button>";
        var tour = new Tour({
            steps: [
                {
                    element: "#goodsList",
                    title: "拍卖中的商品" + close,
                    content: "这里显示正在进行拍卖的商品，鼠标放置在商品上显示商品信息。",
                    placement: "right"
                },
                {
                    element: "#post",
                    title: "搜索" + close,
                    content: "键入关键字搜索商品标题。",
                    placement: "left"
                },
                {
                    element: "[href='/announcement']",
                    title: "公告" + close,
                    content: "点击这里查看站点公告。",
                    placement: "bottom"
                },
                {
                    element: "[href='/chat']",
                    title: "聊天室" + close,
                    content: "从这里进入聊天室。",
                    placement: "bottom"
                },
                {
                    element: ".user",
                    title: "用户" + close,
                    content: "点击弹出下拉选项，可进行商品发布、个人信息管理及登出操作。",
                    placement: "bottom"
                }
            ]});
        tour.init();
        tour.start();
        </c:if>
    });
</script>