<html lang="zh">
<head>
    <#include 'common.ftl'>
</head>
<body>

</body>

<#include 'jsCommon.ftl'>
<script>
    if(Cookies.get('ui') == null){
        window.location.replace('/login')
    }else{
        window.location.replace('/main')
    }

</script>
</html>