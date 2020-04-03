package rk.exceptions;

import rk.configuration.enuma.OperationStatus;

public class ParamRequestException extends RuntimeException {
    public Integer code = 300;
    public String msg;


    public ParamRequestException(OperationStatus operationStatus){
        super(operationStatus.OPS_MSG);
        this.code=operationStatus.OPS_CODE;
        this.msg=operationStatus.OPS_MSG;
    }

    public ParamRequestException(String msg) {
        super(msg);
        this.msg = msg;
    }

    public ParamRequestException(int i, String msg) {
        this.code = i;
        this.msg = msg;
    }
}
