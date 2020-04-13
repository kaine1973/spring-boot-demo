var detailTree, manageTree

function appendSpecification(){
    var specificationHtml = "<div class=\"row notRequired mt-5\">\n" +
        "                                <div class=\"col-12\">\n" +
        "                                    <div class=\"input-group\" style=\"height: 36px\">\n" +
        "                                        <input class=\"form-control form-control-sm\" type=\"text\" placeholder=\"规格*\" name=\"specificationName\"  style=\"height: 36px\">\n" +
        "                                        <input class=\"form-control form-control-sm\" type=\"number\" step=\"any\" placeholder=\"价格*\" name=\"price\"  style=\"height: 36px\">\n" +
        "                                        <input class=\"form-control\" type=\"number\" step=\"any\" placeholder=\"数量\" name=\"amount\" style=\"height: 36px;font-size: 13px\">\n" +
        "                                        <div class=\"input-group-append\" style=\"height: 36px\">\n" +
        "                                            <span class=\"input-group-text\" id=\"unitSpan\" style=\"font-size: 13px\"></span>\n" +
        "                                        </div>\n" +
        "                                        <button class='button button-box button-sm button-danger' style='height:36px;' onclick='removeSpecification(this)'>\n" +
        "                                            <i class='zmdi zmdi-minus-circle'></i>\n" +
        "                                        </button>\n" +
        "                                    </div>\n" +
        "                                </div>\n" +
        "                            </div>"

    $('#specification').append(specificationHtml);

    changeUnit()
    // $('#specification').children('div.selfhide').show('300')
}
function removeSpecification(button) {
    $(button).parent().parent().parent().fadeOut('300',function () {
        $(button).parent().parent().parent().remove()
    })
}
function changeUnit() {
    var unit = $('#productUnit').val()
    if(unit !== ""|| null !== unit){
        $('span#unitSpan').text(unit)
    }
}
function showInfoModal(e) {
    var productId = $(e).prev('td').html()
    $.ajax({
        url:"/product/getProductPage",
        data:{
            "productId":productId
        },
        success:function (data) {
            if(data.code === 200){
                $('#modalBody').html(data.result)
                $('select').niceSelect();
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

    var productId = $('#productId').val()
    var productName = $('#productName').val()
    var brand = $('#brand').val()
    var productSerial = $('#productSerial').val()
    var model = $('#model').val()
    var productUnit = $('#productUnit').val()
    var category = detailTree.getSelectedNodes()[0]
    var categoryId = category == null?null:JSON.stringify(category.id);

    var specifications = generateValArrayFromInputArray()
    console.log(productId)
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

function generateRow(product) {
    console.log(product.specifications)
    return "<tr height=\"41px\" >\n" +
        "                            <td hidden>"+product.productId+"</td>\n" +
        "                            <td onclick=\"showInfoModal(this)\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"点击查看详情\">"+product.productName+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+(product.brand==null?"":product.brand)+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+(product.productSerial==null?"":product.productSerial)+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+(product.productUnit==null?"":product.productUnit)+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+(product.model==null?"":product.model)+"</td>\n" +
        // "                            <td class=\"hide-responsive\">"+createDate+"</td>\n" +
        "                            <td class=\"hide-responsive\" style=\"padding-bottom: 3px;padding-top:8px\">\n" +
        "                                    <button class=\"button button-box button-xs button-primary\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"入库\"><i class=\"zmdi zmdi-download\"></i></button>\n" +
        "                                    <button class=\"button button-box button-xs button-primary\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"出库\" onclick=\"showSpecificationModal('出库','"+product.productId+"','"+product.productName+"')\" ><i class=\"zmdi zmdi-upload\"></i></button>\n" +
        "                            </td>" +
        "                            <td hidden id='specification-"+product.productId+"'>" +
        "                                   <li>" +
        "                                       <div>" +
        "                                           <button class=\"delete\"><i class=\"zmdi zmdi-close-circle-o\"></i></button>" +
        "                                           <div>" +
                "                                        <h6 style=\"max-width: 65%;float:left;\">"+product.productName+"</h6>" +
                "                                        <span style='float: right;max-width: 34%'>"+ "specification" +"<br/>"+ "amount" + "</span>" +
        "                                           </div>" +
        "                                       </div>" +
        "                                   </li>" +
        "                            </td>" +
        "</tr>"
}

function showSpecificationModal(title,productId,productName){
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
                    "<button class='button button-success' onclick=\"showOrderPage("+productId+",'"+productName+"')\"><span><i class='zmdi zmdi-check'></i>立即购买</span></button>" +
                    "</div></div></div>"
                $('#exampleModalLongTitle').html(title)
                $('#modalBody').html(table)
                $('#exampleModalLong').modal('show')
            }
        }
    })
}

function showOrderPage(productId,productName) {

    let inputs = $('#stockTable').find('input');
    var selectedItem = []
    $.each(inputs,function (index,item) {
        if(index % 2 + 1 === 1){
            if($(item).is(":checked")){
                selectedItem.push({productId:productId,productName:productName,specificationId:$(item).data('id'),specificationName:$(item).data('name'),amount:$(inputs[index+1]).val()})
            }
        }
    })
    $.ajax({
        url:"/stock/showOrderPage",
        data:{
            "stockOperations":JSON.stringify(selectedItem)
        },
        success:function(data){
            if(data.code === 200){
                $('#exampleModalLongTitle').html("订单")
                $('#modalBody').html(data.result)
                $('#exampleModalLong').modal('show')
            }
        }
    })
}

function addToStockOutList(productId,productName) {

    let inputs = $('#stockTable').find('input');
    var selectedItem = []
    $.each(inputs,function (index,item) {
        if(index % 2 + 1 === 1){
            if($(item).is(":checked")){
                selectedItem.push({productId:productId,productName:productName,specificationId:$(item).data('id'),specificationName:$(item).data('name'),amount:$(inputs[index+1]).val()})
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
function queryByParams(current_page) {
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
                console.log(current_page)
                var paginatiorHtml = "<div class=\"pagination\">\n" +
                    "                <a href=\"#\" class=\"first\" data-action=\"first\">&laquo;</a>\n" +
                    "                <a href=\"#\" class=\"previous\" data-action=\"previous\">&lsaquo;</a>\n" +
                    "                <input id=\"paginationText\" type=\"text\" readonly=\"readonly\" data-max-page=\"40\" />\n" +
                    "                <a href=\"#\" class=\"next\" data-action=\"next\">&rsaquo;</a>\n" +
                    "                <a href=\"#\" class=\"last\" data-action=\"last\">&raquo;</a>\n" +
                    "            </div>"
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
// function productSpecification(specificationName,price,amount) {
//     this.specificationName = specificationName
//     this.price = price
//     this.amount = amount
// }
function generateValArrayFromInputArray() {
    var specificationNames = $("input[name='specificationName']")
    var prices = $("input[name='price']")
    var amounts = $("input[name='amount']")

    var data = []

    for(var i = 0;i<specificationNames.length;i++){
        var productSpecification = {}
        productSpecification.specificationName = specificationNames[i].value
        productSpecification.price = prices[i].value
        productSpecification.amount = amounts[i].value
        data[i] = productSpecification
        // data[i] = '{specificationName:'+specificationNames[i].value+',price:'+prices[i].value+',amount:'+amounts[i].value+'}'
    }
    // data = data.substring(0,data.length-1) + ']'
    return data
}

function openUl(e) {
    $(e).next('ul').toggle()
}
