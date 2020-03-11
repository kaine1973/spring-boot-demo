
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
                            <div class="col-lg-5 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="产品名称*" name="name"></div>
                            <div class="col-lg-5 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="品牌" name="brand"></div>
                            <div class="col-lg-5 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="货号" name="productId"></div>
                            <div class="col-lg-5 col-12 mb-25">
                                <select class="form-control form-control-sm nice-select wide" name="category">
                                    <option data-display="产品类型" disabled>默认</option>
                                    <option value="0">类别1</option>
                                    <option value="1">类别2</option>
                                    <option value="2">类别2</option>
                                </select>
                            </div>
                            <div class="col-lg-3 col-12 mb-25" >
                                <input class="form-control form-control-sm" type="text" placeholder="单位" id="unit" onfocusout="changeUnit()" name="unit">
                            </div>
                        </div>
                        <div id="specification">
                            <h4 class="title">产品规格</h4>
                            <div class="row">
                                <div class="col-sm-3 col-12 mb-10"><input class="form-control form-control-sm" type="text" placeholder="规格" name="catogery"></div>
                                <div class="col-sm-3 col-12 mb-10"><input class="form-control form-control-sm" type="number" step="any" placeholder="价格" name="productId"></div>
                                <div class="col-sm-3 col-12 mb-10 input-group" style="height: 36px">
                                    <input class="form-control" type="number" step="any" placeholder="现有库存" name="brand" style="height: 36px">
                                    <div class="input-group-append" style="height: 36px">
                                        <span class="input-group-text" id="unitSpan">G</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
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

                        <div class="row" style="float: right;margin-top: 60px">
                            <div class="col-12 col-lg-auto mb-20" style="float: right">
                                <div class="buttons-group">
                                    <button class="button button-outline button-primary">保存</button>
                                    <button class="button button-outline button-dark" type="reset">清空</button>
                                    <#if product.id??>
                                        <button class="button button-outline button-info">撤销修改</button>
                                        <button class="button button-outline button-danger">删除</button>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
            </div><!-- Add or Edit Product End -->
