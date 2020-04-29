<div>
    <form class="form">
        <input type="hidden" id="receiverId" value="
        <#if address??>
            address.id
        </#if>
         ">
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
                <select class="form-control form-control-sm nice-select" name="receiveProvince" id="receiveProvince" onchange="getChildArea(this)"  style="height:36px">
                    <#if provinces??>
                        <#list provinces as province>
                            <option class="marker" value="${province.id}" <#if address??><#if address.provinceId == province.id>default</#if></#if>>${province.areaName}</option>
                        </#list>
                    </#if>
                </select>
                <#if provinces??>
                <#else>
                    <style onload="getChildArea('#province','#province')"></style>
                </#if>
            </div>
            <div class="col-lg-2 col-12 mb-25">
                <label for="receiveCity">城市</label>
                <select class="form-control form-control-sm nice-select" data-live-search="true" name="receiveCity" id="receiveCity" onchange="getChildArea(this)" style="height:36px">
                    <option data-display="请选择" >请选择</option>
                    <#if cities??>
                        <#list cities as city>
                            <option class="marker" value="${city.id}" <#if address??><#if address.cityId == city.id>default</#if></#if>>${city.areaName}</option>
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
                            <option class="marker" value="${district.id}" <#if address??><#if address.districtId == district.id>default</#if></#if>>${district.areaName}</option>
                        </#list>
                    </#if>
                </select>
            </div>
            <div class="col-lg-5 col-12 mb-25"  style="height:36px">
                <label for="receiveDetail">详细地址</label><input class="form-control form-control-sm" type="text" placeholder="" id="receiveDetail">
            </div>
        </div>
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