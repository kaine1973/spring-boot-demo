<div class="row">
<div class="col-12">

    <div class="smart-wizard" id="smartWizard">
        <ul>
            <li><a href="#step-1">选择客户</a></li>
            <li><a href="#step-2">选择地址</a></li>
        </ul>
        <div>
            <div id="step-1">
                <div class="box" style="min-height: 335px">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-12">
                                <div class="input-group">
                                    <input class="form-control form-control-sm" style="height:36px" placeholder="姓名" id="queryName">
                                    <input class="form-control form-control-sm" style="height:36px" placeholder="公司" id="queryCompany">
                                    <div class="input-group-append">
                                        <button class="button button-box button-primary" style="height:36px" type="button" onclick="queryAddressCustomerByParams(1)">
                                            <i class="zmdi zmdi-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <table class="table">
                                    <tbody id="addressCustomerTBody">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="step-2">
                <div class="box" style="min-height: 335px">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-12" id="selectAddressBody">
                                <span >先选择客户</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
</div>