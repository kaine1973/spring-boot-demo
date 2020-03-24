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
<style>
    .hidden{
        display:none;
    }
</style>
</head>

<body>

<#--<div class="alert alert-danger" style="position: absolute; z-index: 10" role="alert">-->
<#--    <strong>Holy guacamole!</strong> You should check in on some of those fields below-->
<#--    <button class="close" data-dismiss="alert"><i class="zmdi zmdi-close"></i></button>-->
<#--</div>-->
    <div class="main-wrapper">

        <!-- Content Body Start -->
        <div class="content-body m-0 p-0">

            <div class="login-register-wrap">
                <div class="row">

                    <div class="d-flex align-self-center justify-content-center order-2 order-lg-1 col-lg-5 col-12">
                        <div class="alert alert-danger hidden" id="warningDiv" style="position:absolute;z-index: 10" role="alert">
                            <i class="zmdi zmdi-info"></i> <span id="warning"></span>
                        </div>
<#--                        <div class="alert alert-outline-danger hidden" id="warningDiv" style="position:absolute;z-index: 10" role="alert">-->
<#--                            <i class="zmdi zmdi-info"></i> <span id="warning"></span>-->
<#--                        </div>-->

                        <div class="login-register-form-wrap">

                            <div class="content">
                                <h1>用户登入</h1>
<#--                                <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>-->
                            </div>

                            <div class="login-register-form">
                                <div class="row ">
                                    <div class="col-12 mb-20"><p></p></div>
                                </div>
                                <form id="loginForm" >
                                    <div class="row">
                                        <div class="col-12 mb-20"><input id="username" class="form-control" autocomplete="off" type="text" placeholder="用户名">
                                            <span id="userNameWarning" style="font-size:8px;color:red"></span></div>
                                        <div class="col-12 mb-20"><input id="password" class="form-control" autocomplete="off" type="password" placeholder="密码">
                                            <span id="passwordWarning" style="font-size:8px;color:red"></span></div>
                                        <div class="col-12 mb-20"><label for="remember" class="adomx-checkbox-2"><input id="remember" type="checkbox" value="remember"><i class="icon"></i>保持登录.</label></div>
<#--                                        <div class="col-12">-->
<#--                                            <div class="row justify-content-between">-->
<#--&lt;#&ndash;                                                <div class="col-auto mb-15"><a href="#">Forgot Password?</a></div>&ndash;&gt;-->
<#--&lt;#&ndash;                                                <div class="col-auto mb-15">Dont have account? <a href="register.ftl">Create Now.</a></div>&ndash;&gt;-->
<#--                                            </div>-->
<#--                                            </div>-->
                                    </div>
                                    <div class="col-12 mt-10" style="float: left"><button class="button button-primary button-outline" type="button" onclick="login()">登录</button></div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="login-register-bg order-1 order-lg-2 col-lg-7 col-12">
                        <div class="content">
                            <h1>用户登入</h1>
<#--                            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>-->
                        </div>
                    </div>

                </div>
            </div>

        </div><!-- Content Body End -->

    </div>

</body>
<script>
    function alertSuccess(msg) {
        $('#warning').text(msg);
        $('#warningDiv').removeClass('alert-danger')
        $('#warningDiv').addClass('alert-success')

        $('#warningDiv').removeClass('hidden')
        setTimeout(function () {
            $('#warningDiv').addClass('hidden')
        },3000)
    }

    function login() {
        $("#loginForm").attr('readonly','true')
        var username = $('#username').val();
        var password = $('#password').val();

        if(isEmpty(username)){
            alertWarning("请填写用户名");
            return;
        }

        if(isEmpty(password)){
            alertWarning("请填写密码");
            return;
        }
        $.ajax({
            url: "/user/login",
            type: 'post',
            data:{
                userName: username,
                userPwd: password,
                remember:$("#remember").is(':checked')
            },
            success:function (data) {
                //console.log(data);
                if(data.code===200) {
                    alertSuccess(data.msg);
                    if (null != data.result) {
                        Cookies.set('ui', data.result.ui)
                        Cookies.set('ut', data.result.ut)
                    }
                    // 跳转到主页
                    window.location.replace("/main");
                }else{
                    console.log(data.msg)
                    alertWarning(data.msg);
                }
            },
            error:function () {
                alertWarning("服务器没有成功响应，稍后再试，或者联系管理员")
            }
        });

        $("#loginForm").removeAttr('readonly')
    }
    function alertWarning(content) {

        $('#warning').text(content);

        $('#warningDiv').removeClass('alert-success')
        $('#warningDiv').addClass('alert-danger')
        $('#warningDiv').removeClass('hidden')
        setTimeout(function () {
            $('#warningDiv').addClass('hidden')
        },3000)
    }
</script>
<#include "jsCommon.ftl">
</html>