<div class="box">
    <div class="box-body">
        <form class="form">
            <div class="row">
                <div class="col-12 mt-5">
                    <input type="hidden" id="operationId"
                           value="<#if stockOperation??>${stockOperation.id}</#if>"
                    >
                    <label for="productName">产品名称</label>
                    <input id="productName" type="text" class="form-control form-control-sm" name="" readonly
                    value="<#if stockOperation??>${stockOperation.productName}</#if>"
                    >
                </div>
                <div class="col-12 mt-5">
                    <label for="productBrand">品牌</label>
                    <input id="productBrand" type="text" class="form-control form-control-sm" name="" readonly
                           value="<#if stockOperation??>${stockOperation.productBrand}</#if>"
                    >
                </div>
                <div class="col-12 mt-5">
                    <label for="specificationName">规格</label>
                    <input type="hidden" id="specificationId"
                           value="<#if stockOperation??>${stockOperation.specificationId}</#if>"
                    >
                    <input id="specificationName" type="text" class="form-control form-control-sm" name="" readonly
                           value="<#if stockOperation??>${stockOperation.specificationName}</#if>"
                    >
                </div>
                <div class="col-12 mt-5">
                    <label for="unit">单位</label>
                    <input id="unit" type="text" class="form-control form-control-sm" name="" readonly
                           value="<#if stockOperation??>${stockOperation.productUnit}</#if>"
                    >
                </div>
                <div class="col-12 mt-5">
                    <label for="price">价格</label>
                    <input id="price" type="text" class="form-control form-control-sm" name="" readonly
                           value="<#if stockOperation??>${stockOperation.price}</#if>"
                    >
                </div>
                <div class="col-12 mt-5">
                    <label for="amount">数量</label>
                    <input id="amount" type="text" class="form-control form-control-sm info" name=""
                           value="<#if stockOperation??>${stockOperation.amount}</#if>"
                    >
                </div>
                <div class="col-12 mt-5">
                    <label for="dealPrice">售价</label>
                    <input id="dealPrice" type="text" class="form-control form-control-sm info" name=""
                           value="<#if stockOperation??>${stockOperation.dealPrice!stockOperation.price}</#if>"
                    >
                </div>
            </div>
        </form>
    </div>
    <div class="box-foot">
        <div class="button-group">
            <button class="button button-sm button-primary" onclick="alterStockOperation()" type="button">确认</button>
            <button class="button button-sm button-dark" onclick="closeModal()" type="button">取消</button>
        </div>
    </div>
</div>