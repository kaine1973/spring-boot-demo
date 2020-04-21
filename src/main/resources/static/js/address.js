function saveAddress() {

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

    var address = "<tr><td>"+name+"</td><td>"+company+"</td><td>"+phone+"</td><td hidden>"+provinceId+"</td><td>"+province+"</td><td hidden>"+cityId+"</td><td>"+city+"</td><td hidden>"+districtId+"</td><td>"+district+"</td><td>"+detail+"</td>" +
        "<td style='padding-top: 3px'><div class='button-group'>" +
        "<button class='button button-box button-primary' style='height: 36px'><i class='zmdi zmdi-edit'></i></button>" +
        "<button class='button button-box button-danger' style='height: 36px'><i class='zmdi zmdi-delete'></i></button>" +
        "</div></td></tr>"

    $('#addressTableBody').append(address)
    $('#exampleModalLong').modal('hide')
    // $.ajax({
    //     url:"/address/"
    // })

}