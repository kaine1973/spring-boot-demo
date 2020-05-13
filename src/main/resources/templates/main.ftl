<!doctype html>
<html lang="zh-cn">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Adomx - Responsive Bootstrap 4 Admin Template</title>
    <meta name="robots" content="noindex, follow"/>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Favicon -->
    <#include "jsCommon.ftl">
    <#include "common.ftl">
</head>
<style>
    div .nice-select{
        height: 36px
    }
    td div button {
        height: 36px;
    }
    @media only screen and (max-width: 980px){
        .hide-responsive{
            display: none;
        }
        .show-responsive{
            display: block;
        }
    }
    .input-group-text{
        font-size: 13px;
    }
    tr td {
        padding: 6px;
        overflow: hidden;
        text-overflow:ellipsis;
        white-space: nowrap;
        max-width: 250px;
        text-align: left;
        /*vertical-align: middle;*/
        table-layout: fixed;
        word-break: break-all;
    }
</style>
<body>

<#--<div class="loading" ></div>-->
<div class="alert alert-danger hidden" id="warningDiv" style="position:fixed;
        z-index: 99999;left: 50%;top: 5px;-webkit-transform: translate(-50%, -50%);
				-moz-transform: translate(-50%, 0%);
				-ms-transform: translate(-50%, 0%);
				-o-transform: translate(-50%, 0%);
				transform: translate(-50%, 0%);" role="alert">
    <i class="zmdi zmdi-info"></i> <span id="warning"></span>
</div>


<div class="main-wrapper">
    <!-- Header Section Start -->
    <div class="header-section">
        <div class="container-fluid">
            <div class="row justify-content-between align-items-center">
                <!-- Header Logo (Header Left) Start -->
<#--                <div class="header-logo col-auto">-->
<#--                    <a href="javascript:addStaticContent('sample/main')">-->
<#--&lt;#&ndash;                        <img src="/images/logo/logo.png" alt="">&ndash;&gt;-->
<#--&lt;#&ndash;                        <img src="/images/logo/logo-light.png" class="logo-light" alt="">&ndash;&gt;-->
<#--                    </a>-->
<#--                </div>-->
                <!-- Header Logo (Header Left) End -->

                <!-- Header Right Start -->
                <div class="header-right flex-grow-1 col-auto">
                    <div class="row justify-content-between align-items-center">

                        <!-- Side Header Toggle & Search Start -->
                        <div class="col-auto">
                            <div class="row align-items-center">

                                <!--Side Header Toggle-->
                                <div class="col-auto"><button class="side-header-toggle"><i class="zmdi zmdi-menu"></i></button></div>

                                <!--Header Search-->
                                <div class="col-auto">

<#--                                    <div class="header-search">-->

<#--                                        <button class="header-search-open d-block d-xl-none"><i class="zmdi zmdi-search"></i></button>-->

<#--                                        <div class="header-search-form">-->
<#--                                            <form action="#">-->
<#--                                                <label>-->
<#--                                                    <input type="text" placeholder="搜索_">-->
<#--                                                </label>-->
<#--                                                <button><i class="zmdi zmdi-search"></i></button>-->
<#--                                            </form>-->
<#--                                            <button class="header-search-close d-block d-xl-none"><i class="zmdi zmdi-close"></i></button>-->
<#--                                        </div>-->

