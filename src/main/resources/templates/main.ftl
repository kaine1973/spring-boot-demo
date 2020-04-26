<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Adomx - Responsive Bootstrap 4 Admin Template</title>
    <meta name="robots" content="noindex, follow"/>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Favicon -->

    <#include "common.ftl" >
</head>
<style>
    div .nice-select{
        height: 36px
    }
    td div button {
        height: 36px;
    }
    @media only screen and (max-width: 767px){
        .hide-responsive{
            display: none;
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
<div class="loading" ></div>
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

                                    <div class="header-search">

                                        <button class="header-search-open d-block d-xl-none"><i class="zmdi zmdi-search"></i></button>

                                        <div class="header-search-form">
                                            <form action="#">
                                                <label>
                                                    <input type="text" placeholder="搜索_">
                                                </label>
                                                <button><i class="zmdi zmdi-search"></i></button>
                                            </form>
                                            <button class="header-search-close d-block d-xl-none"><i class="zmdi zmdi-close"></i></button>
                                        </div>

                                    </div>
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
                <li class="has-sub-menu"><a href="#"><i class="ti-notepad"></i> <span>客户管理</span></a>
                    <ul class="side-header-sub-menu">
                        <li><a href="javascript:addDynamicContent('/customer/detail')"> <span>新增客户</span></a>
                        </li>
                        <li><a href="javascript:addDynamicContent('/customer/customerManager')"> <span>客户管理</span> </a>
                        </li>
                    </ul>
                </li>
                <li class="has-sub-menu"><a href="#"><i class="ti-palette"></i> <span>产品管理</span></a>
                    <ul class="side-header-sub-menu">
                        <li><a href="javascript:addDynamicContent('/product/getProductPage')"> <span>添加产品</span></a>
                        </li>
                        <li><a href="javascript:addDynamicContent('/product/manage')"> <span>库存管理</span> </a>
                        </li>
                    </ul>
                </li>
                <li class="has-sub-menu"><a href="#"><i class="ti-user"></i> <span>订单管理</span></a>
                    <ul class="side-header-sub-menu">
                        <li><a href="javascript:addStaticContent('sample/dashboard')"> <span>添加订单</span></a>
                        </li>
                        <li><a href="javascript:addStaticContent('sample/chart/chartjs')"> <span>订单管理</span> </a>
                        </li>
                    </ul>
                </li>
<#--                <li><a href="javascript:addStaticContent('sample/widgets')"><i class="ti-palette"></i><span>Widgets</span></a>-->
<#--                </li>-->
<#--                <li class="has-sub-menu"><a href="#"><i class="ti-package"></i> <span>Basic Elements</span></a>-->
<#--                    <ul class="side-header-sub-menu">-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/alerts')"><span>Alerts</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/accordions')"><span>Accordions</span></a>-->
<#--                        </li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/avatar')"><span>Avatar</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/badge')"><span>Badge</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/buttons')"><span>Buttons</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/carousel')"><span>Carousel</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/dropdown')"><span>Dropdown</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/list-group')"><span>List Group</span></a>-->
<#--                        </li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/media')"><span>Media</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/modal')"><span>Modal</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/pagination')"><span>Pagination</span></a>-->
<#--                        </li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/progress')"><span>Progress Bar</span></a>-->
<#--                        </li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/spinners')"><span>Spinners</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/tabs')"><span>Tabs</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/tooltip')"><span>Tooltip</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/typography')"><span>Typography</span></a>-->
<#--                        </li>-->
<#--                    </ul>-->
<#--                </li>-->
<#--                <li class="has-sub-menu"><a href="#"><i class="ti-crown"></i> <span>Advance Elements</span></a>-->
<#--                    <ul class="side-header-sub-menu">-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/clipboard')"><span>Clipboard</span></a></li>-->
<#--                        <li>-->
<#--                            <a href="javascript:addStaticContent('sample/elements/fullcalendar')"><span>Full Calendar</span></a>-->
<#--                        </li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/media-p')"><span>Media Player</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/sortable')"><span>Sortable (Drag&Drop)</span></a>-->
<#--                        </li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/toastr')"><span>Toastr</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/rating')"><span>Rating</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/elements/sweetalert')"><span>Sweet Alert</span></a>-->
<#--                        </li>-->
<#--                    </ul>-->
<#--                </li>-->
<#--                <li class="has-sub-menu"><a href="#"><i class="ti-stamp"></i> <span>Icons</span></a>-->
<#--                    <ul class="side-header-sub-menu">-->
<#--                        <li><a href="javascript:addStaticContent('sample/icons/cryptocurrency')"><span>Cryptocurrency</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/icons/fontawesome')"><span>Font Awesome</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/icons/material')"><span>Material Icon</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/icons/themify')"><span>Themify Icon</span></a></li>-->
<#--                    </ul>-->
<#--                </li>-->
<#--                <li class="has-sub-menu"><a href="#"><i class="ti-notepad"></i> <span>Forms</span></a>-->
<#--                    <ul class="side-header-sub-menu">-->
<#--                        <li><a href="javascript:addStaticContent('sample/form/basic-elements')"><span>Basic Elements</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/form/checkbox')"><span>Checkbox</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/form/date-mask')"><span>Date & Mask</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/form/editor')"><span>Editor</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/form/file-upload')"><span>File Upload</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/form/layout')"><span>Layout</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/form/radio')"><span>Radio</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/form/range-slider')"><span>Range Slider</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/form/selects')"><span>Selects</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/form/switchers')"><span>Switchers</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/form/wizard')"><span>Wizard</span></a></li>-->
<#--                    </ul>-->
<#--                </li>-->
<#--                <li class="has-sub-menu"><a href="#"><i class="ti-layout"></i> <span>Table</span></a>-->
<#--                    <ul class="side-header-sub-menu">-->
<#--                        <li><a href="javascript:addStaticContent('sample/table/basic')"><span>Basic</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/table/data-table')"><span>Data Table</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/table/footable')"><span>Footable</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/table/jsgrid')"><span>Jsgrid</span></a></li>-->
<#--                    </ul>-->
<#--                </li>-->
<#--                <li class="has-sub-menu"><a href="#"><i class="ti-pie-chart"></i> <span>Charts</span></a>-->
<#--                    <ul class="side-header-sub-menu">-->
<#--                        <li><a href="javascript:addStaticContent('sample/chart/chartjs')"><span>ChartJs</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/chart/echarts')"><span>Echarts</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/chart/google')"><span>Google Chart</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/chart/morris')"><span>Morris  Chart</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/chart/sparkline')"><span>Sparkline  Chart</span></a></li>-->
<#--                    </ul>-->
<#--                </li>-->
<#--                <li class="has-sub-menu"><a href="#"><i class="ti-map"></i> <span>Maps</span></a>-->
<#--                    <ul class="side-header-sub-menu">-->
<#--                        <li><a href="javascript:addStaticContent('sample/map/vector')"><span>Vector Map</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/map/google')"><span>Google Map</span></a></li>-->
<#--                    </ul>-->
<#--                </li>-->
<#--                <li class="has-sub-menu"><a href="#"><i class="ti-shopping-cart"></i> <span>E-commerce</span></a>-->
<#--                    <ul class="side-header-sub-menu">-->
<#--                        <li><a href="javascript:addStaticContent('sample/add-product')"><span>Add Product</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/edit-product')"><span>Edit Product</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/invoice-list')"><span>Invoice List</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/invoice-details')"><span>Invoice Details</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/order-list')"><span>Order List</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/order-details')"><span>Order Details</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/manage-products')"><span>Manage Products</span></a></li>-->
<#--                    </ul>-->
<#--                </li>-->
<#--                <li class="has-sub-menu"><a href="#"><i class="ti-gift"></i> <span>Apps</span></a>-->
<#--                    <ul class="side-header-sub-menu">-->
<#--                        <li><a href="javascript:addStaticContent('sample/chat')"><span>Chat</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/mail')"><span>Mail</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/single-mail')"><span>Single Mail</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/todo-list')"><span>Todo List</span></a></li>-->
<#--                    </ul>-->
<#--                </li>-->
<#--                <li class="has-sub-menu"><a href="#"><i class="ti-lock"></i> <span>Authentication</span></a>-->
<#--                    <ul class="side-header-sub-menu">-->
<#--                        <li><a href="javascript:addStaticContent('sample/login')"><span>login</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/register')"><span>register</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/author-profile')"><span>Profile</span></a></li>-->
<#--                    </ul>-->
<#--                </li>-->
<#--                <li class="has-sub-menu"><a href="#"><i class="ti-layers"></i> <span>Pages</span></a>-->
<#--                    <ul class="side-header-sub-menu">-->
<#--                        <li><a href="javascript:addStaticContent('sample/blank')"><span>Blank</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/timeline')"><span>Timeline</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/pricing')"><span>Pricing</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/error-1')"><span>error-1</span></a></li>-->
<#--                        <li><a href="javascript:addStaticContent('sample/error-2')"><span>error-2</span></a></li>-->
<#--                    </ul>-->
<#--                </li>-->

            </ul>
        </nav>

    </div><!-- Side Header Inner End -->
</div><!-- Side Header End -->

<!-- Content Body Start -->
<div class="content-body" id="main" >
    <#include "dashboard.ftl">
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
<#include "jsCommon.ftl">
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
            $('#exampleModalLong').modal('hide')
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
    function addDynamicContent(url) {
        showLoadingDiv()
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