function showAddressBook() {

    $.ajax({
        url:"/address/showAddressQueryPage",
        success:function (data) {
            if(data.code===200){
                $('#modalBody').html(data.result)
                $('#exampleModalLong').modal('show')
                queryAddressCustomerByParams(1)
            }else{
                alertWarning(data.msg)
                return
            }
        },
        error:function () {
            alertWarning("服务器未能成功响应")
            return
        }
    })

}
function queryAddressCustomerByParams(current_page) {
    showLoadingDiv()
    var queryName = $('#queryName').val()
    var queryCompany = $('#queryCompany').val()
    $.ajax({
        url:'/customer/queryByParams',
        data:{
            'pageNum':current_page ,
            'queryName':queryName,
            'queryCompany':queryCompany,
        },
        success:function (data) {
            if(data.code === 200){
                var html = ""
                $.each(data.result['rows'],function (index,item) {
                    html += "<tr>";
                    html += "<td>"+item.customerName+"</td>";
                    html += "<td>"+item.company+"</td>";
                    html += "<td><a class='zmdi zmdi-arrow-right' href='javascript:queryAddressByCustomerId("+item.id+")'>>></a></td>";
                    html += "</tr>";
                })
                $('#addressCustomerTBody').html(html)
            }
        }
    })
    stopLoadingDiv()
}

function queryAddressByCustomerId(customerId){
    $.ajax({
        url:"/address/queryAddressByCustomerId",
        data:{
            "customerId":customerId
        },
        success:function (data) {
            if(data.code === 200){
                var addressBody = $('#selectAddressBody')
                var html = "<div class=\"adomx-checkbox-radio-group\">\n"

                $.each(data.result,function (index,item) {
                    html += "<label class=\"adomx-radio\">" +
                        "<input type=\"radio\" name=\"addressCombo\" value='"+item.id+"'>" +
                        "<i class=\"icon\"></i><span>" +
                        item.name +"-"+ (item.company==null?"":item.company) +"-"+ item.phone +"<br>"+ item.province + item.city + item.district + item.detail
                        +"</span></label>\n"
                })
                if(data.result.length === 0 ){
                    html += "没有地址</div>"
                }else{
                    html += "</div><div class='row'><div class='col-sm-12 col-12'><button class='button button-sm button-primary' onclick='selectAddress()' style='height: 36px'>确认</button></div></div>";
                }
                addressBody.html(html)
            }
        }
    })
}

function selectAddress() {
    var selectAddress = $('input[name="addressCombo"]:checked');
    var addressId = selectAddress.val()
    var addressSpan = selectAddress.parent().children('span')
    $('#selectReceiver').children('span').html(addressSpan.html())
    $('#selectReceiver').children('input').val(addressId)
    $('#exampleModalLong').modal('hide')


}