<#--                                    </div>-->
                                </div>

                            </div>
                        </div><!-- Side Header Toggle & Search End -->

                    <!-- Header Notifications Area Start -->
                    <div class="col-auto">

                        <ul class="header-notification-area">

                            <li class="adomx-dropdown col-auto">
                                <a class="toggle" href="#"><i class="zmdi zmdi-email-open"></i><span
                                            class="badge"></span></a>

                                <!-- Dropdown -->
                                <div class="adomx-dropdown-menu dropdown-menu-mail">
                                    <div class="head">
                                        <h4 class="title">You have 3 new mail.</h4>
                                    </div>
                                    <div class="body custom-scroll">
                                        <ul>
                                            <li>
                                                <a href="#">
                                                    <div class="image"><img src="/images/avatar/avatar-2.jpg" alt="">
                                                    </div>
                                                    <div class="content">
                                                        <h6>Sub: New Account</h6>
                                                        <p>There are many variations of passages of Lorem Ipsum
                                                            available. </p>
                                                    </div>
                                                    <span class="reply"><i class="zmdi zmdi-mail-reply"></i></span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <div class="image"><img src="/images/avatar/avatar-1.jpg" alt="">
                                                    </div>
                                                    <div class="content">
                                                        <h6>Sub: Mail Support</h6>
                                                        <p>There are many variations of passages of Lorem Ipsum
                                                            available. </p>
                                                    </div>
                                                    <span class="reply"><i class="zmdi zmdi-mail-reply"></i></span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <div class="image"><img src="/images/avatar/avatar-2.jpg" alt="">
                                                    </div>
                                                    <div class="content">
                                                        <h6>Sub: Product inquiry</h6>
                                                        <p>There are many variations of passages of Lorem Ipsum
                                                            available. </p>
                                                    </div>
                                                    <span class="reply"><i class="zmdi zmdi-mail-reply"></i></span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <div class="image"><img src="/images/avatar/avatar-1.jpg" alt="">
                                                    </div>
                                                    <div class="content">
                                                        <h6>Sub: Mail Support</h6>
                                                        <p>There are many variations of passages of Lorem Ipsum
                                                            available. </p>
                                                    </div>
                                                    <span class="reply"><i class="zmdi zmdi-mail-reply"></i></span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                            </li>

                            <!--Notification-->
                            <li class="adomx-dropdown col-auto" data-toggle="tooltip" data-placement="top" title="出库单">
                                <a class="toggle" href="#"><i class="zmdi zmdi-calendar-note" onclick="getCartStuffs()"></i><span
                                            class="badge"></span></a>
                                <div class="adomx-dropdown-menu dropdown-menu-mail">
                                    <div class="head">
                                        <h5 class="title">购物车里有<span id="cart-count"></span>项<a style="float: right;display: inline" href="javascript:getCartStuffs();"><i class="zmdi zmdi-refresh"></i>刷新</a></h5>
                                    </div>
                                    <div class="body custom-scroll">
                                        <ul id="stockOutList">
                                            <li class="empty-cart">
                                                <p>Nothing</p>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="footer">
                                        <a href="javascript:showOrderPage()" class="view-all"><h6 style="color: #55a1fb">下单</h6></a>
                                    </div>
                                </div>

                            </li>

                            <!--User-->
                            <li class="adomx-dropdown col-auto">
                                <a class="toggle" href="#">
                                            <span class="user">
                                        <span class="avatar">
                                            <img src="/images/avatar/avatar-1.jpg" alt="">
                                            <span class="status"></span>
                                            </span>
                                            <span class="name">${user.userName}</span>
                                            </span>
                                </a>

                                <!-- Dropdown -->
                                <div class="adomx-dropdown-menu dropdown-menu-user">
                                    <div class="head">
                                        <h5 class="name"><a href="#">${user.userName}</a></h5>
                                        <a class="mail" href="#">mailnam@mail.com</a>
                                    </div>
                                    <div class="body">
                                        <ul>
                                            <li><a href="#"><i class="zmdi zmdi-account"></i>个人主页</a></li>
                                            <li><a href="#"><i class="zmdi zmdi-email-open"></i>收件箱</a></li>
                                            <li><a href="#"><i class="zmdi zmdi-wallpaper"></i>动态</a></li>
                                        </ul>
                                        <ul>
                                            <li><a href="#"><i class="zmdi zmdi-settings"></i>系统设置</a></li>
                                            <li><a href="javascript:signOut()"><i class="zmdi zmdi-lock-open"></i>安全退出</a></li>
                                        </ul>
                                        <ul>
                                            <li><a href="#"><i class="zmdi zmdi-paypal"></i>支付</a></li>
                                            <li><a href="#"><i class="zmdi zmdi-google-pages"></i>收入</a></li>
                                        </ul>
                                    </div>
                                </div>

                            </li>

                        </ul>

                    </div><!-- Header Notifications Area End -->

                    </div>
                </div><!-- Header Right End -->

            </div>
        </div>
    </div><!-- Header Section End -->
<!-- Side Header Start -->
<div class="side-header show">
    <button class="side-header-close"><i class="zmdi zmdi-close"></i></button>
    <!-- Side Header Inner Start -->
    <div class="side-header-inner custom-scroll">

        <nav class="side-header-menu" id="side-header-menu">
            <ul>
                <li class="has-sub-menu <#if page_active?starts_with("customer")>active</#if>"><a href="#"><i class="ti-notepad"></i> <span>客户管理</span></a>
                    <ul class="side-header-sub-menu" <#if page_active?starts_with("customer")>style="display: block;" </#if>>
                        <li <#if page_active=="customer_detail">class="active"</#if>><a href="/customer/detail"> <span>新增客户</span></a>
                        </li>
                        <li <#if page_active=="customer_manage">class="active"</#if>><a href="/customer/customerManager"> <span>客户管理</span> </a>
                        </li>
                    </ul>
                </li>
                <li <#if page_active=="product_detail">class="active"</#if>><a href="/product/getProductPage" ><span>添加产品</span></a>
                </li>
                <li <#if page_active=="product_manage">class="active"</#if>><a  href="/product/manage" ><span>产品目录</span></a>
                </li>
                <li <#if page_active=="order_history">class="active"</#if>><a href='/order/getHistoryPage'> <span>订单记录</span> </a>
                </li>
                <li <#if page_active=="stock_out_history">class="active"</#if>><a href="/stock/getStockHistoryPageOfSTOCK_OUT" ><span>出库记录</span></a>
                </li>
                <li <#if page_active=="stock_in_history">class="active"</#if>><a href="/stock/getStockHistoryPageOfSTOCK_IN"><span>入库记录</span></a>
                </li>
                <li <#if page_active=="statistics_contribution">class="active"</#if>><a href="/statistics/customerContribution"><span>客户贡献度</span></a>
                </li>
            </ul>
        </nav>

    </div><!-- Side Header Inner End -->
