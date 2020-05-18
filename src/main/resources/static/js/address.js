function saveAddress(save) {
    var id = $('#receiveId').val()
    var name = $('#receiveName').val()
    var company = $('#receiveCompany').val()
    var phone = $('#receivePhone').val()
    var province = $('#receiveProvince :selected').text()
    var provinceId = $('#receiveProvince :selected').val()
    var city = $('#receiveCity :selected').text()
    var cityId = $('#receiveCity :selected').val()
    var districtId = $('#receiveDistrict :selected').val()
    var district = $('#receiveDistrict :selected').text()
    var detail = $('#receiveDetail').val()
    if(name === ''){
        alertWarning("姓名不能为空")
        return
    }
    if(company === ''){
        alertWarning("公司不能为空")
        return
    }
    if(phone === ''){
        alertWarning("电话不能为空")
        return
    }
    let flag = false
    let message = "未能成功保存"
    if(save === 1){
        $.ajax({
            url:"/address/saveAddress",
            async:false,
            data:{
                "id":id,
                "name":name,
                "company":company,
                "phone":phone,
                "districtId":districtId,
                "detail":detail,
                "ofUser":1,
            },
            success:function (data) {
                if(data.code !== 200){
                    flag = true
                }
                message = data.msg
            },
            error:function () {
                flag = true
            }
        })
    }
    if(flag){
        alertWarning(message)
        return
    }

    var address = "<tr>" +
        "<td hidden>"+id+"</td>" +
        "<td>"+name+"</td>" +
        "<td>"+company+"</td>" +
        "<td>"+phone+"</td>" +
        "<td hidden>"+provinceId+"-"+cityId+"-"+districtId+"</td>" +
        "<td>"+province+"&nbsp;"+city+"&nbsp;"+district+"&nbsp;"+detail+"</td>" +
        "<td hidden>1</td>" +
        "<td style='padding-top: 3px'>\n" +
        "<div class='button-group'>" +
        "   <button class=\"button button-xs button-warning\" style=\"height: 25px\" onclick=\"showAddressDetailModal(this)\"><i class='zmdi zmdi-edit'></i>编辑</button>" +
        "   <button class=\"button button-xs button-primary\" style=\"height: 25px\" onclick=\"deleteCustomerAddress(this)\"><i class='zmdi zmdi-delete'></i>删除</button>" +
        "</div>\n" +
        "</td>"+
        "</tr>"
    var sourceRow = $('#sourceRow')
    if(sourceRow.val() >= 0){
        $.each($('#addressTableBody').children('tr'),function (index,item) {
            if(sourceRow.val() == index){
                $(item).replaceWith(address)
            }
        })
    }else{
        $('#addressTableBody').append(address)
    }
    $('#addressModal').modal('hide')
}
function showAddressDetailModal(e,save){
    var id,name,company,phone,detail,isValid,areaId,provinceId,cityId,districtId;
    if(e !== undefined){
        var tds = $(e).parent().parent().parent().children('td')
        id = $(tds[0]).text()
        name = $(tds[1]).text()
        company = $(tds[2]).text()
        phone = $(tds[3]).text()
        detail = $(tds[5]).html().split('&nbsp;')[3]
        isValid = $(tds[6]).text()
        areaId = $(tds[4]).text().split('-')
        provinceId = areaId[0]
        cityId = areaId[1]
        districtId = areaId[2]
    }
    $.ajax({
        url:"/address/getAddressDetailPage",
        data:{
            "id":id,
            "name":name,
            "company":company,
            "phone":phone,
            "provinceId":provinceId,
            "cityId":cityId,
            "districtId":districtId,
            "detail":detail,
            "isValid":isValid,
            "saveImmediately":save
        },
        success:function(data){
            if(data.code === 200){
                $('#addressModalBody').html(data.result)
                $('#sourceRow').val($(e).parent().parent().parent().index())
                $('#addressModalTitle').html("地址信息")
                $('#addressModal').modal('show')
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("服务器未能成功响应")
        }
    })
}