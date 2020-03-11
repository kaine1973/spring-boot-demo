package rk.exceptions;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import rk.model.ResultInfo;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


@ControllerAdvice
public class GlobalExceptionHandler {


    @ResponseBody
    @ExceptionHandler(ParamRequestException.class)
    public ResultInfo ParamExceptionHandler(HttpServletRequest request, Exception e ){
        ParamRequestException error = (ParamRequestException) e;
        System.out.println(request.getRequestURI());
        System.out.println(e.getMessage());
        return new ResultInfo(error.code,error.msg);
    }


    @ExceptionHandler(PageAccessException.class)
    @ResponseBody
    public ModelAndView pageExceptionHandler(Exception e){
        PageAccessException error = (PageAccessException) e;
        Map<String,Object> params = new HashMap<>();
        params.put("code",error.code);
        params.put("msg",error.msg);
        return new ModelAndView( "/login" ).addAllObjects( params );
    }

//    @ResponseBody
//    @ExceptionHandler(Exception.class)
//    public ResultInfo ExceptionHandler(HttpServletRequest request, Exception e ){
//        System.out.println(request.getRequestURI());
//        System.out.println(e.getMessage());
//        e.printStackTrace();
//        return new ResultInfo(500,e.getMessage());
//    }

}
