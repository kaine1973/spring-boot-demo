<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<title>欢迎你</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/signin.css" rel="stylesheet">
</head>
<script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<body>
<div class="container" >
      <form class="form-signin" action="/user/regist" method="post">
        <h2 class="form-signin-heading">请注册</h2>
        <label for="userName" class="sr-only">用户名：</label>
        <input type="text" name="userName" id="userName" value="" class="form-control"  placeholder="User Name" required="" autofocus="" >
        <label for="userPwd" class="sr-only">密 &nbsp;码：</label>
        <input type="password" name="userPwd" id="userPwd" class="form-control" placeholder="Password" required="" >
          <div><span style="font-size: 10px;color: red;">${msg}</span></div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">注册</button>
	<a href="/login" style="font-size:13px;float:right">我要登录</a>
      </form>
    </div> 
</body>
<script type="text/javascript">

</script>
</html>