</div><!-- Side Header End -->

<!-- Content Body Start -->
<div class="content-body" id="main" >
    ${content}
</div>
    <!--    Alert-->
<#--    <div class="alert alert-primary" role="alert" id="confirmAlert">-->
<#--        <h3>Custom Content Title</h3>-->
<#--        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Libero placeat, minima dolore similique culpa cumque nisi quam, quaerat expedita delectus incidunt sed sunt! Excepturi aspernatur enim reprehenderit exercitationem distinctio sit!</p>-->
<#--        <button class="button button-success">submit</button>-->
<#--        <button class="button button-danger" data-dismiss="alert">close</button>-->
<#--    </div>-->
    <!-- Modal -->
    <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="modalBody">
                    ...
                </div>
<#--                <div class="modal-footer">-->
<#--                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>-->
<#--                    <button type="button" class="btn btn-primary">Save changes</button>-->
<#--                </div>-->
            </div>
        </div>
    </div>

<!-- Content Body End -->

<!-- Footer Section Start -->
<#--<div class="footer-section">-->
<#--    <div class="container-fluid">-->

<#--        <div class="footer-copyright text-center">-->
<#--            <p class="text-body-light">2020 &copy; <a href="http://www.eltbio.com">Enlighten</a></p>-->
<#--        </div>-->

<#--    </div>-->
<#--</div><!-- Footer Section End &ndash;&gt;-->

</div>
</body>
<script src="/js/main.js"></script>

<script>

//    function niceSelector(){
//        $('select').niceSelect();
//    }

    $('#main').click(function () {
        if($(document).width() < 1214){
            $('.side-header').removeClass('show');
            $('.side-header').addClass('hide');
        }
    })
    window.scrollTo(0,0)

    function closeModal() {
        if(confirm('未保存的更改将被舍弃')){
            $('.modal').modal('hide')
        }
    }

    function addStaticContent(page) {
        showLoadingDiv()
        // $('.spinner-grow').removeClass('hidden')
        $.ajax({
            url: 'staticWeb',
            type: 'get',
            data: {
                "requestPage": page,
            },
            dataType: 'JSON',
            success: function (data) {
                if(data.code === 200){
                    $('#main').html(data.result);
                    window.scrollTo(0,0)
                    $('select').niceSelect();
                }else{
                    alertWarning(data.msg)
                }
            },
            error: function () {
                alertWarning("请求服务器失败，请重试，或者联系管理员。")
            }

        })

        $('.spinner-grow').addClass('hidden')
        if ($(document).width() < 1214) {
            $('.side-header').removeClass('show');
            $('.side-header').addClass('hide');
        }
        stopLoadingDiv()

    }
    function alertSuccess(msg) {
        $('#warning').text(msg);
        $('#warningDiv').removeClass('alert-danger')
        $('#warningDiv').addClass('alert-success')

        $('#warningDiv').removeClass('hidden')
        setTimeout(function () {
            $('#warningDiv').addClass('hidden')
        },3000)
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
    function signOut() {
        showLoadingDiv()
        $.ajax({
            url:'/user/logout',
            type:'get',
            success:function (data) {
                if(data.code === 200){

                    window.location.replace('/login')
                }else{
                    alertWarning(data.msg)
                }
            }
        })
        stopLoadingDiv()
    }
    function addDynamicContent(url,e) {
        $('.side-header-menu >li').removeClass('active')
        console.log(e)
        $(e).parents('li').addClass('active')
        $.ajax({
            url: url,
            type: 'get',
            dataType: 'json',
            success: function (data) {
                if(data.code === 200){
                    $('#main').html(data.result);
                    window.scrollTo(0,0)
                    // $('select').selectpicker();
                    // $('.nice-select').niceSelect();
                }else{
                    alertWarning(data.msg)
                }
            },
            error: function () {
                alertWarning("请求服务器失败，请重试，或者联系管理员。")
            }

        })
        if ($(document).width() < 1214) {
            $('.side-header').removeClass('show');
            $('.side-header').addClass('hide');
        }
        stopLoadingDiv()
    }


</script>

</html>