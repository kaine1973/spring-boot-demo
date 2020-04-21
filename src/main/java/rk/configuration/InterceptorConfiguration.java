package rk.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import rk.configuration.enuma.OperationStatus;
import rk.po.User;
import rk.service.UserService;
import rk.util.AssertUtil;
import rk.util.StringUtil;
import rk.util.UserIDBase64;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer {

    @Autowired
    ApiInterceptor apiInterceptor;
    @Autowired
    StaticResourceInterceptor staticResourceInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor( apiInterceptor )
                .addPathPatterns( "/product/**" )
                .addPathPatterns( "/customer/**" )
                .addPathPatterns( "/address/**" )
                .addPathPatterns( "/stock/**" )
                .addPathPatterns( "/staticWeb/**" )
                .addPathPatterns( "/user/**" )
                .excludePathPatterns("/user/login").order( 0 );

        registry.addInterceptor( staticResourceInterceptor )
                .addPathPatterns( "/images/**" )
                .addPathPatterns( "/" )
                .addPathPatterns( "/index" )
                .addPathPatterns( "/main" )
                .excludePathPatterns( "/images/bg/**" ).order( 1 );
//                .excludePathPatterns( "/main" )
//                .excludePathPatterns("/login")
//                .excludePathPatterns("/images/**")
//                .excludePathPatterns("/css/**")
//                .excludePathPatterns("/js/**")
//                .excludePathPatterns("/fonts/**");
    }
}


@Component
class ApiInterceptor extends HandlerInterceptorAdapter{

    @Autowired
    UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        AssertUtil.isTrue( ! UserCheck.rememeredCheck(request,userService), OperationStatus.sessionExpired );
        return super.preHandle( request,response,handler );
    }
}

@Component
class StaticResourceInterceptor extends HandlerInterceptorAdapter{

    @Autowired
    UserService userService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if( !UserCheck.rememeredCheck( request,userService )){
            response.sendRedirect( "/login" );
            return false;
        }
        return super.preHandle( request,response,handler );
    }
}

class UserCheck{
    public static boolean rememeredCheck(HttpServletRequest request,UserService userService){
        User user = (User)request.getSession().getAttribute( "user" );
        if(null==user) {
            Cookie[] cookies = request.getCookies();
            if (null == cookies) {
                return false;
            }
            String ui = null;
            String ut = null;
            for (Cookie cookie : cookies) {
                if ("ui".equals( cookie.getName() )) {
                    ui = cookie.getValue();
                } else if ("ut".equals( cookie.getName() )) {
                    ut = cookie.getValue();
                }
            }
            if (null != ut && null != ui) {
                user = userService.queryUserById( UserIDBase64.decoderUserID( ui ) );
                String encypt = StringUtil.encypt( ui + user.getSalt() );
                if (ut.equals( encypt )) {
                    request.getSession().setAttribute( "user", user );
                    return true;
                }
            }
            return false;
        }
        return true;
    }
}


//@Configuration
//class IndexDispatcher extends HandlerInterceptorAdapter{
//    @Override
//    public boolean preHandler(HttpServletRequest request, HttpServletResponse response, Object handler){
//
//
//
//    }
//}
//
