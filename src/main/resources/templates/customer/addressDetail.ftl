<div>
    <form class="form">
        <input type="hidden" id="receiveId" value="<#if address??>${address.id}</#if>">
        <div class="row">
            <div class="col-lg-3 col-12 form-group mb-25">
                <label for="receiveName">联系人</label>
                <input class="form-control form-control-sm" name="receiveName" id="receiveName" value="<#if address??>${address.name}</#if>" placeholder="">
            </div>
            <div class="col-lg-3 col-12 form-group mb-25">
                <label for="receiveCompany">公司</label>
                    <input class="form-control form-control-sm" name="receiveCompany" id="receiveCompany" value="<#if address??>${address.company}</#if>" placeholder="">
            </div>
            <div class="col-lg-3 col-12 form-group mb-25">
                <label for="receivePhone">电话</label>
                    <input class="form-control form-control-sm" name="receivePhone" id="receivePhone" value="<#if address??>${address.phone}</#if>" placeholder="">
            </div>
            <#if container?? && container == "#receiverTBody">
                <div class="col-lg-3 col-12 form-group mb-25">
                    <label for="receiveCustomer">客户</label>
                    <input class="form-control form-control-sm" name="receiveCustomer" id="receiveCustomer" value="" placeholder="">
                </div>
            </#if>

        </div>
        <div class="row mt-5">
            <div class="col-lg-3 col-12 mb-25" >
<#--                <div class="input-group-prepend" style="height:36px" >-->
<#--                    <span class="input-group-text" style="font-size: 13px">地址</span>-->
<#--                </div>-->
                <label for="receiveProvince">省/市/自治区</label>
                <select class="form-control form-control-sm nice-select" name="receiveProvince" id="receiveProvince" onchange="getChildArea('#receiveProvince','#receiveCity','#receiveDistrict')"  style="height:36px">
                    <option data-display="请选择">请选择</option>
                    <#if provinces??>
                        <#list provinces as province>
                            <option class="marker" value="${province.id}" <#if address.provinceId == province.id>selected</#if>>${province.areaName}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <div class="col-lg-2 col-12 mb-25">
                <label for="receiveCity">城市</label>
                <select class="form-control form-control-sm nice-select" data-live-search="true" name="receiveCity" id="receiveCity" onchange="getChildArea('#receiveCity','#receiveDistrict')" style="height:36px">
                    <option data-display="请选择" >请选择</option>
                    <#if cities??>
                        <#list cities as city>
                            <option class="marker" value="${city.id}" <#if address??><#if address.cityId == city.id>selected</#if></#if>>${city.areaName}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <div class="col-lg-2 col-12 mb-25">
                <label for="receiveDistrict">地区</label>
                <select class="form-control form-control-sm nice-select" data-live-search="true" name="receiveDistrict" id="receiveDistrict"  style="height:36px">
                    <option data-display="请选择">请选择</option>
                    <#if districts??>
                        <#list districts as district>
                            <option class="marker" value="${district.id}" <#if address??><#if address.districtId == district.id>selected</#if></#if>>${district.areaName}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <div class="col-lg-5 col-12 mb-25"  style="height:36px">
                <label for="receiveDetail">详细地址</label>
                <input class="form-control form-control-sm" type="text" placeholder="" id="receiveDetail" value="${address.detail}">
            </div>
        </div>
        <input hidden id="sourceRow">
        <div class="row">
            <div class="col-lg-12 col-12">
                <div class="button-group">
                    <button type="button" class="button button-xs button-dark" onclick="closeModal()" >关闭</button>
                    <button type="button" class="button button-xs button-primary" onclick="saveAddress()" >确认</button>
                </div>
            </div>
        </div>
    </form>
</div>