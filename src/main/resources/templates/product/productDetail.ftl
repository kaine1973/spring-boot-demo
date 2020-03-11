
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
                            <div class="col-lg-5 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="产品名称*" name="name" id="productName" value="<#if product??>product.name</#if>"></div>
                            <div class="col-lg-5 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="品牌*" id="brand" name="brand"></div>
                            <div class="col-lg-5 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="货号*" id="productSerial" name="productSerial"></div>

                            <div class="col-lg-5 col-12 mb-25" >
                                <input class="form-control form-control-sm" type="text" placeholder="型号" id="model" onfocusout="changeUnit()" name="unit">
                            </div>
                            <div class="col-lg-3 col-12 mb-25" >
                                <input class="form-control form-control-sm" type="text" placeholder="单位*" id="productUnit" onfocusout="changeUnit()" name="unit">
                            </div>
                            <div class="col-lg-5 col-12 mb-25 input-group">
                                <div class="input-group-prepend" style="height: 36px"><span class="input-group-text" style="font-size: 13px">类别*</span> </div>
                                <select class="form-control form-control-sm nice-select wide" style="height: 36px" name="category" id="category">
                                    <#if categorys??>
                                        <#list categorys as value>
                                            <option value=${value.id}>${value.categoryName}</option>
                                            <text style="display: none" id="category-${value.id}">${value.parentId}</text>
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
                                        <div class="col-sm-3 col-12 mb-2 input-group"><input class="form-control form-control-sm" type="text" placeholder="规格*" name="specificationName"></div>
                                        <div class="col-sm-3 col-12 mb-2 input-group"><input class="form-control form-control-sm" type="number" step="any" placeholder="价格*" name="price"></div>
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
<#--                            <div class="col-lg-5 col-12 mb-25">-->
<#--                                <select class="form-control form-control-sm select2">-->
<#--                                    <option value="status">Status</option>-->
<#--                                    <option value="publish">Publish</option>-->
<#--                                    <option value="draft">Draft</option>-->
<#--                                </select>-->
<#--                            </div>-->

<#--                            <div class="col-10 mb-25"><textarea class="form-control form-control-sm" placeholder="备注"></textarea></div>-->

<#--                        <h4 class="title">Product Gallery</h4>-->

<#--                        <div class="product-upload-gallery row flex-wrap">-->
<#--                            <div class="col-12 mb-30">-->
<#--                                <p class="form-help-text mt-0">Upload Maximum 800 x 800 px & Max size 2mb.</p>-->
<#--                                <input class="file-pond" type="file" multiple>-->
<#--                            </div>-->
<#--                        </div>-->

<#--                        <h4 class="title">Additional Information</h4>-->


                    </form>
                </div>
            </div><!-- Add or Edit Product End -->

            <div class="row">
                <div class="col-lg-1 col-12" >
                    <button class="button button-outline button-dark" type="button" onclick="cleanForm()">清空</button>
                </div>
                <div class="col-lg-1 col-12" >
                    <button class="button button-outline button-primary" onclick="submitProductData()">保存</button>
                </div>
                <#if product.id??>
                    <button class="button button-outline button-info">撤销修改</button>
                    <button class="button button-outline button-danger">删除</button>
                </#if>
            </div>
