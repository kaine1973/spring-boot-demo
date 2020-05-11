<div class="row justify-content-between align-items-center mb-10">

    <!-- Page Heading Start -->
    <div class="col-12 col-lg-auto mb-20">
        <div class="page-heading">
            <h3>订单记录</h3>
        </div>
    </div><!-- Page Heading End -->

    <!-- Page Button Group Start -->
    <!-- Page Button Group End -->

</div>
<style>
    .card-header{
        height: 40px;
        padding: 7px;
        background-color: #f0f0f0;
    }
    .list-group li{
        height: 40px;
        padding: 7px;
    }
    .card-footer{
        height: 40px;
        padding: 7px;
    }
    .card div{
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
</style>
<div class="box"  style='min-width: 1000px'>
    <div class="box-head">
        <h6>搜索：</h6>
        <div class="row">
            <div class="col-lg-4 col-12 mb-5">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">产品</span>
                    </div>
                    <input id="queryProductName" type="text" class="form-control form-control-sm">
                </div>
            </div>
            <div class="col-lg-4 col-12 mb-5">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">订单号</span>
                    </div>
                    <input id="queryOrderNumber" type="text" class="form-control form-control-sm">
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-lg-4 col-12 mb-5">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">日期</span>
                    </div>
                    <input id="date-range" type="text" class="form-control form-control-sm">
                </div>
            </div>
            <div class="col-lg-4 col-12 mb-5">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">销售</span>
                    </div>
                    <select id="queryUserId" type="text" class="form-control form-control-sm">
                        <option value="">所有</option>
                        <#list users!"" as user>
                            <option value="${user.id}">${user.userName}</option>
                        </#list>
                    </select>
                </div>
            </div>
            <div class="col-lg-2 col-12 mb-5">
                <input type="hidden" value="${type}" id="type">
                <div class="button-group">
                    <button class="button button-sm button-primary" style="height: 36px;" onclick="queryOrderByParams()">搜索</button>
                    <button class="button button-sm button-dark" style="height: 36px;" onclick="resetSearchOrder()">重置</button>
                </div>
            </div>
            <style onload="initOrderHistory()"></style>
        </div>
        <div class="row">
            <div class="col-12">
                <div id="pagination-container"></div>
            </div>
        </div>
    </div>
    <div class="box-body" id="orderHistoryBody">
<#--        <#list orders as order>-->
<#--            <div class="row mb-10">-->
<#--                <div class="col-12">-->
<#--                    <div class="card">-->
<#--                        <div class="card-header">-->
<#--                            <div class="row">-->
<#--                                <div class="col-4">订单号: <a target="_blank" href="/order/printOrderTicket?orderId=${order.id}">${order.orderNumber}</a></div>-->
<#--                                <div class="col-4">日期:${order.createDate?string('yyyy.MM.dd HH:mm:ss')}</div>-->
<#--                                <div class="col-2" align="right">销售:${order.userName}</div>-->
<#--                            </div>-->
<#--                        </div>-->
<#--                        <#assign total=0>-->
<#--                        <ul class="list-group list-group-flush">-->
<#--                            <#list order.stockOperations as operation>-->
<#--                                <li class="list-group-item ">-->
<#--                                    <div class="row ml-15">-->
<#--                                        <div class="col-5">-->
<#--                                            ${operation.productName}-->
<#--                                        </div>-->
<#--                                        <div class="col-3">-->
<#--                                            ${operation.specificationName}-->
<#--                                        </div>-->
<#--                                        <div class="col-2">-->
<#--                                            ${operation.amount}-->
<#--                                        </div>-->
<#--                                        <div class="col-2">-->
<#--                                            ${operation.dealPrice!operation.price}-->
<#--                                        </div>-->
<#--                                    </div>-->
<#--                                </li>-->
<#--                                <#assign total = total + (operation.amount * operation.dealPrice!operation.price)>-->
<#--                            </#list>-->
<#--                        </ul>-->
<#--                        <div class="card-footer">-->
<#--                            <div class="row">-->
<#--                                <div class="col-5 text-muted">发货:${order.senderAddress.company}-${order.senderAddress.name}</div>-->
<#--                                <div class="col-5 text-muted">收货:${order.receiverAddress.company}-${order.receiverAddress.name}</div>-->
<#--                                <div class="col-2" align="right">合计:${total}</div>-->
<#--                            </div>-->
<#--                        </div>-->
<#--                    </div>-->
<#--                </div>-->
<#--            </div>-->
<#--        </#list>-->

    </div>
</div>
