<div class="row justify-content-between align-items-center mb-10">

    <!-- Page Heading Start -->
    <div class="col-12 col-lg-auto mb-20">
        <div class="page-heading">
            <h3>订单</h3>
        </div>
    </div><!-- Page Heading End -->

    <!-- Page Button Group Start -->
    <!-- Page Button Group End -->

</div><!-- Page Headings End -->
<div>
        <div class="box">
            <div class="box-head">
                <h5 class="title" style="display: inline">发货:</h5>
                <div class="button-group" style="float:right">
                    <button class="button button-sm button-success" style="height: 30px;" onclick="showInfoModalWithSenderAddress()">选择</button>
                </div>
            </div>
            <div class="box-body">
                <form>
                    <div class="row mbn-20">
                        <div class="col-sm-4 col-12 mb-20">
                            <label for="senderName">销售</label>
                            <input type="text" id="senderName" class="form-control form-control-sm" placeholder="">
                        </div>
                        <div class="col-sm-4 col-12 mb-20">
                            <label for="senderCompany">公司</label>
                            <input type="text" id="senderCompany" class="form-control form-control-sm" placeholder="">
                        </div>
                        <div class="col-sm-4 col-12 mb-20">
                            <label for="senderPhone">电话</label>
                            <input type="text" id="senderPhone" class="form-control form-control-sm" placeholder="">
                        </div>
                    </div>
                    <div class="row mt-5 mbn-20">
                        <div class="col-lg-2 col-12 mb-15">
                            <label for="senderProvince">省/市/自治区</label>
                            <select id="senderProvince" class="form-control form-control-sm" onchange="getChildArea(this)">
                                <#list provinces as province>
                                    <option value="${province.id}">${province.areaName}</option>
                                </#list>
                            </select>
                        </div>
                        <div class="col-lg-2 col-12 mb-15">
                            <label for="senderCity">城市</label>
                            <select id="senderCity" class="form-control form-control-sm" onchange="getChildArea(this)">
                            </select>
                        </div>
                        <div class="col-lg-2 col-12 mb-15">
                            <label for="senderDistrict">区域</label>
                            <select id="senderDistrict" class="form-control form-control-sm">
                            </select>
                        </div>
                        <div class="col-lg-6 col-12 mb-20">
                            <label for="senderAddress">详细地址</label>
                            <input type="text" id="senderAddress" class="form-control form-control-sm" placeholder="">
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="box">
            <div class="box-head">
                <h5 class="title" style="display: inline;">收货:</h5>
                <div class="button-group" style="float: right">
                    <button class="button button-sm button-success" style="height: 30px;" onclick="showAddressBook()">选择</button>
                </div>
            </div>
            <div class="box-body">
                <form>
                    <div class="row mbn-20">
                        <div class="col-sm-4 col-12 mb-20">
                            <label for="receiverName">收货人</label>
                            <input type="text" id="receiverName" class="form-control form-control-sm" placeholder="">
                        </div>
                        <div class="col-sm-4 col-12 mb-20">
                            <label for="receiverCompany">客户</label>
                            <input type="text" id="receiverCompany" class="form-control form-control-sm" placeholder="">
                        </div>
                        <div class="col-sm-4 col-12 mb-20">
                            <label for="receiverPhone">电话</label>
                            <input type="text" id="receiverPhone" class="form-control form-control-sm" placeholder="">
                        </div>
                    </div>
                    <div class="row mt-5 mbn-20">
                        <div class="col-lg-2 col-12 mb-15">
                            <label for="receiverProvince">省/市/自治区</label>
                            <select id="receiverProvince" class="form-control form-control-sm" onchange="getChildArea(this)">
                                <option data-display="请选择" style="min-width: 113px" selected value="0">请选择</option>
                                <#list provinces as province>
                                    <option value="${province.id}">${province.areaName}</option>
                                </#list>
                            </select>
                        </div>
                        <div class="col-lg-2 col-12 mb-15">
                            <label for="receiverCity">城市</label>
                            <select id="receiverCity" class="form-control form-control-sm" onchange="getChildArea(this)">
                                <option data-display="请选择" >请选择</option>
                            </select>
                        </div>
                        <div class="col-lg-2 col-12 mb-15">
                            <label for="receiverDistrict">区域</label>
                            <select id="receiverDistrict" class="form-control form-control-sm">
                            </select>
                        </div>
                        <div class="col-lg-6 col-12 mb-20">
                            <label for="receiverAddress">详细地址</label>
                            <input type="text" id="receiverAddress" class="form-control form-control-sm" placeholder="">
                        </div>
                    </div>
                </form>
            </div>
        </div>

    <div class="box">
        <div class="box-head">
            <h5 class="title" style="display: inline;">其他:</h5>
        </div>
        <div class="box-body">
            <form>
                <div class="row mbn-20">
                    <div class="col-lg-2 col-12 mb-15">
                        <label for="invoiceType">开票类型</label>
                        <select id="invoiceType" name="invoiceType" class="form-control form-control-sm">
                            <option value="0" selected>无</option>
                            <option value="1">普通发票</option>
                            <option value="2">增值税专用发票</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-12 mb-15">
                        <label for="payment">付款方式</label>
                        <select id="payment" name="payment" class="form-control form-control-sm">
                            <option value="0" selected>无</option>
                            <option value="1">货到付款</option>
                            <option value="2">款到发货</option>
                        </select>
                    </div>
                    <div class="col-lg-2 col-12 mb-15">
                        <label for="delivery">送货方式</label>
                        <select id="delivery" name="delivery" class="form-control form-control-sm">
                            <option value="0" selected>无</option>
                            <option value="1">邮寄</option>
                            <option value="2">其他</option>
                        </select>
                    </div>
                    <div class="col-sm-4 col-12 mb-20">
                        <label for="other">其他</label>
                        <input type="text" id="other" class="form-control form-control-sm" placeholder="">
                    </div>
                </div>

            </form>
        </div>
    </div>

    <script>
        function toggleDetails(e,addressContainer){
            if ($(e).is(':checked') && $(e).val() === '1') {
                $(addressContainer).removeAttr('hidden')
                $(addressContainer).attr('open','open')
            }else{
                $(addressContainer).attr('hidden','hidden')
                $(addressContainer).removeAttr('open')
            }
        }
    </script>
    <div class="box">
        <div class="box-head">
            <h5 class="title" style="display: inline;">商品信息:</h5>
        </div>
        <div class="box-body">
            <div class="row">
                <div class="col-12 table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead >
                        <th>序号</th><th>品牌</th><th>名称</th><th>规格</th><th>单位</th><th>数量</th><th>售价</th><th>操作</th>
                        </thead>
                        <#if stockOperations??>
                            <#list stockOperations as operation>
                                <tr>
                                    <td hidden>${operation.id}</td><td>${operation?index+1}</td>
                                    <td>${operation.productBrand}</td>
                                    <td>${operation.productName}</td><td hidden>${operation.specificationId}</td>
                                    <td>${operation.specificationName}</td>
                                    <td>${operation.productUnit}</td>
                                    <td>${operation.amount}</td>
                                    <td style="max-width: 50px;">${operation.price}</td>
                                    <td><button class="button button-xs button-box"><i class="zmdi zmdi-delete"></i></button>
                                        <button class="button button-xs button-box" ><i class="zmdi zmdi-edit"></i></button></td>
                                </tr>
                            </#list>
                        </#if>
                    </table>
                </div>
            </div>
        </div>
    </div>



</div>
