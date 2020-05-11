var startDate,endDate


function initStockHistory(){
    $('#date-range').daterangepicker({
        "showDropdowns": true,
        "autoApply": true,
        ranges: {
            '今天': [moment(), moment()],
            '昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            '最近7天': [moment().subtract(6, 'days'), moment()],
            '最近30天': [moment().subtract(29, 'days'), moment()],
            '这个月': [moment().startOf('month'), moment().endOf('month')],
            '上个月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        "alwaysShowCalendars": true,
    }, function(start, end) {
        startDate = start.format('MM-DD-YYYY-HH-mm-ss')
        endDate = end.format('MM-DD-YYYY-HH-mm-ss')
    });
    parsePaginator()
}

function parsePaginator() {
    var productLike = $('#productLike').val()
    var userId = $('#userId').val()
    var type = $('#type').val()
    $('#pagination-container').pagination({
        dataSource: '/stock/queryStockOf'+type,
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
                "productLike":productLike,
                "userId":userId,
                "startDate":startDate,
                "endDate":endDate
            },
            beforeSend: function() {
                $('#stockBody').html('加载数据中 ...');
            }
        },
        callback: function(data, pagination) {
            // template method of yourself
            var html = parseRows(data);
            $('#stockBody').html(html);
        }
    })
}

function parseRows(data) {
    var html = ""
    $.each(data,function (index,item) {
        var row = "<tr>" +
            "<td>"+item.confirmDate+"</td>" +
            "<td>"+item.productBrand+"</td>" +
            "<td>"+item.productName+"</td>" +
            "<td>"+item.productSerial+"</td>" +
            "<td>"+item.specificationName+"</td>" +
            "<td>"+item.amount+"</td>" +
            "<td>"+(item.dealPrice==null?item.price:item.dealPrice)+"</td>" +
            "<td>"+item.userName+"</td>" +
            "</tr>"
        html += row
    })
    return html
}

function doStockQuery() {
    parsePaginator()
}

function resetSearch() {
    $('#productLike').val('')
    $('#userId').val('')
    startDate=null
    parsePaginator()
}
