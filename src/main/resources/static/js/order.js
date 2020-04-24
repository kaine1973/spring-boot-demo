function showAddressBook() {
    $.ajax({
        url:"/address/showAddressQueryPage",
        success:function (data) {
            if(data.code===200){
                $('#modalBody').html(data.result)
                $('#smartWizard').smartWizard({
                    showStepURLhash: false,
                    lang:{
                        next: '选择地址',
                        previous: '选择客户'
                    },
                    toolbarSettings: {
                        showNextButton: true, // show/hide a Next button
                        showPreviousButton: true, // show/hide a Previous button
                        toolbarExtraButtons: [
                            $('<button></button>').text('确认')
                                .addClass('button button-info')
                                .on('click', function () {
                                    var addressId = $('input[name="addressCombo"]:checked').val();
                                    $.ajax({
                                        url:'/address/queryAddressById',
                                        data:{"addressId":addressId},
                                        success:function (data) {
                                            if(data.code === 200){
                                                $('#receiverName').val(data.result.name)
                                                $('#receiverCompany').val(data.result.company)
                                                $('#receiverPhone').val(data.result.phone)
                                                $('#receiverProvince').val(data.result.provinceId)
                                                $('#receiverProvince').change()
                                                $('#receiverCity').val(data.result.cityId)
                                                $('#receiverCity').change()
                                                $('#receiverDistrict').val(data.result.districtId)
                                                $('#receiverDistrict').change()
                                            }
                                        }
                                    })
                                    $('#exampleModalLong').modal('hide')
                                }),
                        ]
                    },
                });
                $("#smartWizard").on("leaveStep", function(e, anchorObject, stepNumber, stepDirection) {
                    if(stepNumber === 0){
                        var selectCustomer = $('input[name="customerSelector"]:checked').val()
                        if(undefined !== selectCustomer){
                            return queryAddressOfCustomer(selectCustomer) & true
                        }else{
                            alertWarning("先选择一个客户")
                            return false;
                        }
                    }else{
                        return true;
                    }
                });
                queryAddressCustomerByParams(1)
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

function queryAddressCustomerByParams(current_page) {
    showLoadingDiv()
    var queryName = $('#queryName').val()
    var queryCompany = $('#queryCompany').val()
    $.ajax({
        url:'/customer/queryByParams',
        data:{
            'pageNum':current_page,
            'pageSize':5,
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
                    html += "<td><input type='radio' name='customerSelector' value='"+item.id+"'></td>";
                    html += "</tr>";
                })
                $('#addressCustomerTBody').html(html)
            }
        }
    })
    stopLoadingDiv()
}


function queryAddressOfCustomer(customerId){
    var html
    $.ajax({
        url:"/address/queryAddressByCustomerId",
        data:{
            "customerId":customerId
        },
        success:function (data) {
            if(data.code === 200){
                html = "<div class=\"adomx-checkbox-radio-group\">"
                var checked = ""
                $.each(data.result,function (index,item) {
                    if(index === 0){
                        checked = "checked"
                    }
                    html += "<label class=\"adomx-radio\">" +
                        "<input type=\"radio\" name=\"addressCombo\" "+checked+" value='"+item.id+"'>" +
                        "<i class=\"icon\"></i><strong>" +
                        item.name +"-"+ item.company +"-"+ item.phone +"<br>"+ item.province + item.city + item.district + item.detail
                        +"</strong></label>"
                })
                if(data.result.length === 0 ){
                    html += "没有地址"
                }
                html += "</div>"
                $('#selectAddressBody').html(html)
                return true
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("服务器未能成功响应，请稍后重试或者联系管理员")
        }
    })
    return false
}
function showInfoModalWithSenderAddress(){
    var html
    $.ajax({
        url:"/address/queryUserAddresses",
        success:function (data) {
            if(data.code === 200){
                html = "<div class=\"adomx-checkbox-radio-group\">"
                var checked = ""
                $.each(data.result,function (index,item) {
                    if(index === 0){
                        checked = "checked"
                    }
                    html += "<label class=\"adomx-radio\">" +
                        "<input type=\"radio\" name=\"addressCombo\" "+checked+" value='"+item.id+"'>" +
                        "<i class=\"icon\"></i><strong>" +
                        item.name +"-"+ (item.company==null?"":item.company) +"-"+ item.phone +"<br>"+ item.province + item.city + item.district + item.detail
                        +"</strong></label>"
                })
                if(data.result.length === 0 ){
                    html += "没有地址</div>"
                }else{
                    html += "<div class='row mt-5'>" +
                                "<div class='col-lg-12 col-12'>" +
                                    "<button class='button button-primary' style='height: 36px' onclick='selectAddress("+'"#senderBody"'+")'>确认</button>" +
                                "</div>" +
                            "</div>"
                }

                console.log(html)
                $('#modalBody').html(html)
                $('#exampleModalLong').modal("show")
            }else{
                alertWarning(data.msg)
            }
        },
        error:function () {
            alertWarning("服务器未能成功响应，请稍后重试或者联系管理员")
        }
    })
}

function selectAddress(fillContainer) {
    var selectAddress = $('input[name="addressCombo"]:checked');
    var addressId = selectAddress.val()
    var addressSpan = selectAddress.parent().children('strong')
    $(fillContainer).children('p').html(addressSpan.html())
    $(fillContainer).children('input').val(addressId)
    $('#exampleModalLong').modal('hide')
}
