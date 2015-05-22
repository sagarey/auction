<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="well" role="tabpanel">
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="#login" aria-controls="login" role="tab" data-toggle="tab">登录</a></li>
    <li role="presentation"><a href="#signup" aria-controls="signup" role="tab" data-toggle="tab">注册</a></li>
  </ul>
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="login">
      <br/>
      <form action="/login" method="post" class="${loginError}">
        <div class="form-group">
          <label>用户</label>
          <input name="name" type="text" class="form-control" placeholder="用户">
        </div>
        <div class="form-group">
          <label>密码</label>
          <input name="password" type="password" class="form-control" placeholder="密码">
        </div>
        <button type="submit" class="btn btn-primary">登录</button>
      </form>
    </div>
    <div role="tabpanel" class="tab-pane" id="signup">
      <br/>
      <form action="/signup" method="post" class="${signupError}">
        <div class="form-group">
          <label>用户</label>
          <input name="name" type="text" class="form-control" placeholder="用户">
        </div>
        <div class="form-group">
          <label>邮箱</label>
          <input name="email" type="email" class="form-control" placeholder="邮箱">
        </div>
        <div class="form-group">
          <label>密码</label>
          <input name="password" type="password" class="form-control" placeholder="密码">
        </div>
        <div class="form-group">
          <label>密码确认</label>
          <input name="repassword" type="password" class="form-control" placeholder="密码确认">
        </div>
        <button type="submit" class="btn btn-primary">注册</button>
      </form>
    </div>
  </div>
</div>