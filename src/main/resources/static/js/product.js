var detailTree, manageTree

function showAddSpecificationModal(){
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
    if(id !== ''){
        $.each($('#specificationTbody').children('tr'),function (index,item) {
            if($($(item).children('td')[0]).text() === id){
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
    showLoadingDiv()
    var productId = $(e).prev('td').html()
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
    stopLoadingDiv()
}

function deleteProduct(productId,productName) {
    showLoadingDiv()
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
    stopLoadingDiv()
}

function cleanForm() {
    $('form').trigger('reset')
    $("#category option:eq(0)").prop("selected", true);
    $('#specification').children('div .notRequired').remove()
    changeUnit()
}

function initCategoryBox(e,defaultNodeId){
    $.ajax({
        url:"/product/queryCategory",
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
    showLoadingDiv()
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
    stopLoadingDiv()
}

function generateRow(product) {
    return "<tr height=\"41px\" >\n" +
        "     <td hidden>"+product.productId+"</td>\n" +
        "     <td onclick=\"showInfoModal(this)\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"点击查看详情\">"+product.productName+"</td>\n" +
        "     <td class=\"hide-responsive\">"+(product.brand==null?"":product.brand)+"</td>\n" +
        "     <td class=\"hide-responsive\">"+(product.productSerial==null?"":product.productSerial)+"</td>\n" +
        "     <td class=\"hide-responsive\">"+(product.productUnit==null?"":product.productUnit)+"</td>\n" +
        "     <td class=\"hide-responsive\">"+(product.model==null?"":product.model)+"</td>\n" +
        // "    <td class=\"hide-responsive\">"+createDate+"</td>\n" +
        "     <td class=\"hide-responsive\" style=\"padding-bottom: 3px;padding-top:8px\">\n" +
        "    <button class=\"button button-box button-xs button-primary\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"入库\"><i class=\"zmdi zmdi-download\"></i></button>\n" +
        "    <button class=\"button button-box button-xs button-primary\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"出库\" onclick=\"showSpecificationModal('出库','"+product.productId+"','"+product.productName+"')\" ><i class=\"zmdi zmdi-upload\"></i></button>\n" +
        "    </td>" +
        "    <td hidden id='specification-"+product.productId+"'>" +
        " <li>" +
        "     <div>" +
        "           <button class=\"delete\"><i class=\"zmdi zmdi-close-circle-o\"></i></button>" +
        "         <div>" +
                "        <h6 style=\"max-width: 65%;float:left;\">"+product.productName+"</h6>" +
                "      <span style='float: right;max-width: 34%'>"+ "specification" +"<br/>"+ "amount" + "</span>" +
        "         </div>" +
        "     </div>" +
        " </li>" +
        "    </td>" +
        "</tr>"
}

function showSpecificationModal(title,productId,productName){
    showLoadingDiv()
    $.ajax({
        url:'/product/queryProductSpecifications',
        data:{
            'productId':productId
        },
        success:function (data) {
            if(data.code === 200){

                var table = "<h5>"+productName+"</h5><div class='row'><div class='col-lg-12 col-12'><table class='table table-bordered' id='stockTable'>"
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
                table += "</tbody></table></div></div>" +
                    "<div class='row'><div class='col-lg-12 col-12'><div class='button-group'>" +
                    "<button class='button button-primary' onclick=\"addToStockOutList("+productId+",'"+productName+"')\"><span><i class='zmdi zmdi-shopping-cart-add'></i>添加到购物车</span></button>" +
                    "<button class='button button-success' onclick=\"showOrderPage("+productId+")\"><span><i class='zmdi zmdi-check'></i>立即购买</span></button>" +
                    "</div></div></div>"
                $('#exampleModalLongTitle').html(title)
                $('#modalBody').html(table)
                $('#exampleModalLong').modal('show')
            }
        }
    })
    stopLoadingDiv()
}

function showOrderPage(productId) {
    showLoadingDiv()
    if(productId){
        let inputs = $('#stockTable').find('input');
        var selectedItem = []
        $.each(inputs,function (index,item) {
            if(index % 2 + 1 === 1){
                if($(item).is(":checked")){
                    selectedItem.push({'productId':productId,
                        'specificationId':$(item).data('id'),
                        'amount':$(inputs[index+1]).val(),'temp':1})
                }
            }
        })
    }
    $.ajax({
        url:"/order/showOrderPage",
        async:"success",
        data:{
            "stockOperations":JSON.stringify(selectedItem)
        },
        success:function(data){
            if(data.code === 200){
                $('#main').html(data.result)
                $('#main').click()
                $('#exampleModalLong').modal('hide')
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("服务器没有响应")
        }
    })
    stopLoadingDiv()
}

function addToStockOutList(productId,productName) {
    showLoadingDiv()
    let inputs = $('#stockTable').find('input');
    var selectedItem = []
    $.each(inputs,function (index,item) {
        if(index % 2 + 1 === 1){
            if($(item).is(":checked")){
                selectedItem.push({productId:productId,productName:productName,specificationId:$(item).data('id'),specificationName:$(item).data('name'),amount:$(inputs[index+1]).val(),temp:0})
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
    stopLoadingDiv()
}

function getCartStuffs() {
    showLoadingDiv()
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
    stopLoadingDiv()
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

function queryByParams(current_page) {
    showLoadingDiv()
    var productName = $('#queryName').val()
    var productSerial = $('#querySerial').val()
    var brand = $('#queryBrand').val()
    var category = manageTree.getSelectedNodes()[0]
    var categoryId = category == null?null:JSON.stringify(category.childIds);

    var pageSize = $('#pageSize').val()
    $.ajax({
        url:'/product/queryByParams',
        data:{
            'pageNum':current_page ,
            'productName':productName,
            'productSerial':productSerial,
            'brand':brand,
            'categoryIdString':categoryId,
            'pageSize':pageSize
        },
        success:function (data) {
            if(data.code === 200){
                $('tbody').children('tr').remove()
                if(data.result['rows']){
                    if(data.result['rows'].length > 0){
                        $.each(data.result['rows'],function (index,product) {
                            $('tbody').append(generateRow(product))
                        })
                    }
                }else{
                    $('tbody').append("<tr><span style='font-size: large'>没有相关的数据!</span></tr>")
                }
                var paginatiorHtml = "<div class=\"pagination\">\n" +
                    "       <a href=\"#\" class=\"first\" data-action=\"first\">&laquo;</a>\n" +
                    "       <a href=\"#\" class=\"previous\" data-action=\"previous\">&lsaquo;</a>\n" +
                    "       <input id=\"paginationText\" type=\"text\" readonly=\"readonly\" data-max-page=\"40\" />\n" +
                    "       <a href=\"#\" class=\"next\" data-action=\"next\">&rsaquo;</a>\n" +
                    "       <a href=\"#\" class=\"last\" data-action=\"last\">&raquo;</a>\n" +
                    "  </div>"
                $('#paginationContainer').html(paginatiorHtml)
                $('.pagination').jqPagination({
                    current_page:current_page,
                    max_page:data.result['pageNum'],
                    page_string: '第{current_page} / {max_page}页',
                    paged: function(page) {
                        queryByParams(page)
                    },
                });
                var pageNum = data.result['pageNum']
                return pageNum
            }
        }
    })
    stopLoadingDiv()
}

function initCategoryBoxSetDefault(id){
    initCategoryBox("#treeDetail",id)
}

function initProductManage(){
    initCategoryBox("#tree")
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
