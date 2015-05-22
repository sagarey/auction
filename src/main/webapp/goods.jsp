<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="header.jsp"/>
<div class="container">
    <div class="row">
        <div class="col-md-9">
            <div class="page-header">
                <h2>${goodsinfo.title}</h2>
                <h4 class="text-right"><small><a href="/user/${goodsinfo.userId}">${goodsinfo.name}</a></small></h4>
            </div>
            <div class="row" style="min-height: 320px">
                <div class="col-md-8">
                    <pre class="lead">${goodsinfo.content}</pre>
                </div>
                <div class="col-md-4">
                    <a href="#bigPic" class="thumbnail" data-toggle="modal" data-target="#bigPic">
                        <img src="/images/upload/${goodsinfo.pic}" alt="${goodsinfo.title}">
                    </a>
                    <div class="caption text-right">
                        <h4><small>${goodsinfo.deadline.toString().substring(5, 16)} 结束</small></h4>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-8">
                    <div class="page-header">
                        <h3>评论</h3>
                    </div>
                    <c:forEach items="${commentinfoByGoodsList}" var="commentinfo">
                    <blockquote>
                        <p>${commentinfo.content}</p>
                        <footer>${commentinfo.name}</footer>
                    </blockquote>
                    </c:forEach>
                </div>
                <c:if test="${currentUser != null}" >
                <div class="col-md-4">
                    <div class="page-header">
                        <h3>${currentUser}</h3>
                    </div>
                    <form action="/comment" method="post" class="form-inline ${commentError}">
                        <div class="form-group">
                            <input type="hidden" name="goodsId" value="${goodsinfo.id}"/>
                            <div class="input-group">
                                <input required type="text" name="content" class="form-control" placeholder="说点什么">
                                <span class="input-group-btn">
                                    <button class="btn btn-primary" type="submit">评论</button>
                                </span>
                            </div>
                        </div>
                    </form>
                    <br/>
                </div>
                </c:if>
            </div>
            <div class="modal fade" id="bigPic" tabindex="-1" role="dialog" aria-labelledby="bigPic" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="bigPicLabel">查看大图</h4>
                        </div>
                        <div class="modal-body" style="padding: 0">
                            <div class="thumbnail">
                                <img src="/images/upload/${goodsinfo.pic}" alt="${goodsinfo.title}">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <c:if test="${currentUser == null}" >
                <jsp:include page="login.jsp" />
            </c:if>
            <c:if test="${currentUser != null}" >
            <div class="well" role="tabpanel">
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#post" aria-controls="signup" role="tab" data-toggle="tab">拍卖</a></li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="goods">
                        <br/>
                        <ul class="list-group">
                            <li class="list-group-item">${goodsinfo.price} 元 <span class="badge pull-right">底价</span></li>
                            <c:forEach items="${bidinfoByGoodsList}" var="bidinfo">
                                <li class="list-group-item">${bidinfo.offer} 元 <span class="badge pull-right">${bidinfo.name}</span></li>
                            </c:forEach>
                        </ul>
                        <form action="/bid" method="post" class="form-inline ${bidError}">
                            <div class="form-group">
                                <input type="hidden" name="goodsId" value="${goodsinfo.id}"/>
                                <div class="input-group">
                                    <input required type="number" min="${goodsinfo.price}" name="offer" class="form-control" placeholder="RMB">
                                      <span class="input-group-btn">
                                        <button class="btn btn-primary" type="submit">出价</button>
                                      </span>
                                </div>
                            </div>
                        </form>
                        <br/>
                        <button id="complainBtn" class="btn btn-danger btn-block" type="submit">投诉商品</button>
                        <form class="complain ${complainError}" action="/complain" method="post">
                            <input name="type" type="hidden" value="goods"/>
                            <input name="complainId" type="hidden" value="${goodsinfo.id}"/>
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
                                    <a class="hidden" id="${goodsinfo.id}"></a>
                                    <c:if test="${goodsinfo.status == 'check'}" >
                                        <button id="check" class="btn btn-warning btn-block" type="submit">通过审核</button>
                                    </c:if>
                                    <c:if test="${goodsinfo.status == 'normal'}" >
                                        <button id="freeze" class="btn btn-danger btn-block" type="submit">冻结商品</button>
                                    </c:if>
                                    <c:if test="${goodsinfo.status == 'frozen'}" >
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
<jsp:include page="footer.jsp"/>
<script>
    $('.complain').hide();
    $('#complainBtn').click(function(){
        $('#complainBtn').fadeOut(150, function(){
            $('.complain').fadeIn(150);
        });
    });
    $('#complainCancelBtn').click(function(){
        $('.complain').fadeOut(150, function(){
            $('#complainBtn').fadeIn(150);
        });
    });
    $('#goods').on('click', '#check', function(){
        id = $(this).prev('a').attr('id');
        $.ajax({
            type: "POST",
            url: "/goods/update",
            data: {id: id, status: "normal"},
            success:function(){
                $('#admin').load('/goods/' + id + ' #adminControl');
            }
        });
    });
    $('#goods').on('click', '#freeze', function(){
        id = $(this).prev('a').attr('id');
        $.ajax({
            type: "POST",
            url: "/goods/update",
            data: {id: id, status: "frozen"},
            success:function(){
                $('#admin').load('/goods/' + id + ' #adminControl');
            }
        });
    });
    $('#goods').on('click', '#unfreeze', function(){
        id = $(this).prev('a').attr('id');
        $.ajax({
            type: "POST",
            url: "/goods/update",
            data: {id: id, status: "normal"},
            success:function(){
                $('#admin').load('/goods/' + id + ' #adminControl');
            }
        });
    });
</script>
<style>
    pre {
        background-color: #fff;
        border: 0;
    }
    .thumbnail {
        padding: 0;
        border-radius: 0;
    }
</style>