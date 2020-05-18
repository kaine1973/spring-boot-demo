<div class="row justify-content-between align-items-center mb-10">
    <div class="col-12 col-lg-auto mb-20">
        <div class="page-heading">
            <h3>客户职位管理</h3>
        </div>
    </div>
</div>

<div class="box">
    <div class="box-body" style="min-height: 500px">
        <div class="row">
            <div class="col-5">
                <h5>职位</h5>
                <ul id="positionBody" class="list-group" style="width: 100%;height: 600px;overflow-y: scroll;">
                    <#list [1,2,3,4,5,6,7,8,9,10,11,12,13] as item>
                        <li class="list-group-item" style="height: 36px">
                            <label class="adomx-radio" ><input type='radio' name='customerSelector' value="${item_index}" >"
                                <i class="icon"></i>
                                <strong>item.customerName + ${item} </strong>
                            </label>"
                        </li>
                    </#list>
                </ul>
            </div>
            <div class="col-7">
                <div class="row">
                    <div class="col-12">
                        <label for="positionName">职位名称</label>
                        <input id="positionName" class="form-control form-control-sm">
                    </div>
                    <div class="col-12 mt-10">
                        <button class="button button-primary" style="height: 36px" onclick="addPosition()">添加</button>
                        <button class="button button-info" style="height: 36px" onclick="editPosition()">修改名称</button>
                        <button class="button button-danger" style="height: 36px" onclick="deletePosition()">删除</button>
                        <button class="button button-secondary" style="height: 36px" onclick="saveOrder()">保存顺序</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="box-foot">
        <div class="row">
            <div class="col-12">
                <p class="text-muted">
                    为选择的父类添加子类<br>
                    先从左侧选择要添加子类的父类，然后在右侧输入子类名
                </p>
            </div>
        </div>
    </div>
</div>
<script>

    function parsePositionRows(positions) {
        var html = ""
        $.each(positions,function (index,item) {
            html += "<li class=\"list-group-item\" style=\"height: 36px\">" +
                "<label class=\"adomx-radio\" ><input type='radio' name='customerSelector' value='"+item.id+"' >" +
                "<i class=\"icon\"></i>" +
                "<strong>"+item.positionName+"</strong>" +
                "</label><span class='handler' style='float: right;margin-bottom: 3px;'><i class='zmdi zmdi-menu'></i></span>" +
                "</li>"
        })
        return html
    }

    function initPositionList() {
        flag=false
        $.ajax({
            url:"/common/queryAllPosition",
            async:false,
            success:function (data) {
                if(data.code === 200){
                    var html = parsePositionRows(data.result)
                    $('#positionBody').html(html)
                    flag = true
                }
            }
        })
        if(flag){
            var positionBody = document.getElementById('positionBody')
            new Sortable(positionBody, {
                group:'position',
                animation: 150,
                swapThreshold: 0.01
            });
        }

    }

    initPositionList()

    function addPosition() {
        var positionName = $('#positionName').val()
        $.ajax({
            url:"/common/addCustomerPosition",
            data:{
                "positionName":positionName
            },
            success:function (data) {
                if(data.code === 200){
                    alertSuccess("添加成功成功")
                    initPositionList()
                }
            }
        })
    }

    function editPosition() {
        var selectedId = $("input[name='customerSelector']:checked").val()
        var positionName = $('#positionName').val()
        $.ajax({
            url:"/common/editCustomerPosition",
            data:{
                "id":selectedId,
                "positionName":positionName
            },
            success:function (data) {
                if(data.code === 200){
                    alertSuccess("添加成功成功")
                    initPositionList()
                }
            }
        })
    }

    function deletePosition() {
        var selectedId = $("input[name='customerSelector']:checked").val()
        $.ajax({
            url:"/common/deleteCustomerPosition",
            data:{
                "id":selectedId
            },
            success:function (data) {
                if(data.code === 200){
                    alertSuccess("添加成功成功")
                    initPositionList()
                }
            }
        })
    }

    function saveOrder() {
        var ids=[]
        $.each($('input[name=customerSelector]'),function(index,item){
            ids.push($(item).val())
        })
        $.ajax({
            url:"/common/savePositionOrder",
            data:{
                'ids':ids
            },
            success:function (data) {
                if(data.code === 200){
                    alertSuccess("保存成功")
                    initPositionList()
                }
            }
        })
    }
</script>