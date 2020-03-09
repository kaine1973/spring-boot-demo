package rk.exceptions;

public class ParamRequestException extends RuntimeException {
    public Integer code = 300;
    public String msg = "参数请求失败";

    public ParamRequestException(String msg) {
        super(msg);
        this.msg = msg;
    }

    public ParamRequestException(Integer code, String msg) {
        super(msg);
        this.code = code;
        this.msg = msg;
    }
}
