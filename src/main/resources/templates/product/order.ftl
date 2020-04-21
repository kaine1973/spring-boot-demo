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
    <div class="row mt-15">
            <div class="col-lg-4 col-12 ml-15" style="">
                <h5>发货人:</h5>
                <div class="adomx-checkbox-radio-group mt-5">
                    <#if senderAddresses??>
                        <#list senderAddresses as address>
                            <label class="adomx-radio-2"><input type="radio" name="sender" checked onchange="toggleDetails(this,'#senderAddress')"> <i class="icon"></i>
                                <span> ${address.name} - ${address.phone} <br> ${address.province} - ${address.city} - ${address.district} - ${address.detail}</span></label>
                        </#list>
                    </#if>

<#--                    <div class="row mt-3">-->
<#--                        <label class="adomx-radio-2"><input type="radio" name="sender" value="1" onchange="toggleDetails(this,'#senderAddress')"> <i class="icon"></i>-->
<#--                            手动添加-->
<#--                        </label>-->
<#--                    </div>-->
                </div>
                <div class="mt-3">
                    <details id="senderAddress" hidden >
                        <div class="row">
                            <div class="col-sm-4 col-12 input-group mt-1">
                                <div class="input-group-prepend" style="height: 36px;">
                                    <span class="input-group-text">发件人</span>
                                </div>
                                <input class="form-control form-control-sm" name="name">
                            </div>
                            <div class="col-sm-4 col-12 input-group mt-1">
                                <div class="input-group-prepend" style="height: 36px;">
                                    <span class="input-group-text">公司</span>
                                </div>
                                <input class="form-control form-control-sm" name="company">
                            </div>
                            <div class="col-sm-4 col-12 input-group mt-1">
                                <div class="input-group-prepend" style="height: 36px;">
                                    <span class="input-group-text">电话</span>
                                </div>
                                <input type="tel" class="form-control form-control-sm" name="company">
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-lg-3 col-12 mt-1 input-group"  style="height:36px" >
                                <div class="input-group-prepend" style="height:36px" >
                                    <span class="input-group-text" style="font-size: 13px">地址</span>
                                </div>
                                <select class="form-control form-control-sm nice-select" id="province" onchange="getChildArea(this,'#senderCity')"  style="height:36px">
                                    <option data-display="省/市/自治区" style="min-width: 113px" selected value="0">省/市/自治区</option>
                                    <#if provinces??>
                                        <#list provinces as province>
                                            <option class="marker" value="${province.id}">${province.areaName}</option>
                                        </#list>
                                    </#if>
                                </select>
                                <#if provinces??>
                                <#else>
                                    <style onload="getChildArea('#province','#province')"></style>
                                </#if>
                            </div>
                            <div class="col-lg-2 col-12 mt-1">
                                <select class="form-control form-control-sm nice-select" data-live-search="true" id="senderCity" onchange="getChildArea(this,'#senderDistrict')" style="height:36px">
                                    <option data-display="城市" >城市</option>
                                    <#if cities??>
                                        <#list cities as city>
                                            <option class="marker" value="${city.id}">${city.areaName}</option>
                                        </#list>
                                    </#if>
                                </select>
                            </div>
                            <div class="col-lg-2 col-12 mt-1">
                                <select class="form-control form-control-sm nice-select" data-live-search="true" id="senderDistrict"  style="height:36px">
                                    <option data-display="地区">地区</option>
                                    <#if districts??>
                                        <#list districts as district>
                                            <option class="marker" value="${district.id}">${district.areaName}</option>
                                        </#list>
                                    </#if>
                                </select>
                            </div>
                            <div class="col-lg-5 col-12 mt-1"  style="height:36px">
                                <input class="form-control form-control-sm" type="text" placeholder="详细地址" id="senderAddressDetail">
                            </div>
                        </div>
                    </details>
                </div>
            </div>

            <div class="col-lg-7 col-12 ml-15">
            <h5 style="display: inline">收货人:</h5><button class="button button-sm button-primary" style="height: 30px" onclick="showAddressBook()">选择</button>
                <div class="adomx-checkbox-radio-group mt-5">
                    <label class="adomx-radio-2" id="selectReceiver"><input type="radio" name="receiver" checked value="0" onchange="toggleDetails(this,'#manuallyAddress')"> <i class="icon"></i>
                        <span>未选择</span>
                    </label>

                    <label class="adomx-radio-2"><input type="radio" name="receiver" value="1" onchange="toggleDetails(this,'#manuallyAddress')"> <i class="icon"></i>
                        手动添加
                    </label>
                </div>
                <div class="mt-3">
                    <details id="manuallyAddress" hidden>
                        <div class="row">
                            <div class="col-sm-4 col-12 input-group mt-1">
                                <div class="input-group-prepend" style="height: 36px;">
                                    <span class="input-group-text">收件人</span>
                                </div>
                                <input class="form-control form-control-sm" name="name">
                            </div>
                            <div class="col-sm-4 col-12 input-group mt-1">
                                <div class="input-group-prepend" style="height: 36px;">
                                    <span class="input-group-text">公司</span>
                                </div>
                                <input class="form-control form-control-sm" name="company">
                            </div>
                            <div class="col-sm-4 col-12 input-group mt-1">
                                <div class="input-group-prepend" style="height: 36px;">
                                    <span class="input-group-text">电话</span>
                                </div>
                                <input type="tel" class="form-control form-control-sm" name="company">
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-lg-3 col-12 mt-1 input-group"  style="height:36px;padding-right: 1px" >
                                <div class="input-group-prepend" style="height:36px" >
                                    <span class="input-group-text" style="font-size: 13px">地址</span>
                                </div>
                                <select class="form-control form-control-sm nice-select" id="province" onchange="getChildArea(this,'#city')"  style="height:36px">
                                    <option data-display="省/市/自治区" style="min-width: 113px" selected value="0">省/市/自治区</option>
                                    <#if provinces??>
                                        <#list provinces as province>
                                            <option class="marker" value="${province.id}">${province.areaName}</option>
                                        </#list>
                                    </#if>
                                </select>
                                <#if provinces??>
                                <#else>
                                    <style onload="getChildArea('#province','#province')"></style>
                                </#if>
                            </div>
                            <div class="col-lg-2 col-12 mt-1" style="padding-left: 1px;padding-right: 1px">
                                <select class="form-control form-control-sm nice-select" data-live-search="true" id="city" onchange="getChildArea(this,'#district')" style="height:36px">
                                    <option data-display="城市" >城市</option>
                                    <#if cities??>
                                        <#list cities as city>
                                            <option class="marker" value="${city.id}">${city.areaName}</option>
                                        </#list>
                                    </#if>
                                </select>
                            </div>
                            <div class="col-lg-2 col-12 mt-1" style="padding-left: 1px;padding-right: 1px">
                                <select class="form-control form-control-sm nice-select" data-live-search="true" id="district"  style="height:36px;padding-right: 1px">
                                    <option data-display="地区">地区</option>
                                    <#if districts??>
                                        <#list districts as district>
                                            <option class="marker" value="${district.id}">${district.areaName}</option>
                                        </#list>
                                    </#if>
                                </select>
                            </div>
                            <div class="col-lg-5 col-12 mt-1"  style="height:36px;padding-left: 1px">
                                <input class="form-control form-control-sm" type="text" placeholder="详细地址" id="receiverAddressDetail">
                            </div>
                        </div>
                    </details>
                </div>
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
    <div class="mt-15">
        <h5>商品信息:</h5>
        <div class="row">
            <div class="col-12">
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
