
            <!-- Page Headings Start -->
            <div class="row justify-content-between align-items-center mb-10">

                <!-- Page Heading Start -->
                <div class="col-12 col-lg-auto mb-20">
                    <div class="page-heading">
                        <h3>产品 <span>/ 管理</span></h3>
                    </div>
                </div><!-- Page Heading End -->

            </div><!-- Page Headings End -->

            <div class="row">

                <!--Manage Product List Start-->
                <div class="col-12">
                    <div class="table-responsive">
                        <table class="table table-vertical-middle">
                            <thead>
                                <tr>
                                    <th hidden>产品ID</th>
                                    <th>名称</th>
                                    <th>品牌</th>
                                    <th>编号</th>
                                    <th>单位</th>
                                    <th>类别</th>
                                    <th>型号</th>
                                    <th>添加日期</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <#if rows??>
                                    <#list rows as product>
                                        <tr>
                                            <td hidden>${product.productId}</td>
                                            <td>${product.productName}</td>
                                            <td>${product.brand}</td>
                                            <td>${product.productSerial}</td>
                                            <td>${product.productUnit}</td>
                                            <td>${product.categoryId}</td>
                                            <td>${product.model}</td>
                                            <td>${product.createDate?datetime}</td>
                                            <td>
                                                <div class="button-group">

                                                </div>
                                            </td>
                                        </tr>
                                    </#list>
                                </#if>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!--Manage Product List End-->

            </div>
