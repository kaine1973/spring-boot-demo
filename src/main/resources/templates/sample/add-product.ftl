
            <!-- Page Headings Start -->
            <div class="row justify-content-between align-items-center mb-10">

                <!-- Page Heading Start -->
                <div class="col-12 col-lg-auto mb-20">
                    <div class="page-heading">
                        <h3>产品 <span>/ 添加</span></h3>
                    </div>
                </div><!-- Page Heading End -->

                <!-- Page Button Group Start -->
                <div class="col-12 col-lg-auto mb-20">
                    <div class="buttons-group">
                        <button class="button button-outline button-primary">保存</button>
                        <button class="button button-outline button-dark">清空</button>
                        <#if product.id??>
                            <button class="button button-outline button-info">撤销修改</button>
                            <button class="button button-outline button-danger">删除</button>
                        </#if>
                    </div>
                </div><!-- Page Button Group End -->

            </div><!-- Page Headings End -->

            <!-- Add or Edit Product Start -->
            <div class="add-edit-product-wrap col-12">

                <div class="add-edit-product-form">
                    <form action="#">

                        <h4 class="title">基本信息</h4>

                        <div class="row">
                            <div class="col-lg-5 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="产品名称*" name="name"></div>
                            <div class="col-lg-5 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="品牌" name="brand"></div>
                            <div class="col-lg-5 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="货号" name="productId"></div>
                            <div class="col-lg-5 col-12 mb-25">
                                <select class="form-control form-control-sm nice-select wide" name="category">
                                    <option data-display="产品类型" value="0">默认</option>
                                    <option value="1">类别1</option>
                                    <option value="1" disabled>不能选</option>
                                    <option value="2">类别2</option>
                                </select>
                            </div>
                            <div class="col-lg-3 col-12 mb-25" >
                                <input class="form-control form-control-sm" type="text" placeholder="单位" name="unit">
                            </div>
                            <div class="col-lg-5 col-12 mb-25">
                                <select class="form-control form-control-sm select2">
                                    <option value="status">Status</option>
                                    <option value="publish">Publish</option>
                                    <option value="draft">Draft</option>
                                </select>
                            </div>

                            <div class="col-10 mb-25"><textarea class="form-control form-control-sm" placeholder="备注"></textarea></div>
                        </div>

                        <h4 class="title">Product Gallery</h4>

                        <div class="product-upload-gallery row flex-wrap">
                            <div class="col-12 mb-30">
                                <p class="form-help-text mt-0">Upload Maximum 800 x 800 px & Max size 2mb.</p>
                                <input class="file-pond" type="file" multiple>
                            </div>
                        </div>

                        <h4 class="title">Additional Information</h4>


                        <!-- Button Group Start -->
                        <div class="row">
                            <div class="d-flex flex-wrap justify-content-end col mbn-10">
                                <button class="button button-outline button-primary mb-10 ml-10 mr-0">Save & Publish</button>
                                <button class="button button-outline button-info mb-10 ml-10 mr-0">Save to Draft</button>
                                <button class="button button-outline button-danger mb-10 ml-10 mr-0">Delete Product</button>
                            </div>
                        </div><!-- Button Group End -->

                    </form>
                </div>

            </div><!-- Add or Edit Product End -->
