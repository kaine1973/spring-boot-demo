package rk.exceptions;

public class ParamException extends RuntimeException {

    public Integer code = 300;
    public String msg = "操作失败";

    public ParamException(){

    }

    public ParamException(String msg) {
        super(msg);
        this.msg = msg;
    }

    public ParamException(Integer code, String msg) {
        super(msg);
        this.code = code;
        this.msg = msg;
    }
}
