package rk.po.common;

import lombok.Data;

@Data
public class Area {

    private Integer id;
    private String areaName;
    private Integer parentId;
    private Integer sort;

}
