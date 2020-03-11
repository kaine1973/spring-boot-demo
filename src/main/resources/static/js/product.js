function appendSpecification(){
    var specificationHtml = "<div class=\"hide row\">\n" +
    "<div class=\"col-sm-3 col-12 mb-10\"><input class=\"form-control form-control-sm\" type=\"text\" placeholder=\"规格\" name=\"catogery\"></div>\n" +
    "<div class=\"col-sm-3 col-12 mb-10\"><input class=\"form-control form-control-sm\" type=\"number\" step=\"any\" placeholder=\"价格\" name=\"productId\"></div>\n" +
    "<div class=\"col-sm-3 col-12 mb-10 input-group\" style=\"height: 36px\">\n" +
    "    <input class=\"form-control\" type=\"number\" step=\"any\" placeholder=\"现有库存\" name=\"brand\" style=\"height: 36px\">\n" +
    "    <div class=\"input-group-append\" style=\"height: 36px\">\n" +
    "        <span class=\"input-group-text\" id=\"unitSpan\">G</span>\n" +
    "    </div>\n" +
    "</div>\n" +
    "<button class='button button-box button-sm button-danger' onclick='removeSpecification(this)' style='margin-top: 3px'><i class='zmdi zmdi-minus-circle'></i></button>" +
    "</div>"

    $('#specification').append(specificationHtml)
    $('#specification').children('div.hide').show('300')
}

function changeUnit() {
    var unit = $('#unit').val()
    $('span#unitSpan').text(unit)
}

function removeSpecification(button) {
    $(button).parent('div.row').fadeOut('300',function () {
        $(button).parent('div.row').remove()
    })
}