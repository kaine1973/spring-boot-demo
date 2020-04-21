<!-- Page Headings Start -->
<div class="row justify-content-between align-items-center mb-10">

    <!-- Page Heading Start -->
    <div class="col-12 col-lg-auto mb-20">
        <div class="page-heading">
            <h3>客户 <span>/ 管理</span></h3>
        </div>
    </div><!-- Page Heading End -->

</div ><!-- Page Headings End -->
<div class="row">
<div class="col-lg-3 col-12 accordion accordion-icon" style="background-color: #e2e2e2;min-height: 100%;border-radius: 5px 5px 5px 5px">
    <div class="mt-15 mb-25" >
        <h5>搜索</h5>
        <form id="search" style="max-width: 95%">
            <div class="form-group mt-2">
                <label for="queryName">姓名</label>
                <input type="text" class="form-control" style="height:36px" id="queryName">
            </div>
            <div class="form-group mt-2 hide-responsive">
                <label for="queryCompany">公司</label>
                <input type="text" class="form-control" style="height:36px" id="queryCompany">
            </div>
<#--            <div class="form-group mt-2 hide-responsive">-->
<#--                <label for="querySerial">地区</label>-->
<#--                <input type="text" class="form-control" style="height:36px" id="querySerial">-->
<#--            </div>-->
            <div class="form-group mt-2 hide-responsive">
                <label for="queryLevel">星级</label>
                <select class="form-control" id="queryLevel">
                    <option data-display="星级"selected value="">星级</option>
                    <#if levels>
                        <#list levels as level>
                            <option value="${level.id}">${level.levelSign}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <div class="button-group mt-2">
                <button type="button" class="button button-sm button-primary" style="height:36px" onclick="queryCustomerByParams(1)">
                    <span><i class="zmdi zmdi-search"></i>搜索</span>
                </button>
                <button type="reset" class="button button-sm button-dark" style="height:36px">
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
                    <th hidden>客户ID</th>
                    <th style="min-width: 200px;">姓名</th>
                    <th class="hide-responsive">公司</th>
                    <th class="hide-responsive">编号</th>
                    <th class="hide-responsive">星级</th>
                    <th class="hide-responsive">电话</th>
                    <th class="hide-responsive">地址</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row mt-5">
        <div class="col-sm-7 col-10">
            <div id="paginationContainer">
                <div class="pagination">
                    <a href="#" class="first" data-action="first">&laquo;</a>
                    <a href="#" class="previous" data-action="previous">&lsaquo;</a>
                    <input id="paginationText" type="text" readonly="readonly" data-max-page="40" />
                    <a href="#" class="next" data-action="next">&rsaquo;</a>
                    <a href="#" class="last" data-action="last">&raquo;</a>
                </div>
            </div>
        </div>
<#--        <div class="col-sm-3 col-10">-->
<#--            <div class="input-group">-->
<#--                <div class="input-group-prepend">-->
<#--                    <span class="input-group-text">每页行数</span>-->
<#--                </div>-->
<#--                <input class="form-control form-control-sm" type="number" value="15" id="pageSize">-->
<#--            </div>-->
<#--        </div>-->
    </div>
</div>
    <style onload="customerManageInit()"></style>
</div>
<!--Manage Product List End-->
