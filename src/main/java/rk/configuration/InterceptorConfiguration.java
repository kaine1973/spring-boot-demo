package rk.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import rk.exceptions.PageAccessException;
import rk.exceptions.ParamRequestException;
import rk.util.AssertUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
                .addPathPatterns( "/staticWeb/**" )
                .addPathPatterns( "/user/**" )
                .excludePathPatterns("/user/login").order( 0 );

        registry.addInterceptor( staticResourceInterceptor )
                .addPathPatterns( "/images/**" )
                .excludePathPatterns( "/images/bg/**" ).order( 1 );
//                .excludePathPatterns( "/" )
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
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Object user = session.getAttribute( "user" );
        AssertUtil.isTrue( null == user,"会话超时，请刷新页面重试" );
        return super.preHandle( request,response,handler );
    }
}

@Component
class StaticResourceInterceptor extends HandlerInterceptorAdapter{
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Object user = session.getAttribute( "user" );
        boolean flag = true;
        if(null == user){
            flag=false;
            request.getRequestDispatcher( "/login" ).forward( request,response );
        }
        return flag;
    }
}
