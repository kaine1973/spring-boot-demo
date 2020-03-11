function appendSpecification(){
    var specificationHtml = "<li class=\"list-group-item col-lg-10 col-12 notRequired\">\n" +
    "   <div class=\"row\">\n" +
    "       <div class=\"col-sm-3 col-12 mb-0\"><input class=\"form-control form-control-sm\" type=\"text\" placeholder=\"规格\" name=\"specificationName\"></div>\n" +
    "       <div class=\"col-sm-3 col-12 mb-0\"><input class=\"form-control form-control-sm\" type=\"number\" step=\"any\" placeholder=\"价格\" name=\"price\"></div>\n" +
    "       <div class=\"col-sm-4 col-12 mb-0 mr-0 input-group\" style=\"height: 36px\">\n" +
    "           <input class=\"form-control\" type=\"number\" step=\"any\" placeholder=\"数量\" name=\"amount\" style=\"height: 36px\">\n" +
    "           <div class=\"input-group-append\" style=\"height: 36px\">\n" +
    "               <span class=\"input-group-text\" id=\"unitSpan\"></span>\n" +
    "           </div>\n" +
    "       </div>\n" +
    "       <div class=\"col-sm-1 col-12 ml-0 mb-0\"><button class='button button-box button-sm button-danger' style='margin-top: 3px' onclick='removeSpecification(this)'><i class='zmdi zmdi-minus-circle'></i>删除</button></div>" +
    "   </div>\n" +
    "</li>"

    $('#specification').append(specificationHtml)

    changeUnit()
    // $('#specification').children('div.selfhide').show('300')
}

function removeSpecification(button) {
    $(button).parent().parent().parent('li.list-group-item').fadeOut('300',function () {
        $(button).parent().parent().parent('li.list-group-item').remove()
    })
}

function changeUnit() {
    var unit = $('#productUnit').val()
    if(unit !== ""|| null !== unit){
        $('span#unitSpan').text(unit)
    }
}

function cleanForm() {
    $('form').trigger('reset')
    $("#category option:eq(0)").prop("selected", true);
    $('#specification').children('li.notRequired').remove()
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