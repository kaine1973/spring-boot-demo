package rk.aop;

import com.fasterxml.jackson.annotation.JsonTypeInfo;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.web.bind.annotation.ResponseBody;
import rk.annotations.RequestPermission;
import rk.constants.CrmConstant;
import rk.po.User;
import rk.service.UserService;
import rk.util.AssertUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import rk.util.StringUtil;
import rk.util.UserIDBase64;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by xlf on 2019/2/21.
 */
@Component
@Aspect
public class PermissionAdaptor {

    @Autowired
    private HttpSession session;

    @Autowired
    private HttpServletRequest request;

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
        List<String> permissions = (List<String>) session.getAttribute(CrmConstant.USER_PERMISSIONS);


        /***
         * 是否有权限码
         * 1. 没有，没登录，检查是否保持登录
         */

        if(CollectionUtils.isEmpty(permissions)){
            AssertUtil.requestPage(!rememeredCheck(),"请先登录");
        }else {
            //有ResponseBody的请求是数据请求
            ResponseBody annotation = method.getAnnotation(ResponseBody.class);
            //没有ResponseBody 就是响应页面
            if(null == annotation){
                AssertUtil.requestPage(!permissions.contains(aclValue), "页面请求失败，没有足够的权限");
            }
            AssertUtil.isTrue(!permissions.contains(aclValue), "数据请求失败，没有足够的权限");

        }

        Object proceed = pjp.proceed();// 继续执行
        return proceed;
    }

    @Autowired
    private UserService userService;

    private boolean rememeredCheck(){
        Cookie[] cookies = request.getCookies();
        if(null == cookies){
            return false;
        }
        String ui = null;
        String ut = null;
        for (Cookie cookie :cookies) {
            if("ui".equals(cookie.getName())){
                ui = cookie.getValue();
            }else if("ut".equals(cookie.getName())){
                ut = cookie.getValue();
            }
        }
        if(null != ut && null != ui){
            User user = userService.queryUserById(UserIDBase64.decoderUserID(ui));
            String encypt = StringUtil.encypt(ui + user.getSalt());
            if(ut.equals(encypt)){
                session.setAttribute("user",user);
                session.setAttribute(CrmConstant.USER_PERMISSIONS, new ArrayList<>(Arrays.asList("0")));
            }
            return true;
        }
        return false;
    }

}
