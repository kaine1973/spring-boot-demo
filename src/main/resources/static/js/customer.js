function getChildArea(e,nextNode) {
    var parentId = $(e).val();
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
                $(nextNode).children(".marker").remove()
                var nodes = data.result
                for(var i = 0;i<nodes.length;i++){
                    // console.log(nodes[i])
                    $(nextNode).append("<option class='marker' value="+nodes[i]['id']+">"+nodes[i]['areaName']+"</option>")
                }
                $(".nice-select").niceSelect("update")
            }
        },
        error:function () {
            alertWarning("获取地区子节点失败！")
        }
    })
}

function uploadCustomerDetail(e) {
    $(e)
    var id = $('#id').val()
    var customerName = $('#customerName').val()
    var company = $('#company').val()
    var positionId = $('#position').val()
    var gender = $('#gender').val()
    var phone = $('#phone').val()
    var customerId = $('#customerId').val()
    var addressId = $('#district').val()
    var addressDetail = $('#addressDetail').val()
    var levelId = $('#level').val()
    var note = $('#note').val()

    if(isEmpty(customerName)||isNaN(positionId) || isNaN(gender) || isNaN(addressId)){
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
            "addressId":addressId,
            "addressDetail":addressDetail,
            "levelId":levelId,
            "note":note
        },
        success:function (data) {
            if(data.code === 200){
                alertSuccess(data.msg)
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