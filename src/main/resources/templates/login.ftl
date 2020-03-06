<!doctype html>
<html class="no-js" lang="en">

<head>
    <#include "common.ftl">
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Adomx - Responsive Bootstrap 4 Admin Template</title>
    <meta name="robots" content="noindex, follow" />
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Favicon -->

</head>

<body>

    <div class="main-wrapper">

        <!-- Content Body Start -->
        <div class="content-body m-0 p-0" style="background-color: lightgoldenrodyellow">

            <div class="login-register-wrap">
                <div class="row">

                    <div class="d-flex align-self-center justify-content-center order-2 order-lg-1 col-lg-5 col-12">
                        <div class="login-register-form-wrap">

                            <div class="content">
                                <h1>登 录</h1>
                                <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
                            </div>

                            <div class="login-register-form">
                                <form>
                                    <div class="row">
                                        <div class="col-12 mb-20"><input id="username" class="form-control" autocomplete="off" onchange="cleanWarning('#userNameWarning')" type="text" placeholder="User ID / Email">
                                            <span id="userNameWarning" style="font-size:8px;color:red"></span></div>
                                        <div class="col-12 mb-20"><input id="password" class="form-control" autocomplete="off" onchange="cleanWarning('#passwordWarning')" type="password" placeholder="Password">
                                            <span id="passwordWarning" style="font-size:8px;color:red"></span></div>
                                        <div class="col-12 mb-20"><label for="remember" class="adomx-checkbox-2"><input id="remember" type="checkbox"><i class="icon"></i>Remember.</label></div>
                                        <div class="col-12">
                                            <div class="row justify-content-between">
<#--                                                <div class="col-auto mb-15"><a href="#">Forgot Password?</a></div>-->
<#--                                                <div class="col-auto mb-15">Dont have account? <a href="register.ftl">Create Now.</a></div>-->
                                            </div>
                                        </div>
                                        <div class="col-12 mt-10"><button class="button button-primary button-outline" type="button" onclick="login()">sign in</button></div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="login-register-bg order-1 order-lg-2 col-lg-7 col-12">
                        <div class="content">
                            <h1>登录</h1>
                            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
                        </div>
                    </div>

                </div>
            </div>

        </div><!-- Content Body End -->

    </div>

</body>
<script>
    function login() {
        var username = $('#username').val();
        var password = $('#password').val();

        if(isEmpty(username)){
            $('#userNameWarning').text("用户名不能为空");
            return;
        }

        if(isEmpty(password)){
            $('#passwordWarning').text("密码不能为空");
            return;
        }
        $.ajax({
            url: ctx + "/user/login",
            type: 'post',
            data:{
                userName: username,
                userPwd: password
            },
            success:function (data) {
                //console.log(data);
                if(data.code==200){
                    // 存入cookie信息
                    $.cookie("userIdStr", data.result.userIdStr);

                    alert(data.msg);
                    // 跳转到主页
                    window.location.href = ctx + "/main";
                }else{
                    alert(data.msg);
                }
            }
        });
    }
    function cleanWarning(id) {
        $(id).html('');
    }
</script>
<#include "jsCommon.ftl">
</html>