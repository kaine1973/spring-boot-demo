function getChildArea(e) {
    var parentId = $(e).val();
    var nextSelect = $(e).parent().next().children('select')[0]
    console.log(parentId)
    if(isNaN(parentId)){
        alertWarning("不能选择该项")
        return;
    }
    $.ajax({
        url:"/common/queryAreaByParentId",
        type:"get",
        data:{
            "parentId":parentId
        },
        success:function (data) {
            if(data.code === 200){
                $(nextSelect).children(".marker").remove()
                // $(nextNode).next("select").children(".marker").remove()
                var nodes = data.result
                for(var i = 0;i<nodes.length;i++){
                    // console.log(nodes[i])
                    $(nextSelect).append("<option class='marker' value="+nodes[i]['id']+">"+nodes[i]['areaName']+"</option>")
                }
                $(".nice-select").niceSelect("update")
            }
        },
        error:function () {
            alertWarning("获取地区子节点失败！")
        }
    })
}

function loadCustomerPosition() {

}


function queryCustomerByParams(current_page) {
    showLoadingDiv()
    var queryName = $('#queryName').val()
    var queryCompany = $('#queryCompany').val()
    var queryLevel = $('#queryLevel').val()

    var pageSize = $('#pageSize').val()
    $.ajax({
        url:'/customer/queryByParams',
        data:{
            'pageNum':current_page ,
            'queryName':queryName,
            'queryCompany':queryCompany,
            'queryLevel':queryLevel,
            'pageSize':pageSize
        },
        success:function (data) {
            if(data.code === 200){
                $('tbody').children('tr').remove()
                if(data.result['rows']){
                    if(data.result['rows'].length > 0){
                        $.each(data.result['rows'],function (index,customer) {
                            $('tbody').append(generateCustomerRow(customer))
                        })
                    }
                }else{
                    $('tbody').append("<tr><span style='font-size: large'>没有相关的数据!</span></tr>")
                }
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
                        queryCustomerByParams(page)
                    },
                });
                return data.result['pageNum']
            }
        }
    })
    stopLoadingDiv()
}
function generateCustomerRow(customer) {
    return "<tr height=\"41px\" >\n" +
        "                            <td hidden>"+customer.id+"</td>\n" +
        "                            <td onclick=\"\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"点击查看详情\">"+customer.customerName+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+(customer.company==null?"":customer.company)+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+(customer.customerId==null?"":customer.customerId)+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+(customer.levelSign==null?"":customer.levelSign)+"</td>\n" +
        "                            <td class=\"hide-responsive\">"+(customer.phone==null?"":customer.phone)+"</td>\n" +
        // "                            <td class=\"hide-responsive\">"+createDate+"</td>\n" +
        "                            <td class=\"hide-responsive\" style=\"padding-bottom: 3px;padding-top:8px\">\n" +
        "                                    <button class=\"button button-box button-xs button-primary\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"入库\"><i class=\"zmdi zmdi-download\"></i></button>\n" +
        "                                    <button class=\"button button-box button-xs button-primary\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"出库\" onclick=\"showSpecificationModal('出库','"+customer.id+"','"+customer.customerName+"')\" ><i class=\"zmdi zmdi-upload\"></i></button>\n" +
        "                            </td>" +
        // "                            <td hidden id='specification-"+customer.id+"'>" +
        // "                                   <li>" +
        // "                                       <div>" +
        // "                                           <button class=\"delete\"><i class=\"zmdi zmdi-close-circle-o\"></i></button>" +
        // "                                           <div>" +
        // "                                        <h6 style=\"max-width: 65%;float:left;\">"+customer.productName+"</h6>" +
        // "                                        <span style='float: right;max-width: 34%'>"+ "specification" +"<br/>"+ "amount" + "</span>" +
        // "                                           </div>" +
        // "                                       </div>" +
        // "                                   </li>" +
        // "                            </td>" +
        "</tr>"
}
function customerManageInit(){
    queryCustomerByParams()
}

function uploadCustomerDetail(e) {
    var id = $('#id').val()
    var customerName = $('#customerName').val()
    var company = $('#company').val()
    var positionId = $('#position').val()
    var gender = $('#gender').val()
    var phone = $('#phone').val()
    var customerId = $('#customerId').val()
    var levelId = $('#level').val()
    var note = $('#note').val()

    var districtId = $('#district :selected').val()
    var detail = $('#addressDetail').val()

    var addresses = []
    addresses.push({"name":customerName,
        "company":company,
        "phone":phone,
        "districtId":districtId,
        "detail":detail})

    $.each($('#addressTableBody').children('tr'),function (index,item) {
        var tds = $(item).children('td')
        addresses.push({"name":$(tds[0]).text(),
            "company":$(tds[1]).text(),
            "phone":$(tds[2]).text(),
            "districtId":$(tds[7]).text(),
            "detail":$(tds[9]).text()})
    })

    if(isEmpty(customerName)||isNaN(positionId) || isNaN(gender) || isNaN(parseInt(districtId))){
        alertWarning("带*的是必填项")
        return
    }

    $.ajax({
        url:"/customer/uploadCustomerDetail",
        data:{
            "id":id,
            "customerName":customerName,
            "company":company,
            "positionId":positionId,
            "gender":gender,
            "phone":phone,
            "customerId":customerId,
            "levelId":levelId,
            "note":note,
            "addressesString":JSON.stringify(addresses)
        },
        success:function (data) {
            if(data.code === 200){
                alertSuccess(data.msg)
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("请求服务器失败，请重试，或者联系管理员。")
        }
    })
    setTimeout(function () {
        $(e).removeClass("disabled")
    },3000)

}