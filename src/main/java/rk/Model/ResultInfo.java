package rk.Model;



public class ResultInfo {
    private int status;
    private String msg;
    private Object res;

    public ResultInfo() {
    }

    public ResultInfo(int status, String msg) {
        this.status = status;
        this.msg = msg;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public ResultInfo(int status, String msg, Object res) {
        this.status = status;
        this.msg = msg;
        this.res = res;
    }

    public Object getRes() {
        return res;
    }

    public void setRes(Object res) {
        this.res = res;
    }
}
