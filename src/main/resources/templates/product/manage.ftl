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
        <div class="col-lg-8 col-12">
            <div class="input-group">
                <div class="input-group-prepend"><span class="input-group-text" style="height: 36px;font-size: 13px">搜索</span></div>
                <input type="text" class="form-control" placeholder="名称" style="height:36px">
                <input type="text" class="form-control hide-responsive" placeholder="品牌" style="height:36px">
                <input type="text" class="form-control hide-responsive" placeholder="编号" style="height:36px">
                <button type="button" class="button button-primary" style="height:36px"><span class="fooicon fooicon-search"></span></button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-10 col-12">
            <table class="table table-bordered table-hover table-striped"
                   data-toggle="table"
                   data-height="200">
                <thead>
                <tr>
                    <th hidden>产品ID</th>
                    <th >产品列表</th>
                    <th class="hide-responsive">品牌</th>
                    <th class="hide-responsive">编号</th>
                    <th class="hide-responsive">单位</th>
                    <th class="hide-responsive">类别</th>
                    <th class="hide-responsive">型号</th>
                    <th class="hide-responsive">添加日期</th>
                    <th class="hide-responsive">操作</th>
                </tr>
                </thead>
                <tbody>
                <#if rows??>
                    <#list rows as product>
                        <tr height="41px" onclick="showInfoModal(this)">
                            <td hidden>${product.productId}</td>
                            <td>${product.productName}</td>
                            <td class="hide-responsive">${product.brand}</td>
                            <td class="hide-responsive">${product.productSerial}</td>
                            <td class="hide-responsive">${product.productUnit}</td>
                            <td class="hide-responsive">${product.categoryId}</td>
                            <td class="hide-responsive">${product.model}</td>
                            <td class="hide-responsive">${product.createDate?datetime}</td>
                            <td class="hide-responsive">
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
<div class="row mt-5">
    <div class="col-sm-10 col-10 button-group">
        <#if page??>
            <#if page.currentPage gt 1>
                <button class="button button-info"><<</button>
            </#if>
        </#if>
        <button class="button button-info">1</button>
        <button class="button button-info">2</button>
        <button class="button button-info">3</button>
        <#if page??>
            <#if page.pageNum gt 3>
                <button class="button button-info">...</button>
                <button class="button button-info">>></button>
            </#if>
        </#if>
    </div>
</div>
    <!--Manage Product List End-->