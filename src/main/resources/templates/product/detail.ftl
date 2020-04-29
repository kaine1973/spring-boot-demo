<#if !product??>
    <!-- Page Headings Start -->
    <div class="row justify-content-between align-items-center mb-10">

        <!-- Page Heading Start -->
        <div class="col-12 col-lg-auto mb-20">
            <div class="page-heading">
                <h3>产品 <span>/ 添加</span></h3>
            </div>
        </div><!-- Page Heading End -->

    </div><!-- Page Headings End -->
</#if>

            <!-- Add or Edit Product Start -->
            <div class="row">
                <div class="col-lg-3 col-12">
                    <div class="box">
                        <div class="box-head">
                            <h6 class="title" style="display: inline">分类</h6>
                            <button class="button button-xs button-info show-responsive" style="height:30px;float:right;display: none">选择</button>
                        </div>
                            <div id="categoryBox">
                                <ul id="treeDetail" class="ztree" style="min-width:100%; overflow:auto;"></ul>
                                <style onload="initCategoryBoxSetDefault(<#if product??>'${product.categoryId}'</#if>)"></style>
                            </div>

                    </div>
                </div>
                <div class="col-lg-9 col-12" >
                    <div class="row">
                        <div class="col-12">
                            <div class="box">
                                <div class="box-head">
                                    <h6 class="title">基本信息</h6>
                                </div>
                                <div class="box-body">
                                    <input  type="hidden" id="productId" name="id" <#if product??>value="${product.productId}"</#if>>
                                    <div class="row">
                                        <div class="col-lg-4 col-12 mb-25">
                                            <label for="productName">产品名称*</label>
                                            <input class="form-control form-control-sm" type="text" name="name" id="productName" value="<#if product??>${product.productName}</#if>">
                                        </div>
                                        <div class="col-lg-4 col-12 mb-25">
                                            <label for="brand">品牌*</label>
                                            <input class="form-control form-control-sm" type="text" id="brand" name="brand" value="<#if product??>${product.brand}</#if>">
                                        </div>
                                        <div class="col-lg-4 col-12 mb-25">
                                            <label for="productSerial">货号*</label>
                                            <input class="form-control form-control-sm" type="text" id="productSerial" name="productSerial" value="<#if product??>${product.productSerial}</#if>"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-4 col-12 mb-25" >
                                            <label for="model">型号</label>
                                            <input class="form-control form-control-sm" type="text" placeholder="" id="model" name="model" value="<#if product??>${product.model}</#if>">
                                        </div>
                                        <div class="col-lg-4 col-12 mb-25" >
                                            <label for="productUnit">单位*</label>
                                            <input class="form-control form-control-sm" type="text" placeholder="" id="productUnit" onfocusout="changeUnit()" name="unit" value="<#if product??>${product.productUnit}</#if>">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="box">
                                <div class="box-head">
                                    <h6 class="title" style="display: inline">产品规格</h6>
                                    <button class="button button-primary button-xs" style="height: 36px;float:right" type="button" onclick="showAddSpecificationModal('add',this)"><i class="zmdi zmdi-plus"></i><span>添加</span></button>
                                </div>
                                <div class="box-body">
                                    <div id="specification">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <td>规格名称</td><td>单价</td><td>数量</td><td>操作</td>
                                                </tr>
                                            </thead>
                                            <tbody id="specificationTbody">
                                            <#if product??>
                                                <#list product.productSpecifications as specification>
                                                    <tr>
                                                        <td hidden>${specification.id}</td>
                                                        <td>${specification.specificationName}</td>
                                                        <td>${specification.price}</td>
                                                        <td>${specification.amount}</td>
                                                        <td hidden>${specification.is_valid}</td>
                                                        <td width="100px"><button class="button button-xs button-warning" style="height: 25px" onclick="deleteSpecification(this)">删除</button>
                                                            <button class="button button-xs button-primary" style="height: 25px" onclick="editSpecification(this)">编辑</button></td>
                                                    </tr>
                                                </#list>
                                            </#if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <div style="margin-top: 40px;">
                                <#if product??>
                                    <button class="button button-info" onclick="closeModal()"><span><i class="zmdi zmdi-close"></i>关闭</span></button>
                                    <button class="button button-danger" onclick="deleteProduct('${product.productId}','${product.productName}')"><span><i class="zmdi zmdi-delete"></i>删除</span></button>
                                <#--                                    <button class="button button-success"><span><i class="zmdi zmdi-refresh"></i>撤销</span></button>-->
                                <#else >
                                    <button class="button button-dark" type="button" onclick="cleanForm()" ><span><i class="zmdi zmdi-refresh"></i>清空</span></button>
                                </#if>
                                <button class="button button-primary" onclick="submitProductData()"><span><i class="zmdi zmdi-save"></i>保存</span></button>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="specificationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-body" id="modalBody">
                                <div class="box">
                                    <div class="box-head">
                                        <h6 class="title">添加规格</h6>
                                    </div>
                                    <div class="box-body">
                                        <div class="row">
                                            <input type="text" hidden id="specificationId">
                                            <div class="col-12" >
                                                <label for="model">规格名称*</label>
                                                <input class="form-control form-control-sm" type="text" placeholder="" id="specificationName" value="">
                                            </div>
                                            <div class="col-12 mt-5" >
                                                <label for="productUnit">价格*</label>
                                                <input class="form-control form-control-sm" type="number" placeholder="" id="specificationPrice" value="">
                                            </div>
                                            <div class="col-12 mt-5" >
                                                <label for="productUnit">数量</label>
                                                <input class="form-control form-control-sm" type="number" placeholder="" id="specificationAmount" value="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="box-foot">
                                        <button class="button button-primary" onclick="addSpecificationRow()">确认</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div><!-- Add or Edit Product End -->

