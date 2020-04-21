package rk.configuration.enuma;

import lombok.AllArgsConstructor;


@AllArgsConstructor
public enum OperationStatus {

    //Permission
    sessionExpired(201,"会话超时，请刷新页面"),
    //process
    paramNotAvailable(300,"无效的请求参数"),
    processFailed(301,"操作失败"),
    success(200,"操作成功");

    public Integer OPS_CODE;
    public String OPS_MSG;



}