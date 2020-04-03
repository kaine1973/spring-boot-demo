package rk.util;

import rk.configuration.enuma.OperationStatus;
import rk.exceptions.PageAccessException;
import rk.exceptions.ParamRequestException;

public class AssertUtil {

    public static void isTrue(Boolean flag, OperationStatus status){
        if (flag){
            throw new ParamRequestException(status);
        }
    }

    public static void isTrue(Boolean flag, String status){
        if (flag){
            throw new ParamRequestException(status);
        }
    }

    public static void requestPage(Boolean flag,String msg){
        if (flag){
            throw new PageAccessException(msg);
        }
    }
    public static void requestPage(Boolean flag, OperationStatus status){
        if (flag){
            throw new PageAccessException(status);
        }
    }

}
