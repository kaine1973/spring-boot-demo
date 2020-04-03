package rk.exceptions;

import rk.configuration.enuma.OperationStatus;

public class PageAccessException extends RuntimeException {

    public Integer code = 300;
    public String msg = "页面请求失败";

    public PageAccessException(String msg) {
        super(msg);
        this.msg = msg;
    }

    public PageAccessException(OperationStatus status) {
        super(status.OPS_MSG);
        this.code = status.OPS_CODE;
        this.msg = status.OPS_MSG;
    }

    public PageAccessException(Integer code, String msg) {
        super(msg);
        this.code = code;
        this.msg = msg;
    }

}
