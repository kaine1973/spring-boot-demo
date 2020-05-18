package rk.po;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.sun.istack.internal.NotNull;
import lombok.Data;
import rk.util.AssertUtil;

import java.util.ArrayList;

@Data
public class ProductCategory {

    private Integer id;
    @JsonProperty("name")
    private String categoryName;
    @JsonProperty("pId")
    private Integer parentId;
    private Integer level;
    private ArrayList<Integer> childIds;
    private ArrayList<ProductCategory> children;

    public void checkRequired() {
        AssertUtil.isTrue( categoryName==null || "".equals( categoryName ),"分类名称不能为空" );
    }
}
