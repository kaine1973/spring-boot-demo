package rk.base;

import rk.model.ResultInfo;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by xlf on 2019/2/14.
 */
public class BaseController {


    public ResultInfo success(String msg){
        ResultInfo info = new ResultInfo();
        info.setMsg(msg);
        return info;
    }
    public ResultInfo success(String msg, Object result){
        ResultInfo info = new ResultInfo();
        info.setMsg(msg);
        info.setResult(result);
        return info;
    }
    public ResultInfo success(Integer code, String msg, Object result){
        ResultInfo info = new ResultInfo();
        info.setCode(code);
        info.setMsg(msg);
        info.setResult(result);
        return info;
    }



    /**
     * 前置处理方法
     * @param request
     */
    @ModelAttribute
    public void preMethod(HttpServletRequest request){
        request.setAttribute("ctx", request.getContextPath());
    }

}
