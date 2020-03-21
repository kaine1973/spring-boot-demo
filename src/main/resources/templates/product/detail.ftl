
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

            <!-- Add or Edit Product Start -->
            <div class="add-edit-product-wrap col-12">

                <div class="add-edit-product-form">
                    <form onsubmit="return false">

                        <h4 class="title">基本信息</h4>

                        <div class="row">
                            <div class="col-lg-5 col-12 mb-25" style="display: none">
                                <input  type="hidden" id="productId" name="id" <#if product??>value="${product.id}"</#if>>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-5 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="产品名称*" name="name" id="productName" value="<#if product??>product.productName</#if>"></div>
                            <div class="col-lg-5 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="品牌*" id="brand" name="brand" value="<#if product??>product.brand</#if>"></div>
                            <div class="col-lg-5 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="货号*" id="productSerial" name="productSerial" value="<#if product??>product.productSerial</#if>"></div>

                            <div class="col-lg-5 col-12 mb-25" >
                                <input class="form-control form-control-sm" type="text" placeholder="型号" id="model" name="model" value="<#if product??>product.model</#if>">
                            </div>
                            <div class="col-lg-3 col-12 mb-25" >
                                <input class="form-control form-control-sm" type="text" placeholder="单位*" id="productUnit" onfocusout="changeUnit()" name="unit" value="<#if product??>product.productUnit</#if>">
                            </div>
                            <div class="col-lg-5 col-12 mb-25 input-group">
                                <div class="input-group-prepend" style="height: 36px"><span class="input-group-text" style="font-size: 13px">类别*</span> </div>
                                <select class="form-control form-control-sm nice-select wide" style="height: 36px" name="category" id="category" value="<#if product??>product.categoryId</#if>">
                                    <#if categorys??>
                                        <#list categorys as category>
                                            <option value="${category.id}" <#if (product.productId == category.id)>default</#if>>${category.categoryName}</option>
<#--                                            <text style="display: none" id="category-${category.id}">${category.parentId}</text>-->
                                        </#list>
                                    </#if>
                                </select>
                            </div>
                        </div>
                        <div>
                            <h4 class="title">产品规格</h4>
                            <ul class="list-group" id="specification">
                                <li class="list-group-item col-lg-10 col-12">
                                    <div class="row">
                                        <div class="col-sm-3 col-12 mb-2 input-group">
                                            <input class="form-control form-control-sm" type="text" placeholder="规格*" name="specificationName">
                                        </div>
                                        <div class="col-sm-3 col-12 mb-2 input-group">
                                            <input class="form-control form-control-sm" type="number" step="any" placeholder="价格*" name="price">
                                        </div>
                                        <div class="col-sm-4 col-12 mb-2 input-group" style="height: 36px">
                                            <input class="form-control" type="number" step="any" placeholder="数量" name="amount" style="height: 36px;font-size: 13px">
                                            <div class="input-group-append" style="height: 36px">
                                                <span class="input-group-text" id="unitSpan" style="font-size: 13px"></span>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="row mt-10">
                            <div class="col-sm-3 mb-5">
                                <button class="button button-primary button-xs" style="height: 36px" type="button" onclick="appendSpecification()"><i class="zmdi zmdi-plus"></i><span>添加</span></button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 ml-0" style="margin-top: 40px;">
                                <#if product.id??>
                                    <button class="button button-danger"><span><i class="zmdi zmdi-delete"></i>删除</span></button>
                                    <button class="button button-success"><span><i class="zmdi zmdi-refresh"></i>撤销</span></button>
                                <#else >
                                    <button class="button button-dark" type="button" onclick="cleanForm()" ><span><i class="zmdi zmdi-refresh"></i>清空</span></button>
                                </#if>
                                <button class="button button-primary" onclick="submitProductData()"><span><i class="zmdi zmdi-save"></i>保存</span></button>
                            </div>
                        </div>
                    </form>
                </div>

            </div><!-- Add or Edit Product End -->
