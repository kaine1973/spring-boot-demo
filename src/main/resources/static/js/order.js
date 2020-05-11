function showAddressBook() {
    $.ajax({
        url: "/address/showAddressQueryPage",
        async: "success",
        success: function (data) {
            if (data.code === 200) {
                $('#modalBody').html(data.result)
                $('#smartWizard').smartWizard({
                    showStepURLhash: false,
                    lang: {
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
                                    if (undefined === addressId) {
                                        alertWarning("没有选择地址")
                                        return false
                                    }
                                    fillReceiverAddress(addressId)
                                })
                        ]
                    },
                });
                $("#smartWizard").on("leaveStep", function (e, anchorObject, stepNumber, stepDirection) {
                    if (stepNumber === 0) {
                        var selectCustomer = $('input[name="customerSelector"]:checked').val()
                        if (undefined !== selectCustomer) {
                            return queryAddressOfCustomer(selectCustomer) & true
                        } else {
                            alertWarning("先选择一个客户")
                            return false;
                        }
                    } else {
                        return true;
                    }
                });
                queryAddressCustomerByParams(1)
                $('#exampleModalLong').modal('show')
            } else {
                alertWarning(data.msg)
            }
        },
        error: function () {
            alertWarning("服务器未能成功响应")
        }
    })
}

function confirmOrder(e) {
    var senderAddressId = $('#senderAddressId').val()
    var receiverAddressId = $('#receiverAddressId').val()
    var customerId = $('#customerId').val()
    var orderNumber = $('#orderNumber').val()
    var operationIds = []
    $.each($('#operationTbody').children('tr'), function (index, item) {
        operationIds[index] = parseInt($($(item).children('td')[0]).text())
    })
    $.ajax({
        url: "/order/insertOrUpdate",
        data: {
            'senderAddressId': senderAddressId,
            'receiverAddressId': receiverAddressId,
            'customerId': customerId,
            'orderNumber': orderNumber,
            'operationIds': JSON.stringify(operationIds)
        },
        success: function (data) {
            if (data.code === 200) {
                alertSuccess(data.msg)
                $('#main button').remove()
                $('#orderNumber').val(data.result.orderNumber)
                $('#main input').prop('disabled', true)
                $('#orderId').val(data.result.id)
                $('#print').toggle()
            } else {
                alertWarning(data.msg)
            }
        }
    })
}

function fillSenderAddress() {
    var addressId = $('input[name="addressCombo"]:checked').val();
    $.ajax({
        url: '/address/queryAddressById',
        data: {"addressId": addressId},
        async: "success",
        success: function (data) {
            if (data.code === 200) {
                $('#senderAddressId').val(data.result.id)
                $('#senderName').val(data.result.name)
                $('#senderCompany').val(data.result.company)
                $('#senderPhone').val(data.result.phone)
                $('#senderProvince').val(data.result.provinceId).change()
                $('#senderCity').val(data.result.cityId).change()
                $('#senderDistrict').val(data.result.districtId).change()
                $('#senderAddress').val(data.result.detail)
                $('#exampleModalLong').modal('hide')
            }
        },
        error: function () {
            alertWarning("服务器没有响应，请重试")
        }
    })
}

function fillReceiverAddress() {
    var addressId = $('input[name="addressCombo"]:checked').val();
    $.ajax({
        url: '/address/queryAddressById',
        data: {"addressId": addressId},
        async: "success",
        success: function (data) {
            if (data.code === 200) {
                $('#receiverAddressId').val(data.result.id)
                $('#receiverName').val(data.result.name)
                $('#receiverCompany').val(data.result.company)
                $('#customerId').val(data.result.customerId)
                $('#receiverPhone').val(data.result.phone)
                $('#receiverProvince').val(data.result.provinceId).change()
                $('#receiverCity').val(data.result.cityId).change()
                $('#receiverDistrict').val(data.result.districtId).change()
                $('#receiverAddress').val(data.result.detail)
                $('#exampleModalLong').modal('hide')
            }
        },
        error: function () {
            alertWarning("服务器没有响应，请重试")
        }
    })
}

function showAlterStockOperation(stockOperationId, e) {
    $.ajax({
        url: "/stock/getOutStockDetailPage",
        async: "success",
        data: {
            "operationId": stockOperationId
        },
        success: function (data) {
            if (data.code === 200) {
                $('#modalBody').html(data.result)
                $('#exampleModalLong').modal('show')
            } else {
                alertWarning(data.msg)
            }
        }
    })
}

