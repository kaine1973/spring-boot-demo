<div class="row">
    <div class="col-12 mb-30">
        <div class="box">
            <div class="box-head">
                <div class="row">
                    <div class="col-4">
                        <label for="year">年份</label>
                        <input type="date" class="form-control form-control-sm yearselect" id="year">
                    </div>
                </div>
            </div>
            <div class="box-body">
                <table class="table table-hover">
                    <thead class="thead-light">
                    <tr>
                        <th>客户</th>
                        <th>公司</th>
                        <th>总计</th>
                        <#list [1,2,3,4,5,6,7,8,9,0,11,12] as a>
                            <th>${a}</th>
                        </#list>
                    </tr>
                    </thead>
                    <tbody>
                    <#list contributions as contribution>
                        <tr>
                            <td>${contribution.customerName}</td>
                            <td>${contribution.company}</td>
                            <td>${contribution.jan+contribution.feb+contribution.mar+
                                contribution.apr+contribution.may+contribution.jun+
                                contribution.jul+contribution.aug+contribution.sep+
                                contribution.oct+contribution.nov+contribution.dece}</td>
                            <td>${contribution.jan}</td>
                            <td>${contribution.feb}</td>
                            <td>${contribution.mar}</td>
                            <td>${contribution.apr}</td>
                            <td>${contribution.may}</td>
                            <td>${contribution.jun}</td>
                            <td>${contribution.jul}</td>
                            <td>${contribution.aug}</td>
                            <td>${contribution.sep}</td>
                            <td>${contribution.oct}</td>
                            <td>${contribution.nov}</td>
                            <td>${contribution.dece}</td>
                        </tr>
                    </#list>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>