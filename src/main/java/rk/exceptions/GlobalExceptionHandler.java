package rk.exceptions;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;


@ControllerAdvice
public class GlobalExceptionHandler {


    @ExceptionHandler(ParamException.class)
    public ModelAndView ParamExceptionHandler(HttpServletRequest request, Exception e){
        String requestURI = request.getRequestURI();
        System.out.println(requestURI);
        if (requestURI.contains("login")){
            System.out.println(e.getMessage());
            return new ModelAndView("login").addObject("msg",((ParamException) e).msg);
        }
        if (requestURI.contains("regist")){
            System.out.println(e.getMessage());
            return new ModelAndView("register").addObject("msg",((ParamException) e).msg);
        }
        Map<String,Object> params = new HashMap<>();
        params.put("code",((ParamException)e).code);
        params.put("msg",((ParamException) e).msg);
        System.out.println(e.getMessage());
        return new ModelAndView("error").addAllObjects(params);
    }

}