function alterStockOperation() {
    var amount = $('#amount').val()
    var dealPrice = $('#dealPrice').val()
    var operationId = $('#operationId').val()
    $.ajax({
        url: "/stock/updateStockOperation",
        async: "success",
        data: {
            "id": operationId,
            "amount": amount,
            "dealPrice": dealPrice
        },
        success: function (data) {
            if (data.code === 200) {
                var row = $('#stockOperation_' + operationId).children('td')
                $(row[9]).text(amount)
                $(row[10]).text(dealPrice)
                $('#exampleModalLong').modal('hide')
            }
        }
    })


}

function queryAddressCustomerByParams(current_page) {
    showLoadingDiv()
    var queryName = $('#queryName').val()
    var queryCompany = $('#queryCompany').val()
    $.ajax({
        url: '/customer/queryByParams',
        data: {
            'pageNum': current_page,
            'pageSize': 5,
            'queryName': queryName,
            'queryCompany': queryCompany,
        },
        async: "success",
        success: function (data) {
            if (data.code === 200) {
                var html = "<div class='adomx-checkbox-radio-group mt-15'>"
                $.each(data.result['list'], function (index, item) {
                    html += "<div class='row mt-5'>" +
                        "<div class='col-12'>" +
                        "<label class=\"adomx-radio\" ><input type='radio' name='customerSelector' value='" + item.id + "'>" +
                        "<i class=\"icon\"></i>" +
                        "<strong>" + item.customerName + " —— " + item.company + "</strong>" +
                        "</label>" +
                        "</div>" +
                        "</div>";

                })
                html += "</div>";
                $('#addressCustomerTBody').html(html)
            }
        }
    })
    stopLoadingDiv()
}


function queryAddressOfCustomer(customerId) {
    var html
    $.ajax({
        url: "/address/queryAddressByCustomerId",
        data: {
            "customerId": customerId
        },
        async: false,
        success: function (data) {
            if (data.code === 200) {
                html = "<div class=\"adomx-checkbox-radio-group\">"
                var checked = ""
                $.each(data.result, function (index, item) {
                    if (index === 0) {
                        checked = "checked"
                    }
                    html += "<label class=\"adomx-radio\">" +
                        "<input type=\"radio\" name=\"addressCombo\" " + checked + " value='" + item.id + "'>" +
                        "<i class=\"icon\"></i><strong>" +
                        item.name + "-" + item.company + "-" + item.phone + "<br>" + item.province + item.city + item.district + item.detail
                        + "</strong></label>"
                })
                if (data.result.length === 0) {
                    html += "没有地址"
                }
                html += "</div>"
                $('#selectAddressBody').html(html)
                return true
            } else {
                alertWarning(data.msg)
            }
        },
        error: function () {
            alertWarning("服务器未能成功响应，请稍后重试或者联系管理员")
        }
    })
    return false
}

function showInfoModalWithSenderAddress() {
    var html
    $.ajax({
        url: "/address/queryUserAddresses",
        async: false,
        success: function (data) {
            if (data.code === 200) {
                html = "<div class=\"adomx-checkbox-radio-group\">"
                var checked = ""
                $.each(data.result, function (index, item) {
                    if (index === 0) {
                        checked = "checked"
                    }
                    html += "<label class=\"adomx-radio\">" +
                        "<input type=\"radio\" name=\"addressCombo\" " + checked + " value='" + item.id + "'>" +
                        "<i class=\"icon\"></i><strong>" +
                        item.name + "-" + (item.company == null ? "" : item.company) + "-" + item.phone + "<br>" + item.province + item.city + item.district + item.detail
                        + "</strong></label>"
                })
                if (data.result.length === 0) {
                    html += "没有地址</div>"
                } else {
                    html += "<div class='row mt-5'>" +
                        "<div class='col-lg-12 col-12'>" +
                        "<button class='button button-primary' style='height: 36px' onclick='fillSenderAddress()'>确认</button>" +
                        "</div>" +
                        "</div>"
                }

                console.log(html)
                $('#modalBody').html(html)
                $('#exampleModalLong').modal("show")
            } else {
                alertWarning(data.msg)
            }
        },
        error: function () {
            alertWarning("服务器未能成功响应，请稍后重试或者联系管理员")
        }
    })
}

