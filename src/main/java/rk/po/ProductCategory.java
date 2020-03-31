package rk.po;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.ArrayList;

@Data
public class ProductCategory {

    private int id;
    @JsonProperty("name")
    private String categoryName;
    @JsonProperty("pId")
    private int parentId;
    private ArrayList<Integer> childIds;
    private ArrayList<ProductCategory> children;

}
