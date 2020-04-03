<#if !product??>
    <!-- Page Headings Start -->
    <div class="row justify-content-between align-items-center mb-10">

        <!-- Page Heading Start -->
        <div class="col-12 col-lg-auto mb-20">
            <div class="page-heading">
                <h3>产品 <span>/ 添加</span></h3>
            </div>
        </div><!-- Page Heading End -->

        <!-- Page Button Group Start -->
        <!-- Page Button Group End -->
    </div><!-- Page Headings End -->
</#if>

            <!-- Add or Edit Product Start -->
            <div class="row">
                <div class="col-lg-3 col-12 accordion accordion-icon" style="background-color: #e2e2e2;min-height: 100%;border-radius: 5px 5px 5px 5px">
                    <div class="hide-responsive" style="margin-top: 25px;">
                        <h5>分类</h5>
                        <div id="categoryBox">
                            <ul id="treeDetail" class="ztree" style="min-width:100%; overflow:auto;"></ul>
                            <style onload="initCategoryBoxSetDefault(<#if product??>'${product.categoryId}'</#if>)"></style>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9 col-12" >
                <div class="add-edit-product-form">
                    <form onsubmit="return false">

                        <h4 class="title">基本信息</h4>

                        <div class="row">
                            <div class="col-lg-5 col-12 mb-25" style="display: none">
                                <input  type="hidden" id="productId" name="id" <#if product??>value="${product.productId}"</#if>>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="产品名称*" name="name" id="productName" value="<#if product??>${product.productName}</#if>"></div>
                            <div class="col-lg-4 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="品牌*" id="brand" name="brand" value="<#if product??>${product.brand}</#if>"></div>
                            <div class="col-lg-4 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="货号*" id="productSerial" name="productSerial" value="<#if product??>${product.productSerial}</#if>"></div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4 col-12 mb-25" >
                                <input class="form-control form-control-sm" type="text" placeholder="型号" id="model" name="model" value="<#if product??>${product.model}</#if>">
                            </div>
                            <div class="col-lg-4 col-12 mb-25" >
                                <input class="form-control form-control-sm" type="text" placeholder="单位*" id="productUnit" onfocusout="changeUnit()" name="unit" value="<#if product??>${product.productUnit}</#if>">
                            </div>
                        </div>
                        <div class="row">


                        </div>
                        <h4 class="title">产品规格</h4>
                        <div  id="specification">
                            <#if product??>
                                <#list product.productSpecifications as specification>
                                    <div class="row mb-2">
                                        <div class="col-lg-12 col-12">
                                            <div class="input-group" style="height: 36px">
                                                <input type="hidden" value="${specification.id}">
<#--                                                <div class="input-group-prepend" style='height:36px;'>-->
<#--                                                    <span class="input-group-text" style="font-size: 13px">名称</span>-->
<#--                                                </div>-->
                                                <input class="form-control form-control-sm" type="text" placeholder="规格*" name="specificationName"  style="height: 36px" value="${specification.specificationName}">
<#--                                                <div class="input-group-prepend" style='height:36px;'>-->
<#--                                                    <span class="input-group-text" style="font-size: 13px">单价</span>-->
<#--                                                </div>-->
                                                <input class="form-control form-control-sm" type="number" step="any" placeholder="价格*" name="price"  style="height: 36px" value="${specification.price}">
<#--                                                <div class="input-group-prepend" style='height:36px;'>-->
<#--                                                    <span class="input-group-text" style="font-size: 13px">数量</span>-->
<#--                                                </div>-->
                                                <input class="form-control" type="number" step="any" placeholder="数量" name="amount" style="height: 36px;font-size: 13px" value="${specification.amount}">
                                                <div class="input-group-append" style="height: 36px">
                                                    <span class="input-group-text" id="unitSpan" style="font-size: 13px">${product.productUnit}</span>
                                                </div>
                                                <div class="input-group-append">
                                                    <button class='button button-box button-sm button-danger' style='height:36px;' onclick='removeSpecification(this)'>
                                                        <i class='zmdi zmdi-minus-circle'></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </#list>
                                <#else >
                                    <div class="row">
                                        <div class="col-lg-12 col-12">
                                            <div class="input-group" style="height: 36px">
                                                <input class="form-control form-control-sm" type="text" placeholder="规格*" name="specificationName"  style="height: 36px">
                                                <input class="form-control form-control-sm" type="number" step="any" placeholder="价格*" name="price"  style="height: 36px">
                                                <input class="form-control" type="number" step="any" placeholder="数量" name="amount" style="height: 36px;font-size: 13px">
                                                <div class="input-group-append" style="height: 36px">
                                                    <span class="input-group-text" id="unitSpan" style="font-size: 13px"></span>
                                                </div>
                                                <div class="input-group-append">
                                                    <button class='button button-box button-sm button-danger' style='height:36px;' onclick='removeSpecification(this)'>
                                                        <i class='zmdi zmdi-minus-circle'></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            </#if>
                        </div>
                        <div class="row mt-10">
                            <div class="col-sm-3 mb-5">
                                <button class="button button-primary button-xs" style="height: 36px" type="button" onclick="appendSpecification()"><i class="zmdi zmdi-plus"></i><span>添加</span></button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 ml-0" style="margin-top: 40px;">
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
                    </form>
                </div>
                </div>
            </div><!-- Add or Edit Product End -->

