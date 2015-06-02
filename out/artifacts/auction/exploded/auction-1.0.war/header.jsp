<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/bootstrap-tour.min.css" rel="stylesheet">
    <link rel="shortcut icon" href="/images/favicon.ico">
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <title>${title eq null ? "在线拍卖" : title}</title>
</head>
<body>
<nav class="navbar navbar-inverse navbar-static-top">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="/index">
                <img alt="auction" src="/images/logo.png">
            </a>
        </div>
        <c:if test="${currentUser != null}">
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <c:if test="${currentUser == 'admin'}">
                    <li><a href="/admin">管理</a></li>
                </c:if>
                <li><a href="/announcement">公告</a></li>
                <li><a href="/chat">聊天室</a></li>
                <li class="dropdown">
                    <a href="#" class="user dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">${currentUser} <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#postgoods" data-toggle="modal" data-target="#postgoods"><small class="glyphicon glyphicon-edit text-success" aria-hidden="true"></small> 发布商品</a></li>
                        <li class="divider"></li>
                        <li><a href="/profile"><small class="glyphicon glyphicon-user text-primary" aria-hidden="true"></small> 个人信息</a></li>
                        <li class="divider"></li>
                        <li><a href="/logout"><small class="glyphicon glyphicon-off text-danger" aria-hidden="true"></small> 注销用户</a></li>
                        <li><a href="#" class="hidden"></a></li>
                    </ul>
                </li>
            </ul>
        </div>
        </c:if>
    </div>
</nav>
<c:if test="${currentUser != null}">
<div class="modal fade" id="postgoods" tabindex="-1" role="dialog" aria-labelledby="postgoods" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="postgoodsLabel">发布商品</h4>
            </div>
            <form action="/goods" enctype="multipart/form-data" method="post" class="${goodsError}">
            <div class="modal-body">
                    <div class="form-group">
                        <label>标题</label>
                        <input required name="title" type="text" class="form-control" placeholder="标题">
                    </div>
                    <div class="form-group">
                        <label>简介</label>
                        <textarea required name="content" class="form-control" placeholder="简介" rows="6"></textarea>
                    </div>
                    <div class="form-group">
                        <label>价格</label>
                        <input required name="price" type="number" min="1" class="form-control" placeholder="价格">
                    </div>
                    <div class="form-group">
                        <label>过期时间</label>
                        <input required name="datetime" type="datetime-local" class="form-control" placeholder="过期时间">
                    </div>
                    <div class="form-group">
                        <label>图片</label>
                        <input required name="file" type="file" accept="image/*">
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="submit" class="btn btn-primary">发布</button>
            </div>
            </form>
        </div>
    </div>
</div>
</c:if>