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
                $('#showModalButton').click()
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("请求服务器失败，请重试，或者联系管理员。")
        }
    })
}

function cleanForm() {
    $('form').trigger('reset')
    $("#category option:eq(0)").prop("selected", true);
    $('#specification').children('div .notRequired').remove()
    changeUnit()
}

function submitProductData(){

    var productId = $('#id').val()
    var productName = $('#productName').val()
    var brand = $('#brand').val()
    var productSerial = $('#productSerial').val()
    var model = $('#model').val()
    var productUnit = $('#productUnit').val()
    var category = $('#category').val()
    var specificationNames = generateValArrayFromInputArray($("input[name='specificationName']"))
    var prices = generateValArrayFromInputArray($("input[name='price']"))
    var amounts = generateValArrayFromInputArray($("input[name='amount']"))

    $.ajax({
        url:'/product/insertOrUpdate',
        type:'get',
        data:{
            'productId':productId,
            'productName':productName,
            'brand':brand,
            'productSerial':productSerial,
            'model':model,
            'productUnit':productUnit,
            'category':category,
            'specificationNames':specificationNames,
            'prices':prices,
            'amounts':amounts
        },
        traditional:true,
        success:function (data) {
            if(data.code === 200){
                alertSuccess(data.msg)
                cleanForm()
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("服务器未响应，请重试，或者联系管理员")
        }
    })
}

function generateValArrayFromInputArray(inputArray) {
    var data = "";
    var a=0
    inputArray.each(
        function () {
            if(a===0){
                data = $(this).val()
            }else{
                data += "," + $(this).val()
            }
            a+=1;
        }
    )
    return data
}
