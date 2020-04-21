package rk.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import rk.annotations.RequestPermission;
import rk.model.ResultInfo;
import rk.po.common.Area;
import rk.service.CommonService;

import java.util.List;

@Controller
@RequestMapping("common")
public class CommonController {
    @Autowired
    CommonService commonService;

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryAreaByParentId")
    @ResponseBody
    public ResultInfo queryAreaByParentId(Integer parentId){
        List<Area> areas = commonService.queryAreaByParentId( parentId );
        return new ResultInfo( 200,"请求成功",areas );
    }
}
