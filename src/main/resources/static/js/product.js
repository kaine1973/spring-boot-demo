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
    var productId = $(e).children('td').html()
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
                    queryByParams(0)
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

function submitProductData(){

    var productId = $('#productId').val()
    var productName = $('#productName').val()
    var brand = $('#brand').val()
    var productSerial = $('#productSerial').val()
    var model = $('#model').val()
    var productUnit = $('#productUnit').val()
    var category = $('#category').val()
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
            'categoryId':category,
            'specifications':JSON.stringify(specifications)
        },
        traditional:true,
        success:function (data) {
            if(data.code === 200){
                alertSuccess(data.msg)
                cleanForm()
                $('#exampleModalLong').modal('hide')
                queryByParams(0)
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("服务器未响应，请重试，或者联系管理员")
        }
    })
}

function generateRow(id,productName,brand,productSerial,productUnit,model,createDate) {

    return "<tr height=\"41px\" onclick=\"showInfoModal(this)\">\n" +
        "                            <td hidden>"+id+"</td>\n" +
        "                            <td>"+productName+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+brand+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+productSerial+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+productUnit+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+model+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+createDate+"</td>\n" +
        "                            <td class=\"hide-responsive\" style=\"padding-bottom: 3px;padding-top:8px\">\n" +
        "\n" +
        "                                    <button class=\"button button-box button-xs button-primary\" ><i class=\"zmdi zmdi-download\"></i></button>\n" +
        "                                    <button class=\"button button-box button-xs button-primary\" onclick=\"showPurposeModal()\" ><i class=\"zmdi zmdi-upload\"></i></button>\n" +
        "\n" +
        "                            </td>" +
        "                        </tr>"
}

function showPurposeModal(){

}

function queryByParams(startPage,selectedCategory=0) {
    var productName = $('#queryName').val()
    var productSerial = $('#querySerial').val()
    var brand = $('#queryBrand').val()
    var category = $.fn.zTree.getZTreeObj("tree").getSelectedNodes()[0]
    var categoryId = category == null?null:JSON.stringify(category.childIds);
    console.log(category)
    console.log(categoryId)
    var pageSize = $('#pageSize').val()
    $.ajax({
        url:'/product/queryByParams',
        data:{
            'startPage':startPage,
            'productName':productName,
            'productSerial':productSerial,
            'brand':brand,
            'categoryIdString':categoryId,
            'pageSize':pageSize
        },
        success:function (data) {
            if(data.code === 200){
                $('tbody').children('tr').remove()
                if(data.result['rows'].length > 0){
                    $.each(data.result['rows'],function (index,product) {
                        $('tbody').append(generateRow(product.productId,product.productName,product.brand,product.productSerial,product.productUnit,product.model,product.createDate))
                    })
                }else{
                    $('tbody').append("<span style='font-size: large'>没有相关的数据!</span>")
                }

            }
        }
    })
}
function initCategoryBox(e){
    $.ajax({
        url:"/product/queryCategory",
        success:function (data) {
            if(data.code === 200){
                console.log(data.result)
                var zTreeNodes = JSON.parse(data.result);
                var setting = {
                    view: {
                        selectedMulti: false
                    }
                };
                $.fn.zTree.init($(e), setting, zTreeNodes);
                queryByParams(0)
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("连接服务器失败，请刷新页面重试")
        }
    });
}
function resetThenQuery() {
    $('#search').trigger('reset');
    let zTreeObj = $.fn.zTree.getZTreeObj('tree');
    zTreeObj.cancelSelectedNode()
    zTreeObj.expandAll(false)
    queryByParams(0)
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
