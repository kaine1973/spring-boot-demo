package rk.configuration.enuma;

public enum StockOperationType {

    STOCK_OUT(1,"出库"),
    STOCK_IN(2,"入库");

    private StockOperationType(Integer id,String Name){

    }

    public Integer TypeId;
    public String TypeName;

    public Integer getTypeId() {
        return TypeId;
    }

    public void setTypeId(Integer typeId) {
        TypeId = typeId;
    }

    public String getTypeName() {
        return TypeName;
    }

    public void setTypeName(String typeName) {
        TypeName = typeName;
    }
}
