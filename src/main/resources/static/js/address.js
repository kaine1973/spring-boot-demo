function saveAddress() {

    var name = $('#receiveName').val()
    var company = $('#receiveCompany').val()
    var phone = $('#receivePhone').val()
    var province = $('#receiveProvince :selected').text()
    var city = $('#receiveCity :selected').text()
    var districtId = $('#receiveDistrict :selected').val()
    var district = $('#receiveDistrict :selected').text()
    var detail = $('#receiveDetail').val()

    var address = "<tr>" +
        "<td>"+name+"</td>" +
        "<td>"+company+"</td>" +
        "<td>"+phone+"</td>" +
        "<td hidden>"+districtId+"</td>" +
        "<td>"+province+" "+city+" "+district+" "+detail+"</td>" +
        "<td style='padding-top: 3px'><div class='button-group'>" +
        "<button class='button button-box button-primary' style='height: 36px'><i class='zmdi zmdi-edit'></i></button>" +
        "<button class='button button-box button-danger' style='height: 36px'><i class='zmdi zmdi-delete'></i></button>" +
        "</div></td></tr>"
    $('#addressTableBody').append(address)
    $('#customerModal').modal('hide')
}
function showAddressDetailModal(container,addressId){
    $.ajax({
        url:"/address/getAddressDetailPage",
        data:{
            "addressId":addressId
        },
        success:function(data){
            if(data.code === 200){
                $('#customerModalBody').html(data.result)
                $('#customerModalTitle').html("地址信息")
                $('#customerModal').modal('show')
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("服务器未能成功响应")
        }
    })
}