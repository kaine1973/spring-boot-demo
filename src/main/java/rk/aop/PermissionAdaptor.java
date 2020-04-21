package rk.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.web.bind.annotation.ResponseBody;
import rk.annotations.RequestPermission;
import rk.po.User;
import rk.service.UserService;
import rk.util.AssertUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.ArrayList;

/**
 * Created by xlf on 2019/2/21.
 */
@Component
@Aspect
public class PermissionAdaptor {

    @Autowired
    private HttpSession session;

    @Pointcut("@annotation(rk.annotations.RequestPermission)")
    public void cut(){}

    @Around("cut()")
    public Object around(ProceedingJoinPoint pjp) throws Throwable {
        /***
         * 1. 先获取Method对象
         * 2. 通过反射获取权限码
         * 3. 判断权限列表中是否包含该权限码
         * */
        MethodSignature signature = (MethodSignature) pjp.getSignature();
        Method method = signature.getMethod();
        RequestPermission permission = method.getAnnotation(RequestPermission.class);
        String aclValue = permission.aclValue();
        User user = (User)session.getAttribute("user");

        //有ResponseBody的请求是数据请求
        ResponseBody annotation = method.getAnnotation(ResponseBody.class);
        //没有ResponseBody 就是响应页面
        ArrayList<String> userPermission = userService.getUserPermission( user );
        if(null == annotation){
            AssertUtil.requestPage(!userPermission.contains(aclValue), "页面请求失败，没有足够的权限");
        }
        AssertUtil.isTrue(!userPermission.contains(aclValue), "数据请求失败，没有足够的权限");


        Object proceed = pjp.proceed();// 继续执行
        return proceed;
    }

    @Autowired
    private UserService userService;

}
