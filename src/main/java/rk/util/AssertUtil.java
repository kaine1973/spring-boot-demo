package rk.util;

import rk.exceptions.ParamException;

public class AssertUtil {

    public static void isTrue(Boolean flag,String msg){
        if (flag){
            throw new ParamException(msg);
        }else {
            return;
        }
    }

}
