var detailTree, manageTree
var editSpecificationRow = -1
function showAddSpecificationModal(){
    editSpecificationRow = -1
    $('#specificationId').val('')
    $('#specificationName').val('')
    $('#specificationPrice').val('')
    $('#specificationAmount').val('')
    $('#specificationModal').modal('show');
}

function addSpecificationRow(){
    var id = $('#specificationId').val()
    var name = $('#specificationName').val()
    var price = $('#specificationPrice').val()
    var amount = $('#specificationAmount').val()
    if(editSpecificationRow >= 0){
        $.each($('#specificationTbody').children('tr'),function (index,item) {
            if(index === editSpecificationRow){
                $($(item).children('td')[1]).text(name);
                $($(item).children('td')[2]).text(price);
                $($(item).children('td')[3]).text(amount);
                $($(item).children('td')[4]).text(1);
            }
        })
    }else{
        $('#specificationTbody').append('<tr>' +
            '<td hidden>'+id+'</td>' +
            '<td>'+ name +'</td>' +
            '<td>'+ price +'</td>' +
            '<td>'+ amount +'</td>' +
            '<td hidden>'+ 1 +'</td>' +
            '<td width="100px"><button class="button button-xs button-warning" style="height: 25px" onclick="deleteSpecification(this)">删除</button>' +
            '<button class="button button-xs button-primary" style="height: 25px" onclick="editSpecification(this)">编辑</button></td>' +
            '</tr>')
    }

    $('#specificationModal').modal('hide');
}

function deleteSpecification(e) {
    var tds = $(e).parent().siblings('td')
    $(tds[4]).text(0)
    $(e).parent().parent().hide()
}
function editSpecification(e){
    showAddSpecificationModal()
    var tds = $(e).parent().siblings('td')
    var id = $(tds[0]).text()
    var name = $(tds[1]).text()
    var price = $(tds[2]).text()
    var amount = $(tds[3]).text()
    editSpecificationRow = $(e).parent().parent().index()
    $('#specificationId').val(id)
    $('#specificationName').val(name)
    $('#specificationPrice').val(price)
    $('#specificationAmount').val(amount)
}

function changeUnit() {
    var unit = $('#productUnit').val()
    if(unit !== ""|| null !== unit){
        $('span#unitSpan').text(unit)
    }
}

