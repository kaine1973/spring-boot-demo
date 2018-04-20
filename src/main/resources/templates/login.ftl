<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="https://v3.bootcss.com/favicon.ico">
    <title>欢迎登陆</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/signin.css" rel="stylesheet">
  </head>
<script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
  <body>

    <div class="container">
      <form class="form-signin" action="/user/login" method="post">
        <h2 class="form-signin-heading">请登陆</h2>
        <label for="userName" class="sr-only">账户：</label>
        <input type="text" id="userName" name="userName" value="" class="form-control" placeholder="User Name" required="" autofocus="" autocomplete="off">
        <label for="userPwd" class="sr-only">密码：</label>
        <input type="password" id="userPwd" name="userPwd" value="" class="form-control" placeholder="Password" required="" autocomplete="off">
          <div><span style="font-size: 10px;color: red;">${msg}</span></div>
        <div class="checkbox">
          <label>
            <input type="checkbox"  name="remember" id="remember"> 记住我 &nbsp; &nbsp;
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit" onsubmit="return login()">登录</button>
	<a href="javascript:iforgot()" style="font-size:15px;float:left">忘记密码？</a>
	<a href="/register" style="font-size:15px;float:right">我要注册</a>
      </form>
    </div> <!-- /container -->

</body>
<script type="text/javascript">
	function iforgot(){
		var conf = confirm("忘了密码???");
	}
	function login(){
	    var userName = $('#uname').val();
	    var userPwd = $('#pwd').val();
	    if(isEmpty(userName)){
	        alert("用户名不能为空")
            return false;
        }
        if(isEmpty(userPwd)){
            alert("密码不能为空")
            return false;
        }
		return true;
	}
</script>
</html>