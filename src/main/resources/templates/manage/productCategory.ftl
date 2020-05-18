<div class="row justify-content-between align-items-center mb-10" xmlns="http://www.w3.org/1999/html">
    <div class="col-12 col-lg-auto mb-20">
        <div class="page-heading">
            <h3>产品分类管理</h3>
        </div>
    </div>
</div>

<div class="box">
    <div class="box-body" style="min-height: 500px">
        <div class="row">
            <div class="col-5">
                <h5>分类</h5>
                <div id="categoryBox">
                    <ul id="tree" class="ztree" style="min-width:100%; overflow:auto;">

                    </ul>
                </div>
            </div>
            <div class="col-7">
                <div class="row">
                    <div class="col-12">
                        <label for="childName">类别名称</label>
                        <input id="childName" class="form-control form-control-sm">
                    </div>
                    <div class="col-12 mt-10">
                        <button class="button button-primary" style="height: 36px" onclick="addCategory()">添加</button>
                        <button class="button button-info" style="height: 36px" onclick="editCategory()">修改名称</button>
                        <button class="button button-danger" style="height: 36px" onclick="deleteCategory()">删除</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="box-foot">
        <div class="row">
            <div class="col-12">
                <p class="text-muted">
                    添加分类<br>
                    先从左侧选择要添加子类的父类，然后在右侧输入子类名<br>
                    删除分类只会影响到该分类列表，已经归类的商品不会受到影响
                </p>
            </div>
        </div>
    </div>
</div>
<script>
    function initCategory(){
        $.ajax({
            url:"/category/queryAll",
            success:function (data) {
                if(data.code === 200){
                    var zTreeNodes = JSON.parse(data.result);
                    var setting = {
                        view: {
                            selectedMulti: false
                        }
                    };
                    var tree = $.fn.zTree.init($('#tree'), setting, zTreeNodes);
                    tree.expandAll(true)
                }else{
                    alertWarning(data.msg)
                    return false
                }
            },
            error:function () {
                alertWarning("连接服务器失败，请刷新页面重试")
                return false
            }
        });
    }
    initCategory()

    function addCategory() {
        if(!confirm("确认要添加分类名称？")){
            return;
        }
        var treeObj = $.fn.zTree.getZTreeObj('tree')
        var checkedNote = treeObj.getSelectedNodes(true)[0]
        var parentId
        if(checkedNote !== undefined){
            parentId = checkedNote.id
        }else {
            alertWarning("请选择一个父类")
            return
        }
        var categoryName = $('#childName').val()
        if(childName === undefined){
            alertWarning("填写一个子类名称")
            return;
        }
        $.ajax({
            url:"/category/addCategory",
            data:{
                "parentId":parentId,
                "categoryName":categoryName
            },
            success:function (data) {
                if(data.code === 200){
                    alertSuccess(data.msg)
                    initCategory()
                }else{
                    alertWarning(data.msg)
                }
            },
            error:function () {
                alertWarning("服务器没有响应")
            }
        })
    }

    function editCategory() {
        if(!confirm("确认要修改分类名称？")){
            return;
        }
        var treeObj = $.fn.zTree.getZTreeObj('tree')
        var checkedNote = treeObj.getSelectedNodes(true)[0]
        var id
        if(checkedNote !== undefined){
            id = checkedNote.id
        }else {
            alertWarning("请选择一个分类")
            return
        }
        var categoryName = $('#childName').val()
        if(childName === undefined){
            alertWarning("填写一个子类名称")
            return;
        }
        $.ajax({
            url:"/category/editCategory",
            data:{
                "id":id,
                "categoryName":categoryName
            },
            success:function (data) {
                if(data.code === 200){
                    alertSuccess(data.msg)
                    initCategory()
                }else{
                    alertWarning(data.msg)
                }
            },
            error:function () {
                alertWarning("服务器没有响应")
            }
        })
    }
    function deleteCategory() {
        if(!confirm("确认要删除分类名称？")){
            return;
        }else{
            if(!confirm("确认要修改分类名称？")){
                return;
            }
        }
        var treeObj = $.fn.zTree.getZTreeObj('tree')
        var checkedNote = treeObj.getSelectedNodes(true)[0]
        var id
        if(checkedNote !== undefined){
            id = checkedNote.id
        }else {
            alertWarning("请选择一个分类")
            return
        }

        $.ajax({
            url:"/category/deleteCategory",
            data:{
                "id":id
            },
            success:function (data) {
                if(data.code === 200){
                    alertSuccess(data.msg)
                    initCategory()
                }else{
                    alertWarning(data.msg)
                }
            },
            error:function () {
                alertWarning("服务器没有响应")
            }
        })
    }

</script>