function getOrderTicket() {
    var orderId = $('#orderId').val()
    window.open('/order/printOrderTicket?orderId=' + orderId)
}

var startDate, endDate

function initOrderHistory() {
    $('#date-range').daterangepicker({
        "showDropdowns": true,
        "autoApply": true,
        ranges: {
            '今天': [moment(), moment()],
            '昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            '最近7天': [moment().subtract(6, 'days'), moment()],
            '最近30天': [moment().subtract(29, 'days'), moment()],
            '这个月': [moment().startOf('month'), moment().endOf('month')],
            '上个月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        "alwaysShowCalendars": true,
    }, function (start, end) {
        startDate = start.format('MM-DD-YYYY-HH-mm-ss')
        endDate = end.format('MM-DD-YYYY-HH-mm-ss')
    });
    queryOrderByParams()
}

function queryOrderByParams() {
    var productName = $('#queryProductName').val()
    var orderNumber = $('#queryOrderNumber').val()
    var userId = $('#queryUserId').val()
    $('#pagination-container').pagination({
        dataSource: '/order/queryByParams',
        locator: 'result.list',
        totalNumberLocator: function (response) {
            return response.result.pageSize * response.result.pages
        },
        pageSize: 10,
        pageRange: 6,
        alias: {
            pageNumber: 'pageNum'
        },
        ajax: {
            data: {
                "productName": productName,
                "userId": userId,
                "orderNumber": orderNumber,
                "dateFrom": startDate,
                "dateTo": endDate
            },
            beforeSend: function () {
                $('#orderHistoryBody').html('加载数据中 ...');
            }
        },
        callback: function (data, pagination) {
            var html = parseOrderRows(data);
            $('#orderHistoryBody').html(html);
        }
    })

}

function parseOrderRows(orders) {
    var html = ""
    $.each(orders, function (index, item) {
        html += "<div class=\"row mb-10\">\n" +
            "                <div class=\"col-12\">\n" +
            "                    <div class=\"card\">\n" +

            "<div class=\"card-header\">\n" +
            "<div class=\"row\">\n" +
            "<div class=\"col-4\">订单号: <a target=\"_blank\" href=\"/order/printOrderTicket?orderId=" + item.id + "\">" + item.orderNumber + "</a></div>\n" +
            "<div class=\"col-4\">日期:" + moment(item.createDate).format("YYYY-MM-DD HH:mm:ss") + "</div>\n" +
            "<div class=\"col-4\" align=\"right\">销售:" + item.userName + "</div>\n" +
            "</div>\n" +
            "</div>\n" +

            "<ul class=\"list-group list-group-flush\">\n"
        var total = 0
        $.each(item.stockOperations, function (index, operation) {
            html += "<li class=\"list-group-item \">\n" +
                "<div class=\"row\">\n" +
                "<div class=\"col-5\">\n" + operation.productName + "</div>\n" +
                "<div class=\"col-3\">\n" + operation.specificationName + "</div>\n" +
                "<div class=\"col-2\">\n" + operation.amount + operation.productUnit + "</div>\n" +
                "<div class=\"col-2\">\n￥" + (operation.dealPrice == null ? operation.price : operation.dealPrice) + "</div>\n" +
                "</div>\n" +
                "</li>\n"
            total += operation.amount * (operation.dealPrice == null ? operation.price : operation.dealPrice)
        })

        html += "</ul>\n" +

            "<div class=\"card-footer\">\n" +
            "<div class=\"row\">\n" +
            "<div class=\"col-5 text-muted\">发货:" + item.senderAddress.company + "-" + item.senderAddress.name + "</div>\n" +
            "<div class=\"col-5 text-muted\">收货:" + item.receiverAddress.company + "-" + item.receiverAddress.name + "</div>\n" +
            "<div class=\"col-2\" align=\"right\">合计:" + total + "</div>\n" +
            "</div>\n" +
            "</div>\n" +

            "</div>\n" +
            "</div>\n" +
            "</div>"
    })
    if (orders.length === 0) {
        return '未找到相关订单 ...'
    }
    return html
}

function resetSearchOrder() {
    $('#queryProductName').val('')
    $('#queryOrderNumber').val('')
    $('#queryUserId').val('')
    startDate = null
    endDate = null
    queryOrderByParams()
}