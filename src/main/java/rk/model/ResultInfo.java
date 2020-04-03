package rk.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResultInfo {
    private int code;
    private String msg;
    private Object result;

    public ResultInfo(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

}
