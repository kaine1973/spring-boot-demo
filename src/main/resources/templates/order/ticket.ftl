<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>order-${order.orderNumber}</title>
    <link rel="stylesheet" href="/css/vendor/bootstrap.min.css">
    <link id="cus-style" rel="stylesheet" href="/css/style-primary.css">

</head>
<style>
    td{
        height:10px
    }
    td strong{
        border-bottom: 1px black solid ;
    }
    #operationTbody tr td{
        border-left:1px black solid;border-right:1px black solid;
    }
    #operationTbody tr:last-child td {
        border-bottom: 1px black solid;
    }
    thead.itemHeader th{
        border:1px #000000 solid;
    }
    #ticket*{
        border-bottom: #000000;
    }
</style>
<body onload="window.print()" style="max-height: 600px;">

<table width="" style="margin: 10px;width:1000px">
    <thead>
        <th width="100px"></th>
        <th colspan="10" style="text-align:center;height:50px">上海英莱盾生物技术有限公司销售出库单</th>
        <th width="100px">${order.createDate?string('yyyy.MM.dd HH:mm:ss')}</th>
    </thead>
    <tbody>
    <tr>
        <td width="100px">收货人</td>
        <td colspan="2" width="250px"><strong id="ticketReceiver">${receiverAddress.name}</strong></td>
        <td width="100px">电话</td>
        <td colspan="2" width="250px"><strong id="ticketReceiverPhone">${receiverAddress.phone}</strong></td>
        <td width="100px">客户订单号</td>
        <td colspan="5" width="400px"><strong id="ticketOrderNumber">${order.orderNumber}</strong></td>
    </tr>
    <tr>
        <td width="100px">客户</td>
        <td colspan="5" width="400px"><strong>${order.customer.company}-${order.customer.customerName}</strong></td>
        <td width="100px">销售</td>
        <td colspan="3" width="400px"><strong id="ticketSender">${senderAddress.name}</strong></td>
    </tr>
    <tr>
    </tr>
    <tr>
        <td width="100px">地址</td>
        <td colspan="5"><strong>${receiverAddress.province}${receiverAddress.city}${receiverAddress.district}${receiverAddress.detail}</strong></td>
        <td colspan="6"><strong>${senderAddress.province}${senderAddress.city}${senderAddress.district}${senderAddress.detail}</strong></td>
    </tr>
    </tbody>


</table>
<table class="" style="width: 1000px;">
    <thead class="itemHeader" height='36px'>
    <th width="40px">序号</th><th width="150px">品牌</th><th>名称</th><th width="100px">货号</th><th width="100px">规格</th><th width="80px">单位</th><th width="80px">数量</th><th width="100px">单价</th><th width="100px">金额</th>
    </thead>
    <tbody id="operationTbody">
    <#assign total=0>
    <#list order.stockOperations as operation>
        <tr><td>${operation?index+1}</td><td>${operation.productBrand!""}</td><td>${operation.productName}</td><td>${operation.productSerial}</td><td>${operation.specificationName}</td><td>${operation.productUnit}</td><td>${operation.amount}</td><td>${operation.dealPrice!operation.price}</td><td>${(operation.dealPrice!operation.price) * operation.amount}<#assign total = total+((operation.dealPrice!operation.price) * operation.amount)></td></tr>
    </#list>
    </tbody>
</table>
<table style="width:1000px">
    <tbody>
        <tr>
            <td align="right"></td>
        </tr>
        <tr>
            <td align="right">签收人:</td>
            <td width="100px" style="border-bottom: 1px black solid"></td>
        </tr>
    </tbody>
</table>


</body>

</html>