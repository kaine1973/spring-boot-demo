<div class="row justify-content-between align-items-center mb-10">
    <div class="col-12 col-lg-auto mb-20">
        <div class="page-heading">
            <h3>我的地址管理</h3>
        </div>
    </div>
</div>
<div class="box">
    <div class="box-head">
        <h6 style="display: inline">我的地址</h6>
        <button class="button button-xs button-primary" style="height: 30px;float:right" onclick="showAddressDetailModal(undefined,1)">添加</button>
    </div>
    <div class="box-body">
        <div class="row">
            <div class="col-12">
                <div id="pagination-container"></div>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <table class="table table-hover table-responsive-lg" >
                    <thead class="thead-light">
                    <tr>
                        <th>姓名</th><th>公司</th><th>电话</th><th>地址</th><th>管理</th>
                    </tr>
                    </thead>
                    <tbody id="addressTableBody">

                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>
<script>
    function parseAddressRows(data) {
        var html = "";
        console.log(data)
        $.each(data,function (index,product) {
            html += "<tr>" +
                "<td hidden>"+product.id+"</td>" +
                "<td>"+product.name+"</td>" +
                "<td>"+product.company+"</td>" +
                "<td>"+product.phone+"</td>" +
                "<td hidden>"+product.provinceId+"-"+product.cityId+"-"+product.districtId+"</td>" +
                "<td>"+product.province+"&nbsp;"+product.city+"&nbsp;"+product.district+"&nbsp;"+product.detail+"</td>" +
                "<td hidden>product.isValid</td>" +
                "<td style='padding-top: 3px'>\n" +
                "<div class='button-group'>" +
                "   <button class=\"button button-xs button-warning\" style=\"height: 25px\" onclick=\"showAddressDetailModal(this)\"><i class='zmdi zmdi-edit'></i>编辑</button>" +
                "   <button class=\"button button-xs button-primary\" style=\"height: 25px\" onclick=\"deleteCustomerAddress(this)\"><i class='zmdi zmdi-delete'></i>删除</button>" +
                "</div>\n" +
                "</td>"+
                "</tr>"
        })
        return html;
    }
    function queryAddressOfUser() {
        $('#pagination-container').pagination({
            dataSource: '/address/queryUserAddresses',
            locator: 'result.list',
            totalNumberLocator: function(response) {
                return response.result.pageSize * response.result.pages
            },
            pageSize: 10,
            pageRange: 6,
            alias: {
                pageNumber: 'pageNum'
            },
            ajax: {
                data:{
                    "startDate":startDate,
                    "endDate":endDate
                },
                beforeSend: function() {
                    $('#addressTableBody').html('加载数据中 ...');
                }
            },
            callback: function(data, pagination) {
                // template method of yourself
                var html = parseAddressRows(data);
                console.log(html)
                $('#addressTableBody').html(html);
            }
        })
    }
    queryAddressOfUser()
</script>