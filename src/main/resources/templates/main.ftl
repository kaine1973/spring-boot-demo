<html>
<title>主页</title>
<head>
    <link rel="icon" href="https://v3.bootcss.com/favicon.ico">

    <script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
    <link rel="stylesheet" href="/bs/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="/bs/css/bootstrap-theme.css" crossorigin="anonymous">
    <script src="/bs/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="/easyui/jquery.easyui.min.js"></script>
    <script src="/easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" type="text/css" href="/easyui/themes/material/easyui.css"/>
    <link rel="stylesheet" href="/easyui/themes/icon.css"/>
    <meta charset="utf-8"/>
    <title></title>

</head>

<style>
    body {
        font-family: 微软雅黑;
    }
    .panel {
        margin-top: 5px;
        border-radius: 7px;
    }
</style>
<body class="easyui-layout" onload="startTime()" `>

<#--<div class="container" data-options="region:'north'" style="background:url(../../../../../../../IdeaProjects/web-project/crm-web/src/main/webapp/img/bg.jpg) ;height:180px">
    <img src="
<c:if test="${user.head==null}">
	/img/1.jpg
</c:if>
<c:if test="${user.head!=null}">
	../head/${user.head}
</c:if>
" style="margin-left: 50px;border-radius:50%;float: left;width: 175px;height:175px"/>
    <span class="menu-text" style="margin-left: 30px;margin-top: 80px;font-family: 微软雅黑;font-size: xx-large;color: #1b1b1b">
        ${user.nick}
        <br/><span style="margin-top: 5px;font-size: small;font-family: 微软雅黑">
        <c:if test="${user.mood==null}">
            还没设置心情。。。
        </c:if>
        <c:if test="${user.mood!=null}">
            ${user.mood}
        </c:if>
        </span>
    </span>



</div>-->



<div data-options="region:'west',split:true" style="width:240px;">
    <div class="panel panel-success">
        <div class="panel-heading" onclick="accordion()">我的帖子</div>
        <div class="panel-body" hidden=true>
            <ul class="list-group">
                <li class="list-group-item"><a href="javascript:addTab('帖子列表','/article/showArticles')"
                                               style="width:100%"
                                               class="btn btn-default">我的帖子</a></li>
                <li class="list-group-item"><a href="javascript:addTab('新的帖子','/article/newArticle')" style="width:100%"
                                               class="btn btn-default">写新帖子</a></li>

            </ul>
        </div>
    </div>
    <div class="panel panel-info">
        <div class="panel-heading" onclick="accordion2()">我的好友</div>
        <div class="panel-body">
            <ul class="list-group">
            </ul>
        </div>
    </div>
    <div class="panel panel-warning">
        <div class="panel-heading" onclick="accordion3()">个人管理</div>
        <div class="panel-body" hidden=true>
            <ul class="list-group" >
                <li class="list-group-item" >
                    <a class="btn btn-default" style="width:100%;" href="javascript:addTab('修改信息','/user/alterInfo')">修改信息</a>
                </li>
                <li class="list-group-item" >
                    <a class="btn btn-default" style="width:100%;" href="javascript:addTab('修改密码','password.jsp')">修改密码</a>
                </li>
            </ul>
        </div>
    </div>
</div>

<div id="divcenter" data-options="region:'center'">
    <div id="tt" class="easyui-tabs" style="height: 99%; font-size: 100%;">

    </div>
</div>

<div data-options="region:'south'" style="height:32px;font-size: 20px;">

<#if user!"You are now offline...">
    <div style="display:inline-block;float: left;">
        已作为[${user.userName}]登录&nbsp;&nbsp;<div style="display:inline-block;float: left;">
    </div>
    <a href="javascript:logout()">注销登陆</a></div>
    </#if>


    <div style="display:inline-block;float: right;">time：<span id="nowDateTimeSpan"></span></div>

</div>

<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div id="myModalbody" class="modal-body">
                ...
            </div>
            <div id="myModalDate"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">


    $('#aa').accordion({
        onSelect: function (title, index) {
            $("ul[name='" + title + "']").tree({
                url: 'menu/getModules?menuName=' + title,
            });

        }
    });


    function showModal(title, content, date) {
        $('#myModalLabel').html(title);
        $('#myModalbody').html(content);
        $('#myModalDate').html(date);
        $('#myModal1').modal('show');
    }

    function listMyArticle(text, url) {
                if ($("#tt").tabs("exists", text)) {
                    var pp = $('#tt').tabs('getSelected');
                    $("#tt").tabs("select", text);
                } else {
                    var content = "<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='" + url + "'></iframe>";
                    $("#tt").tabs("add", {
                        title: text,
                        closable: true,
                        content: content
                    });
                }
    }

    function accordion() {
        var pan = $('.panel-success>div:last').prop('hidden');
        $('.panel-success>div:last').prop('hidden', !pan);
    }

    function accordion2() {
        var pan = $('.panel-info>div:last').prop('hidden');
        $('.panel-info>div:last').prop('hidden', !pan);
    }

    function accordion3() {
        var pan = $('.panel-warning>div:last').prop('hidden');
        $('.panel-warning>div:last').prop('hidden', !pan);
    }

    function startTime() {
        var today = new Date();
        var yyyy = today.getFullYear();
        var MM = today.getMonth() + 1;
        var dd = today.getDate();
        var hh = today.getHours();
        var mm = today.getMinutes();
        var ss = today.getSeconds();
        MM = checkTime(MM);
        dd = checkTime(dd);
        mm = checkTime(mm);
        ss = checkTime(ss);
        var day;
        if (today.getDay() == 0) day = "Sun"
        if (today.getDay() == 1) day = "Mon"
        if (today.getDay() == 2) day = "Tue"
        if (today.getDay() == 3) day = "Wed"
        if (today.getDay() == 4) day = "Tur"
        if (today.getDay() == 5) day = "Fri"
        if (today.getDay() == 6) day = "Sat"
        document.getElementById('nowDateTimeSpan').innerHTML = yyyy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss + "   " + day;
        setTimeout('startTime()', 1000);
    }

    function checkTime(i) {
        if (i < 10) {
            i = "0" + i;
        }
        return i;
    }

    function logout() {
        $.ajax({
            type: 'post',
            url: "userMgr.do?act=logout",
            success: function () {
                location.reload();
            }
        })
    }

    function addTab(text, url) {
        if ($("#tt").tabs("exists", text)) {
            $("#tt").tabs("select", text);
        } else {
            var content = "<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='" + url + "'></iframe>";
            $("#tt").tabs("add", {
                title: text,
                closable: true,
                content: content
            });
        }
    }


</script>

</html>
