
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" href="https://v3.bootcss.com/favicon.ico">

    <script type="text/javascript" src="../../../../../../../IdeaProjects/web-project/crm-web/src/main/webapp/js/jquery-3.2.1.min.js"></script>
    <link rel="stylesheet" href="../../../../../../../IdeaProjects/web-project/crm-web/src/main/webapp/bs/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="../../../../../../../IdeaProjects/web-project/crm-web/src/main/webapp/bs/css/bootstrap-theme.css" crossorigin="anonymous">
    <script src="../../../../../../../IdeaProjects/web-project/crm-web/src/main/webapp/bs/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="../../../../../../../IdeaProjects/web-project/crm-web/src/main/webapp/easyui/jquery.easyui.min.js"></script>
    <script src="../../../../../../../IdeaProjects/web-project/crm-web/src/main/webapp/easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" type="text/css" href="../../../../../../../IdeaProjects/web-project/crm-web/src/main/webapp/easyui/themes/material/easyui.css"/>
    <link rel="stylesheet" href="../../../../../../../IdeaProjects/web-project/crm-web/src/main/webapp/easyui/themes/icon.css"/>
    <meta charset="utf-8"/>
    <title>修改密码</title>
</head>
<body>
    <form class="form-control" method="post" action="userMgr.do?act=editpwd">
        <div class="form-group">
        <label for="pwd">原密码:</label>
        <div>
            <input type="password" name="pwd" id="pwd" required="required"/>
        </div>
        </div>
        <div class="form-group">
            <label for="newpwd">新密码:</label>
            <div>
                <input type="password" name="newpwd" id="newpwd" required="required"/>
            </div>
        </div>
        <div class="form-group">
            <label for="newpwdrepeat">重复密码:</label>
            <div>
                <input type="password" id="newpwdrepeat" name="newpwdrepeat" required="required"/>
            </div>
        </div>
        <div class="form-group">
            <button class="btn btn-default" type="submit" onclick="return check()">提交</button>&nbsp;${result}
        </div>

    </form>
</body>
<script>
    function check() {
        var pwd1 = $('#newpwd').val();
        var pwd2 = $('#newpwdrepeat').val();
        if(pwd1!=pwd2){
            alert("新密码不一致！");
            return false;
        }else{
            return true;
        }
    }
</script>
</html>
