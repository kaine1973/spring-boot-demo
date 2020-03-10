<html lang="zh">
<head>
</head>
<body>

</body>

<#include 'jsCommon.ftl'>
<script>

        if(Cookies.get('ui')){
            window.location.replace('/login')
        }else{
            window.location.replace('/main')
        }
</script>
</html>