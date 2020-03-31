<!-- Page Headings Start -->
<div class="row justify-content-between align-items-center mb-10">

    <!-- Page Heading Start -->
    <div class="col-12 col-lg-auto mb-20">
        <div class="page-heading">
            <h3>产品 <span>/ 管理</span></h3>
        </div>
    </div><!-- Page Heading End -->

</div ><!-- Page Headings End -->
<div class="row">
<div class="col-lg-3 col-12 accordion accordion-icon" style="background-color: #e2e2e2;min-height: 100%;border-radius: 5px 5px 5px 5px">
    <div class="hide-responsive" style="margin-top: 25px;">
        <h5>分类</h5>
        <div id="categoryBox">
            <ul id="tree" class="ztree" style="min-width:100%; overflow:auto;"></ul>
        </div>
    </div>

    <div class="mt-15 mb-25" >
        <h5>搜索</h5>
        <form id="search" style="max-width: 95%">
            <div class="form-group mt-2">
                <label for="queryName">产品名称</label>
                <input type="text" class="form-control" style="height:36px" id="queryName">
            </div>
            <div class="form-group mt-2 hide-responsive">
                <label for="queryBrand">品牌</label>
                <input type="text" class="form-control" style="height:36px" id="queryBrand">
            </div>
            <div class="form-group mt-2 hide-responsive">
                <label for="querySerial">编号</label>
                <input type="text" class="form-control" style="height:36px" id="querySerial">
            </div>
            <div class="button-group mt-2">
                <button type="button" class="button button-sm button-primary" style="height:36px" onclick="queryByParams(0)">
                    <span><i class="zmdi zmdi-search"></i>搜索</span>
                </button>
                <button type="button" class="button button-sm button-dark" style="height:36px" onclick="resetThenQuery()">
                    <span><i class="zmdi zmdi-refresh"></i>重置</span>
                </button>
            </div>
        </form>
    </div>
</div>
<div class="col-lg-9 col-12" style="height: 500px">
    <div class="row" >
        <div class="col-lg-10 col-12">
            <table class="table table-bordered table-hover table-striped"
                   data-toggle="table"
                   data-height="200">
                <thead>
                <tr>
                    <th hidden>产品ID</th>
                    <th style="min-width: 200px;">产品列表</th>
                    <th class="hide-responsive">品牌</th>
                    <th class="hide-responsive">编号</th>
                    <th class="hide-responsive">单位</th>
                    <th class="hide-responsive">型号</th>
                    <th class="hide-responsive">添加日期</th>
                    <th class="hide-responsive">管理</th>
                </tr>
                </thead>
                <tbody>
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
        <#--    <div class="col-sm-10 col-10 button-group">-->
        <#--        <div class="input-group-prepend">-->
        <#--            <span class="input-group-text">每页行数</span>-->
        <#--        </div>-->
        <#--        <input class="form-control form-control-lg" type="number" value="15" id="pageSize">-->
        <#--    </div>-->
    </div>
</div>
</div>
<!--Manage Product List End-->

<style onload="initCategoryBox('#tree')" ></style>