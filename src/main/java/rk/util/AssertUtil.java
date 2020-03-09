package rk.util;

import rk.exceptions.PageAccessException;
import rk.exceptions.ParamRequestException;

public class AssertUtil {

    public static void isTrue(Boolean flag,String msg){
        if (flag){
            throw new ParamRequestException(msg);
        }
    }

    public static void requestPage(Boolean flag,String msg){
        if (flag){
            throw new PageAccessException(msg);
        }
    }

}
