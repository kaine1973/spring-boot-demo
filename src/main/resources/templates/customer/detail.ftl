
            <!-- Page Headings Start -->
            <div class="row justify-content-between align-items-center mb-10">

                <!-- Page Heading Start -->
                <div class="col-12 col-lg-auto mb-20">
                    <div class="page-heading">
                        <h3>客户 <span>/ <#if product??>修改信息<#else>新增</#if></span></h3>
                    </div>
                </div><!-- Page Heading End -->

                <!-- Page Button Group Start -->
                <!-- Page Button Group End -->

            </div><!-- Page Headings End -->

            <!-- Add or Edit Product Start -->
            <div >

                <div class="add-edit-product-form">
                    <form onsubmit="return false">

                        <h4 class="title">基本信息</h4>

                        <div class="row">
                            <input  type="hidden" id="id" name="id" <#if customer??>value="${customer.id}"</#if>>
                            <div class="col-lg-4 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="姓名*" id="customerName" value="<#if customer??>customer.customerName</#if>"></div>
                            <div class="col-lg-4 col-12 mb-25"><input class="form-control form-control-sm" type="text" placeholder="公司" id="company" value="<#if customer??>customer.company</#if>"></div>
                            <div class="col-lg-4 col-12 mb-25">
                                <select class="form-control form-control-sm nice-select" id="position" name="position">
                                    <option data-display="职务" >职务</option>
                                    <#if positions??>
                                        <#list positions as position>
                                            <option value="${position.id}"
                                            <#if customer??>
                                                <#if (customer.positionId == position.id) >
                                                     default
                                                </#if>
                                            </#if>>${position.positionName}</option>
                                        </#list>
                                    </#if>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4 col-12 mb-25">
                                <select class="form-control form-control-sm nice-select" id="gender" name="gender">
                                    <option data-display="性别" >性别</option>
                                    <option value="0"
                                        <#if customer??>
                                            <#if customer.gender == '0'>
                                                 default
                                            </#if>
                                        </#if>
                                    >男</option>
                                    <option value="1"
                                        <#if customer??>
                                            <#if customer.gender == '1'>
                                                default
                                            </#if>
                                        </#if>
                                    >女</option>
                                </select>
                            </div>
                            <div class="col-lg-4 col-12 mb-25">
                                <input class="form-control form-control-sm" type="text" placeholder="联系电话" id="phone" name="phone">
                            </div>
                            <div class="col-lg-4 col-12 mb-25 input-group" >
                                <input class="form-control form-control-sm" style="height: 36px" type="text" placeholder="客户编号" id="customerId" name="customerId">
                                <div class="input-group-append" >
                                    <button class="button button-box" type="button" style="height: 36px" ><i class="zmdi zmdi-lamp"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-3 col-12 mb-25 input-group"  style="height:36px" >
                                <div class="input-group-prepend" style="height:36px" >
                                    <span class="input-group-text" style="font-size: 13px">地址</span>
                                </div>
                                <select class="form-control form-control-sm nice-select" data-live-search="true" id="province" onchange="getChildArea(this,'#city')"  style="height:36px">
                                    <option data-display="省/市/自治区" >省/市/自治区</option>
                                    <#if provinces??>
                                        <#list provinces as province>
                                            <option class="marker" value="${province.id}">${province.areaName}</option>
                                        </#list>
                                    </#if>
                                </select>
                            </div>
                            <div class="col-lg-2 col-12 mb-25">
                                <select class="form-control form-control-sm nice-select" data-live-search="true" id="city" onchange="getChildArea(this,'#district')" style="height:36px">
                                    <option data-display="城市" >城市</option>
                                    <#if cities??>
                                        <#list cities as city>
                                            <option class="marker" value="${city.id}">${city.areaName}</option>
                                        </#list>
                                    </#if>
                                </select>
                            </div>
                            <div class="col-lg-2 col-12 mb-25">
                                <select class="form-control form-control-sm nice-select" data-live-search="true" id="district"  style="height:36px">
                                    <option data-display="地区">地区</option>
                                    <#if districts??>
                                        <#list districts as district>
                                            <option class="marker" value="${district.id}">${district.areaName}</option>
                                        </#list>
                                    </#if>
                                </select>
                            </div>
                            <div class="col-lg-5 col-12"  style="height:36px">
                                <input class="form-control form-control-sm" type="text" placeholder="详细地址" id="addressDetail">
                            </div>
                        </div>

                        <h4 class="title" style="margin-top: 23px">其他信息</h4>

                        <div class="row">
                            <div class="col-lg-4 col-12 mb-25 input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" style="height: 36px;font-size: 13px">星级</span>
                                </div>
                                <select class="form-control form-control-sm nice-select" style="height: 36px" id="level">
                                    <#if levels>
                                        <#list levels as level>
                                            <option value="${level.id}">${level.levelSign}</option>
                                        </#list>
                                    </#if>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-5 col-12 mb-25">
                                <textarea class="form-control" placeholder="备注" style="margin-top: 0px; margin-bottom: 0px; height: 123px;" id="note"></textarea>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-12 ml-0" style="margin-top: 40px;">
                                <#if product.id??>
                                    <button class="button button-danger"><span><i class="zmdi zmdi-delete"></i>删除</span></button>
                                    <button class="button button-success"><span><i class="zmdi zmdi-refresh"></i>撤销</span></button>
                                    <#else >
                                        <button class="button button-dark" type="button" onclick="cleanForm()" ><span><i class="zmdi zmdi-refresh"></i>清空</span></button>
                                </#if>
                                <button class="button button-primary" onclick="uploadCustomerDetail(this)"><span><i class="zmdi zmdi-save"></i>保存</span></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div><!-- Add or Edit Product End -->

