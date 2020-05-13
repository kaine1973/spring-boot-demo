
            <!-- Page Headings Start -->
            <div class="row justify-content-between align-items-center mb-10">

                <!-- Page Heading Start -->
                <div class="col-12 col-lg-auto mb-20">
                    <div class="page-heading">
                        <h3>客户 <span>/ <#if customer??>修改信息<#else>新增</#if></span></h3>
                    </div>
                </div><!-- Page Heading End -->

                <!-- Page Button Group Start -->
                <!-- Page Button Group End -->

            </div><!-- Page Headings End -->

            <!-- Add or Edit Product Start -->
            <div class="box" style="max-width: 1200px;" id="customerForm">
                <div class="box-head">
                    <h4 class="title">基本信息</h4>
                </div>
                <div class="box-body">
                    <div class="row">
                        <input  type="hidden" id="id" name="id" <#if customer??>value="${customer.id}"</#if>>
                        <div class="col-lg-4 col-12 mb-25">
                            <label for="customerName">姓名*</label>
                            <input class="form-control form-control-sm" type="text" id="customerName" required value="<#if customer??>${customer.customerName}</#if>"></div>
                        <div class="col-lg-4 col-12 mb-25">
                            <label for="company">公司*</label>
                            <input class="form-control form-control-sm" type="text" id="company" required value="<#if customer??>${customer.company}</#if>"></div>
                        <div class="col-lg-4 col-12 mb-25">
                            <label for="position">职务</label>
                            <select class="form-control form-control-sm nice-select" id="position" name="position">
                                <option>未知</option>
                                <#if positions??>
                                    <#list positions as position>
                                        <option value="${position.id}"
                                                <#if customer??>
                                            <#if (customer.positionId == position.id) >
                                                selected
                                            </#if>
                                                </#if>>${position.positionName}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4 col-12 mb-25">
                            <label for="gender">性别</label>
                            <select class="form-control form-control-sm nice-select" id="gender" name="gender">
                                <option>未知</option>
                                <option value="0"
                                        <#if customer??>
                                            <#if customer.gender == '0'>
                                                selected
                                            </#if>
                                        </#if>
                                >男</option>
                                <option value="1"
                                        <#if customer??>
                                            <#if customer.gender == '1'>
                                                selected
                                            </#if>
                                        </#if>
                                >女</option>
                            </select>
                        </div>
                        <div class="col-lg-4 col-12 mb-25">
                            <label for="phone">电话</label>
                            <input class="form-control form-control-sm" required type="text" id="phone" name="phone" value="${primaryAddress.phone}">
                        </div>
                        <div class="col-lg-4 col-12 mb-25" >
                            <label for="customerId">客户编号</label>
                            <input class="form-control form-control-sm" style="height: 36px" type="text" id="customerId" name="customerId" value="<#if customer??>${customer.customerId}</#if>">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-12 mb-25"  style="height:36px" >
                            <input type="hidden" id="addressId" value="${primaryAddress.id}">
                            <label for="province">地址</label>
                            <select class="form-control form-control-sm nice-select" required id="province" onchange="getChildArea('#province','#city','#district')" style="height:36px">
                                <option data-display="请选择">请选择</option>
                                <#if provinces??>
                                    <#list provinces as province>
                                        <option class="marker" value="${province.id}" required <#if primaryAddress.provinceId==province.id>selected</#if>>${province.areaName}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                        <div class="col-lg-2 col-12 mb-25">
                            <label for="city">城市</label>
                            <select class="form-control form-control-sm nice-select" required id="city" onchange="getChildArea('#city','#district')" style="height:36px">
                                <option data-display="请选择">请选择</option>
                                <#if cities??>
                                    <#list cities as city>
                                        <option class="marker" value="${city.id}" <#if primaryAddress.cityId==city.id>selected</#if>>${city.areaName}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                        <div class="col-lg-2 col-12 mb-25">
                            <label for="district">地区</label><select class="form-control form-control-sm nice-select" required data-live-search="true" id="district" style="height:36px">
                                <option data-display="请选择">请选择</option>
                                <#if districts??>
                                    <#list districts as district>
                                        <option class="marker" value="${district.id}" <#if primaryAddress.districtId==district.id>selected</#if>>${district.areaName}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                        <div class="col-lg-5 col-12"  style="height:36px">
                            <label for="addressDetail">详细地址</label>
                            <input class="form-control form-control-sm" required type="text" placeholder="详细地址" id="addressDetail" value="${primaryAddress.detail}">
                        </div>
                    </div>
                    <div class="mt-10">
                        <h4 style="display: inline" class="title">收货地址</h4>
                        <span data-toggle="tooltip" data-placement="top" title="多个地址请点击添加，默认使用上面“基本信息”中的地址"><i class="zmdi zmdi-help-outline"></i></span>

                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                <th>姓名</th><th>公司</th><th>电话</th><th>地址</th><th>操作</th>
                                </thead>
                                <tbody id="addressTableBody">
                                <#if customer??>
                                    <#list customer.addresses as address>
                                        <#if address?index gt 0>
                                            <tr>
                                                <td hidden>${address.id}</td>
                                                <td>${address.name}</td>
                                                <td>${address.company}</td>
                                                <td>${address.phone}</td>
                                                <td hidden>${address.provinceId}-${address.cityId}-${address.districtId}</td>
                                                <td>${address.province}&nbsp;${address.city}&nbsp;${address.district}&nbsp;${address.detail}</td>
                                                <td hidden>${address.isValid}</td>
                                                <td style='padding-top: 3px'>
                                                    <div class='button-group'>
                                                        <button class="button button-xs button-warning" style="height: 25px" onclick="showAddressDetailModal(this)"><i class='zmdi zmdi-edit'></i>编辑</button>
                                                        <button class="button button-xs button-primary" style="height: 25px" onclick="deleteCustomerAddress(this)"><i class='zmdi zmdi-delete'></i>删除</button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </#if>
                                    </#list>
                                </#if>
                                </tbody>
                            </table>
                        </div>
                        <div class="row mt-10">
                            <div class="col-sm-3 mb-5">
                                <button class="button button-primary button-xs" style="height: 36px" type="button" onclick="showAddressDetailModal()"><i class="zmdi zmdi-plus"></i><span>添加</span></button>
                            </div>
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
                                        <option value="${level.id}" <#if customer?? && customer.levelId == level.id>selected</#if>>${level.levelSign}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-5 col-12 mb-25">
                            <label for="note">备注</label><textarea class="form-control" placeholder="备注" style="margin-top: 0px; margin-bottom: 0px; height: 123px;" id="note"><#if customer??>${customer.note}</#if></textarea>
                        </div>
                    </div>


                </div>
                <div class="box-foot">
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
                </div>
            </div><!-- Add or Edit Product End -->

<div class="modal fade" id="customerModal" tabindex="-1" role="dialog" aria-labelledby="customerModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="customerModalTitle">Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="customerModalBody">

            </div>
        </div>
    </div>
</div>