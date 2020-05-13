function getChildArea(parent,child,grandchild) {
    var parentId = $(parent).val();
    console.log(parentId)
    if(isNaN(parentId)){
        alertWarning("不能选择该项")
        return;
    }
    $.ajax({
        url:"/common/queryAreaByParentId",
        type:"get",
        async:false,
        data:{
            "parentId":parentId
        },
        success:function (data) {
            if(data.code === 200){
                $(child).children(".marker").remove()
                if(grandchild!==undefined){
                    $(grandchild).children(".marker").remove()
                }
                var nodes = data.result
                for(var i = 0;i<nodes.length;i++){
                    // console.log(nodes[i])
                    $(child).append("<option class='marker' value="+nodes[i]['id']+">"+nodes[i]['areaName']+"</option>")
                }
            }
        },
        error:function () {
            alertWarning("获取地区子节点失败！")
        }
    })
}

function queryCustomerByParams() {
    var queryName = $('#queryName').val()
    var queryCompany = $('#queryCompany').val()
    var queryLevel = $('#queryLevel').val()


    $('#paginationContainer').pagination({
        dataSource: '/customer/queryByParams',
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
                "queryName":queryName,
                "queryCompany":queryCompany,
                "queryLevel":queryLevel,
            },
            beforeSend: function() {
                $('#customerBody').html('加载数据中 ...');
            }
        },
        callback: function(data, pagination) {
            // template method of yourself
            var html = generateCustomerRows(data);
            $('#customerBody').html(html);
        }
    })
}
function generateCustomerRows(customers) {
    var html = ""
    $.each(customers,function (index,customer) {
        html += "<tr height=\"41px\" >\n" +
            "<td data-toggle=\"tooltip\" data-placement=\"top\" title=\"点击查看详情\"><a href='/customer/detail?customerId="+customer.id+"' target='_blank'>"+customer.customerName+"</a></td>\n" +
            "<td class=\"hide-responsive\">"+(customer.company==null?"":customer.company)+"</td>\n" +
            "<td class=\"hide-responsive\">"+(customer.customerId==null?"":customer.customerId)+"</td>\n" +
            "<td class=\"hide-responsive\">"+(customer.levelSign==null?"":customer.levelSign)+"</td>\n" +
            "<td class=\"hide-responsive\">"+(customer.phone==null?"":customer.phone)+"</td>\n" +
            "<td class=\"hide-responsive\" style=\"padding-bottom: 3px;padding-top:8px\">\n" +
            (customer.gender === 0?'男':customer.gender === 1?'女':"")+
            "</td>"+
            "</tr>"
    })
    return html
}
function customerManageInit(){
    queryCustomerByParams()
}
function uploadCustomerDetail(e) {

    $.each($('#customerForm input,select').filter('[required]:visible'),function (index,item) {
        if($(item).val() === undefined || $(item).val().trim() === ''){
            alertWarning($('label[for="' + $(item).attr('id') + '"]')+"不能为空")
            return
        }
    })
    var id = $('#id').val()
    var customerName = $('#customerName').val()
    var company = $('#company').val()
    var positionId = $('#position').val()
    var gender = $('#gender').val()
    var phone = $('#phone').val()
    var addressId = $('#addressId').val()
    var customerId = $('#customerId').val()
    var levelId = $('#level').val()
    var note = $('#note').val()
    var districtId = $('#district :selected').val()
    var detail = $('#addressDetail').val()

    var addresses = []
    addresses.push({"id":addressId,
        "name":customerName,
        "company":company,
        "phone":phone,
        "districtId":districtId,
        "detail":detail,
        "primary":1})

    $.each($('#addressTableBody').children('tr'),function (index,item) {
        var tds = $(item).children('td')
        var address = $(tds[5]).html()
        addresses.push({
            "id":$(tds[0]).text(),
            "name":$(tds[1]).text(),
            "company":$(tds[2]).text(),
            "phone":$(tds[3]).text(),
            "districtId":$(tds[4]).html().split('-')[2],
            "isValid":$(tds[6]).text(),
            "detail":address.split('&nbsp;')[3],"primary":0})
    })
    $.ajax({
        url:"/customer/uploadCustomerDetail",
        async:false,
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
function deleteCustomerAddress(e) {
    var tds = $(e).parent().parent().parent().children('td')
    if($(tds[0]).text()!==''){
        $(tds[6]).text('0')
        $(e).parent().parent().parent().hide()
    }else{
        $(e).parent().parent().parent().remove()
    }
}