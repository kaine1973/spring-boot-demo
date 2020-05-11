<!-- Page Headings Start -->
<div class="row justify-content-between align-items-center mb-10">

    <!-- Page Heading Start -->
    <div class="col-12 col-lg-auto mb-20">
        <div class="page-heading">
            <h3>客户 <span>/ 管理</span></h3>
        </div>
    </div><!-- Page Heading End -->

</div ><!-- Page Headings End -->
<div class="box">
    <div class="box-head">
        <div class="row">
            <div class="col-3">
                <label for="queryName">姓名</label>
                <input type="text" class="form-control" style="height:36px" id="queryName">
            </div>
            <div class="col-3">
                <label for="queryCompany">公司</label>
                <input type="text" class="form-control" style="height:36px" id="queryCompany">
            </div>
            <div class="col-3">
                <label for="queryLevel">星级</label>
                <select class="form-control" id="queryLevel" style="height: 36px;padding: 5px">
                    <option data-display="请选择" selected value="">请选择</option>
                    <#if levels>
                        <#list levels as level>
                            <option value="${level.id}">${level.levelSign}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <div class="col-3">
                <div class="button-group" style="bottom:0px;position: absolute">
                    <button type="button" class="button button-sm button-primary" style="height:36px" onclick="queryCustomerByParams(1)">搜索</button>
                    <button type="reset" class="button button-sm button-dark" style="height:36px">重置</button>
                </div>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-12">
                <div id="paginationContainer">
                </div>
            </div>
        </div>
        <style onload="customerManageInit()"></style>
    </div>
    <div class="box-body">
        <div class="row" >
            <div class="col-lg-10 col-12">
                <table class="table table-bordered table-hover table-striped"
                       data-toggle="table"
                       data-height="200">
                    <thead class="thead-light">
                    <tr>
                        <th hidden>客户ID</th>
                        <th style="min-width: 200px;">姓名</th>
                        <th class="hide-responsive">公司</th>
                        <th class="hide-responsive">编号</th>
                        <th class="hide-responsive">星级</th>
                        <th class="hide-responsive">电话</th>
                        <th class="hide-responsive">性别</th>
                    </tr>
                    </thead>
                    <tbody id="customerBody">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>