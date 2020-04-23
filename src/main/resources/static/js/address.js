function saveAddress(container) {

    var name = $('#receiveName').val()
    var company = $('#receiveCompany').val()
    var phone = $('#receivePhone').val()
    var provinceId = $('#receiveProvince :selected').val()
    var province = $('#receiveProvince :selected').text()
    var cityId = $('#receiveCity :selected').val()
    var city = $('#receiveCity :selected').text()
    var districtId = $('#receiveDistrict :selected').val()
    var district = $('#receiveDistrict :selected').text()
    var detail = $('#receiveDetail').val()

    var address = "<tr>" +
        "<td>"+name+"</td>" +
        "<td>"+company+"</td>" +
        "<td>"+phone+"</td>" +
        "<td hidden>"+provinceId+"-"+cityId+"-"+districtId+"</td>" +
        "<td>"+province+"-"+city+"-"+district+"</td>" +
        "<td>"+detail+"</td>" +
        "<td style='padding-top: 3px'><div class='button-group'>" +
        "<button class='button button-box button-primary' style='height: 36px'><i class='zmdi zmdi-edit'></i></button>" +
        "<button class='button button-box button-danger' style='height: 36px'><i class='zmdi zmdi-delete'></i></button>" +
        "</div></td></tr>"
    if(container === '#addressTableBody'){
        $(container).append(address)
    }else{
        $(container).html(address)
    }
    $('#exampleModalLong').modal('hide')
}
function saveOrderAddress(container) {

    var name = $('#receiveName').val()
    var company = $('#receiveCompany').val()
    var phone = $('#receivePhone').val()
    var provinceId = $('#receiveProvince :selected').val()
    var province = $('#receiveProvince :selected').text()
    var cityId = $('#receiveCity :selected').val()
    var city = $('#receiveCity :selected').text()
    var districtId = $('#receiveDistrict :selected').val()
    var district = $('#receiveDistrict :selected').text()
    var detail = $('#receiveDetail').val()

    var address = name+"-" + company+"-" + phone+"<br>" +
        // provinceId+"-"+cityId+"-"+districtId+"" +
        province+"-"+city+"-"+district+"" +
        detail+""
    if(container === '#addressTableBody'){
        $(container).append(address)
    }else{
        $(container).html(address)
    }
    $('#exampleModalLong').modal('hide')
}
function showAddressDetailModal(container){
    $.ajax({
        url:"/address/getAddressDetailPage",
        data:{
            "container":container
        },
        success:function(data){
            if(data.code === 200){
                $('#modalBody').html(data.result)
                $('#exampleModalLong').modal('show')
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("服务器未能成功响应")
        }
    })
}