function showInfoModal(e) {
    var productId = $(e).parent('tr').children('td')[0].innerHTML
    $.ajax({
        url:"/product/getProductPage",
        data:{
            "productId":productId
        },
        success:function (data) {
            if(data.code === 200){
                $('#modalBody').html(data.result)
                $('#exampleModalLongTitle').html("商品信息")
                $('#exampleModalLong').modal('show')
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("请求服务器失败，请重试，或者联系管理员。")
        }
    })
}

function deleteProduct(productId,productName) {
    if(confirm('确认删除：'+productName)){
        $.ajax({
            url:'/product/delete',
            data:{
                'productId':productId
            },
            success:function (data) {
                if(data.code === 200){
                    alertSuccess("删除成功")
                    $('#exampleModalLong').modal('hide')
                    queryByParams()
                }else{
                    alertWarning(data.msg)
                }
            },
            error:function(){
                alertWarning("服务器未成功响应")
            }
        })
    }
}

function cleanForm() {
    $('form').trigger('reset')
    $("#category option:eq(0)").prop("selected", true);
    $('#specification').children('div .notRequired').remove()
    changeUnit()
}

function initCategoryBox(e,defaultNodeId){
    $.ajax({
        url:"/category/queryAll",
        success:function (data) {
            if(data.code === 200){
                var zTreeNodes = JSON.parse(data.result);
                var setting = {
                    view: {
                        selectedMulti: false
                    }
                };
                if(e === "#tree"){
                    $.fn.zTree.init($(e), setting, zTreeNodes);
                    manageTree = $.fn.zTree.getZTreeObj('tree')
                    queryByParams()
                    // console.log(manageTree)
                }else if(e === "#treeDetail"){
                    $.fn.zTree.init($(e), setting, zTreeNodes);
                    detailTree = $.fn.zTree.getZTreeObj('treeDetail')
                    var nodes = detailTree.transformToArray(detailTree.getNodes());
                    $(nodes).each(function (i,node){
                        if(node.id == defaultNodeId){
                            detailTree.expandNode(node, true, true, true);
                            detailTree.selectNode(node, true, true);
                            detailTree.updateNode(node)
                        }
                    })
                }
            }else{
                alertWarning(data.msg)
                return false
            }
        },
        error:function () {
            alertWarning("连接服务器失败，请刷新页面重试")
            return false
        }
    });
}

function submitProductData(){
    var productId = $('#productId').val()
    var productName = $('#productName').val()
    var brand = $('#brand').val()
    var productSerial = $('#productSerial').val()
    var model = $('#model').val()
    var productUnit = $('#productUnit').val()
    var category = detailTree.getSelectedNodes()[0]
    var categoryId = category == null?null:JSON.stringify(category.id);

    var specifications = generateValArrayFromInputArray()
    $.ajax({
        url:'/product/insertOrUpdate',
        type:'get',
        contentType:'application/json;charset=utf-8',
        data:{
            'productId':productId,
            'productName':productName,
            'brand':brand,
            'productSerial':productSerial,
            'model':model,
            'productUnit':productUnit,
            'categoryId':categoryId,
            'specifications':JSON.stringify(specifications)
        },
        traditional:true,
        success:function (data) {
            if(data.code === 200){
                alertSuccess(data.msg)
                cleanForm()
                $('#exampleModalLong').modal('hide')
                queryByParams()
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("服务器未响应，请重试，或者联系管理员")
        }
    })
}

function generateRow(products) {
    var html =""
    $.each(products,function (index,product) {
        html += "<tr height=\"41px\" >\n" +
            "     <td hidden>"+product.productId+"</td>\n" +
            "     <td class=\"hide-responsive\">"+(product.brand==null?"":product.brand)+"</td>\n" +
            "     <td><a href='/product/getProductPage?productId="+product.productId+"' target='_blank'>"+product.productName+"</a></td>\n" +
            "     <td class=\"hide-responsive\">"+(product.productSerial==null?"":product.productSerial)+"</td>\n" +
            "     <td class=\"hide-responsive\">"+(product.productUnit==null?"":product.productUnit)+"</td>\n" +
            "     <td class=\"hide-responsive\">"+(product.model==null?"":product.model)+"</td>\n" +
            "    <td class=\"hide-responsive\">"+product.createDate+"</td>\n" +
            "     <td class=\"hide-responsive\" style=\"padding-bottom: 3px;padding-top:8px\">\n" +
            "    <button style='height: 26px' class=\"button button-xs button-primary\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"入库\" onclick=\"showSpecificationModal('入库','"+product.productId+"','"+product.productName+"')\">入库</button>\n" +
            "    <button style='height: 26px' class=\"button button-xs button-primary\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"出库\" onclick=\"showSpecificationModal('出库','"+product.productId+"','"+product.productName+"')\" >出库</button>\n" +
            "    </td>" +
            "</tr>"
    })
    return html
}

function showSpecificationModal(title,productId,productName){
    $.ajax({
        url:'/product/queryProductSpecifications',
        data:{
            'productId':productId
        },
        success:function (data) {
            if(data.code === 200){

                var button = "<button class='button button-primary' onclick=\"addToStockOutList("+productId+",'"+productName+"','STOCK_OUT')\"><span><i class='zmdi zmdi-shopping-cart-add'></i>添加到购物车</span></button>" +
                    "<button class='button button-success' onclick=\"buyNow("+productId+")\"><span><i class='zmdi zmdi-check'></i>立即购买</span></button>"
                if('入库'===title){
                    button = "<button class='button button-primary' onclick=\"addToStockOutList("+productId+",'"+productName+"','STOCK_IN')\"><span><i class='zmdi zmdi-check'></i>确认</span></button>"
                }
                var table = "<div class='box'><div class='box-head'><h5>"+productName+"</h5></div><div class='box-body'><table class='table table-bordered' id='stockTable'>"
                    table += "<thead><tr><th>选择</th><th>规格</th><th>单价</th><th>库存</th><th>数量</th></tr></thead><tbody>"
                $.each(data.result,function (i,item) {
                    table += "<tr>"
                    table += "<td><input class='form-control' data-id='"+item.id+"' data-name='"+item.specificationName+"' type='checkbox'></td>"
                    table += "<td>"+item.specificationName+"</td>"
                    table += "<td>"+item.price+"</td>"
                    table += "<td>"+item.amount+"</td>"
                    table += "<td><input class='form-control' style='height:31px' type='number'></td>"
                    table += "</tr>"
                })
                table += "</tbody></table></div><div class='box-foot'>" +
                    "<div class='button-group'>" +
                    button+
                    "</div></div></div>"
                $('#exampleModalLongTitle').html(title)
                $('#modalBody').html(table)
                $('#exampleModalLong').modal('show')
            }
        }
    })
}

function buyNow(productId) {
    let inputs = $('#stockTable').find('input');
    var selectedItem = []
    $.each(inputs,function (index,item) {
        if(index % 2 + 1 === 1){
            if($(item).is(":checked")){
                selectedItem.push({'productId':productId,'operation':'STOCK_OUT',
                    'specificationId':$(item).data('id'),
                    'amount':$(inputs[index+1]).val(),'temp':1})
            }
        }
    })
    $.ajax({
        url:"/order/addTempStockOut",
        async:"success",
        data:{
            "stockOperations":JSON.stringify(selectedItem)
        },
        success:function(data){
            if(data.code === 200){
                window.open('/order/showOrderPage?temp=1','_blank')
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("服务器没有响应")
        }
    })
}

function addToStockOutList(productId,productName,type) {
    let inputs = $('#stockTable').find('input');
    var selectedItem = []
    $.each(inputs,function (index,item) {
        if(index % 2 + 1 === 1){
            if($(item).is(":checked")){
                selectedItem.push({productId:productId,productName:productName,specificationId:$(item).data('id'),specificationName:$(item).data('name'),amount:$(inputs[index+1]).val(),temp:0,operation:type})
            }
        }
    })
    $.ajax({
        url:"/stock/insertStockOperation",
        data:{"stockOperations":JSON.stringify(selectedItem)},
        success:function (data) {
            if(data.code === 200){
                alertSuccess(data.msg)
                $('#exampleModalLong').modal('hide')
            }else{
                alertWarning(data.msg)
            }
        }
    })
}

function getCartStuffs() {
    $.ajax({
        url:"/stock/queryUnconfirmedStockOperationOfSTOCK_OUT",
        async:"success",
        success:function(data){
            if(data.code === 200){
                var cartContent = "";
                $.each(data.result,function (index,item) {
                    cartContent += "<li>\n" +
                                    "<a href=\"#\">\n" +
                                    "<div class=\"image\"><img src=\"images/avatar/avatar-1.jpg\" alt=\"\"></div>\n" +
                                    "<div class=\"content\">\n" +
                                    "    <h6>"+item.productName+"</h6>\n" +
                                    "    <p>规格: "+item.specificationName+" , 数量: "+item.amount+"</p>\n" +
                                    "</div>\n" +
                                    "<span class=\"reply\" onclick='deleteStockOperation("+item.id+",this)'><i class=\"zmdi zmdi-delete\"></i></span>\n" +
                                    "     </a>\n" +
                                    "</li>"
                })
                $('#cart-count').html(data.result.length)
                $('#stockOutList').html(cartContent)
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("server error")
        }
    })
}

function deleteStockOperation(operationId,e) {
    if(confirm("确定要删除？")){
        showLoadingDiv()
        $.ajax({
            url:"/stock/deleteStockOperation",
            data:{
                "operationId":operationId
            },
            success:function (data){
                if(data.code === 200){
                    alertSuccess(data.msg)
                    $('#stockOperation_'+operationId).remove()
                    $(e).parent().remove()
                    $('#cart-count').html(parseInt($('#cart-count').html())-1)
                }else{
                    alertWarning(data.msg)
                }
            },
            error:function(){
                alertWarning("服务器未能成功响应")
            }
        })
        stopLoadingDiv()
    }
}

function queryByParams() {
    var productName = $('#queryName').val()
    var productSerial = $('#querySerial').val()
    var brand = $('#queryBrand').val()
    var category = manageTree.getSelectedNodes()[0]
    var categoryId = category == null?null:JSON.stringify(category.childIds);

    $('#paginationContainer').pagination({
        dataSource: '/product/queryByParams',
        locator: 'result.list',
        totalNumberLocator: function(response) {
            return response.result.pageSize * response.result.pages
        },
        pageSize: 10,
        pageRange: 6,
        alias: {
            pageNumber: 'pageNum'
        },
        ajax: {
            data:{
                "productName":productName,
                "productSerial":productSerial,
                "brand":brand,
                "categoryIdString":categoryId
            },
            beforeSend: function() {
                $('#productBody').html('加载数据中 ...');
            }
        },
        callback: function(data, pagination) {
            // template method of yourself
            var html = generateRow(data);
            $('#productBody').html(html);
        }
    })
}

function resetThenQuery() {
    $('#search').trigger('reset');
    manageTree.cancelSelectedNode()
    manageTree.expandAll(false)
    queryByParams()
}

function generateValArrayFromInputArray() {

    var data = []
    $.each($('#specificationTbody').children('tr'),function (index,item) {
        var productSpecification = {}
        var tds = $(item).children('td')
        productSpecification.id = $(tds[0]).text()
        productSpecification.specificationName = $(tds[1]).text()
        productSpecification.price = $(tds[2]).text()
        productSpecification.amount = $(tds[3]).text()
        productSpecification.isValid = $(tds[4]).text()
        data[index] = productSpecification
    })
    // data = data.substring(0,data.length-1) + ']'
    return data
}
