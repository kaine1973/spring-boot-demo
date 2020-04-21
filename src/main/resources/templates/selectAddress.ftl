<div class="row">
    <div class="col-lg-6 col-12" style="border-right: groove">
        <h6>选择客户：</h6>
        <div class="row">
            <div class="col-sm-12 col-12">
                <div class="input-group">
                    <input class="form-control form-control-sm" style="height:36px" placeholder="姓名" id="queryName">
                    <input class="form-control form-control-sm" style="height:36px" placeholder="公司" id="queryCompany">
                    <div class="input-group-append">
                        <button class="button button-box button-primary input-group-btn" style="height:36px" type="button" >
                            <i class="zmdi zmdi-search"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <table class="table">
<#--                    <thead>-->
<#--                        <tr>-->
<#--                            <td>姓名</td>-->
<#--                            <td>公司</td>-->
<#--                        </tr>-->
<#--                    </thead>-->
                    <tbody id="addressCustomerTBody">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-lg-6 col-12" style="justify-content: center">
        <h6>选择地址：</h6>
        <div class="col-sm-12 col-12" id="selectAddressBody">
            <span >从左侧选择</span>
        </div>
    </div>
</div>