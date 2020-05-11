

<h4 class="title"><#if type?? && type == "STOCK_OUT">出库<#else>入库</#if>记录</h4>
<div class="row">
    <div class="col-12 mb-30">
        <div class="box">
            <div class="box-head">
                <h6>搜索：</h6>
                <div class="row">
                    <div class="col-lg-3 col-12 mb-5">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">产品</span>
                            </div>
                            <input id="productLike" type="text" class="form-control form-control-sm">
                        </div>
                    </div>
                    <div class="col-lg-3 col-12 mb-5">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">销售</span>
                            </div>
                            <select id="userId" type="text" class="form-control form-control-sm">
                                <option value="">所有</option>
                                <#list users!"" as user>
                                    <option value="${user.id}">${user.userName}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-4 col-12 mb-5">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">日期</span>
                            </div>
                            <input id="date-range" type="text" class="form-control form-control-sm">
                        </div>
                    </div>
                    <div class="col-lg-2 col-12 mb-5">
                        <input type="hidden" value="${type}" id="type">
                        <div class="button-group">
                            <button class="button button-sm button-primary" style="height: 36px;" onclick="doStockQuery()">搜索</button>
                            <button class="button button-sm button-dark" style="height: 36px;" onclick="resetSearch()">重置</button>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div id="pagination-container"></div>
                    </div>
                </div>
            </div>
            <div class="box-body">
                <table class="table table-hover">
                    <thead class="thead-light">
                    <tr>
                        <th>日期</th>
                        <th>品牌</th>
                        <th>产品</th>
                        <th>编号</th>
                        <th>规格</th>
                        <th>数量</th>
                        <th>售价</th>
                        <th>操作人</th>
                    </tr>
                    </thead>
                    <#assign typeo = type>
                    <tbody id="stockBody">
                        <#if stockOperations??>
                            <#list stockOperations as operation>
                                <tr>
                                    <td>${operation.confirmDate?string('yyyy.MM.dd HH:mm:ss')}</td>
                                    <td>${operation.productBrand}</td>
                                    <td>${operation.productName}</td>
                                    <td>${operation.productSerial}</td>
                                    <td>${operation.specificationName}</td>
                                    <td>${operation.amount}</td>
                                    <td>${operation.dealPrice!operation.price}</td>
                                    <td>${operation.userName}</td>
                                </tr>
                            </#list>
                        </#if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <style onload="initStockHistory()"></style>
</div>
