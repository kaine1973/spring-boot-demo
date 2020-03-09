package rk.service;

import rk.model.ResultInfo;

public class CommonService {

    protected ResultInfo success(String msg,Object res){
        return new ResultInfo(200,msg,res);
    }

    protected ResultInfo failed(Integer code,String msg){
        return new ResultInfo(code,msg);
    }
}
