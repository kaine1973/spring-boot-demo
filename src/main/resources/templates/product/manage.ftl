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
<div class="col-lg-2 col-12 accordion accordion-icon" style="background-color: #e2e2e2;min-height: 100%;border-radius: 5px 5px 5px 5px;width: 300px">
    <div class="hide-responsive" style="margin-top: 25px;">
        <h5>分类</h5>
        <div id="categoryBox">
            <ul id="tree" class="ztree" style="min-width:100%; overflow:auto;"></ul>
            <style onload="initCategoryBox('#tree')" ></style>
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
                <button type="button" class="button button-sm button-primary" style="height:36px" onclick="queryByParams(1)">
                    <span><i class="zmdi zmdi-search"></i>搜索</span>
                </button>
                <button type="button" class="button button-sm button-dark" style="height:36px" onclick="resetThenQuery()">
                    <span><i class="zmdi zmdi-refresh"></i>重置</span>
                </button>
            </div>
        </form>
    </div>
</div>
<div class="col-lg-10 col-12" style="height: 500px">
    <div class="row" >
        <div class="col-lg-12 col-12">
            <table class="table table-bordered table-hover table-striped"
                   data-toggle="table"
                   data-height="200">
                <thead class="thead-light">
                <tr>
                    <th hidden>产品ID</th>
                    <th class="hide-responsive">品牌</th>
                    <th style="min-width: 200px;">产品</th>
                    <th class="hide-responsive">编号</th>
                    <th class="hide-responsive">单位</th>
                    <th class="hide-responsive">型号</th>
                    <th class="hide-responsive">库存</th>
                    <th class="hide-responsive">管理</th>
                </tr>
                </thead>
                <tbody id="productBody">
                </tbody>
            </table>
        </div>
    </div>
    <div class="row mt-5">
        <div id="paginationContainer" class="col-12">

        </div>
    </div>
</div>
</div>
<!--Manage Product List End-->
