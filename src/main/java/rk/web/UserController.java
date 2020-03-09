package rk.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;
import rk.constants.CrmConstant;
import rk.model.ResultInfo;
import rk.exceptions.ParamRequestException;
import rk.po.User;
import rk.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import rk.util.FileUtil;
import rk.util.StringUtil;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;

@Controller
@RequestMapping(value = "user")
public class UserController{

    @Autowired
    private UserService userService;

    @RequestMapping("logout")
    @ResponseBody
    private ResultInfo logOut(HttpSession session, HttpServletRequest request){
        session.removeAttribute("user");
        session.removeAttribute(CrmConstant.USER_PERMISSIONS);
        Cookie[] cookies = request.getCookies();
        if(null != cookies){
            for(Cookie cookie:cookies){
                if(cookie.getName().equals("ui") || cookie.getName().equals("ut")){
                    cookie.setMaxAge(1);
                }
            }
        }
        return new ResultInfo(200,"退出完成");
    }


    @RequestMapping("updatePwd")
    @ResponseBody
    private ResultInfo updatePwd(String pwd, String newPwd, String newPwdRepeat, @CookieValue(value="userId",required=true) String id){
        return userService.updateUserPwd(pwd,newPwd,newPwdRepeat,id);
    }

//    @RequestMapping("regist")
//    public ModelAndView regist(WebUser user){
//        userService.insertUser(user);
//        return new ModelAndView("login");
//    }

    @RequestMapping("update")
    public ResultInfo update(MultipartFile head, User AltUser, HttpSession session){
        User currentUser = (User)session.getAttribute("user");
        try {
            if (null != head) {
                String headFileName = StringUtil.genNewFileName()+".jpg";
                String realPath = session.getServletContext().getRealPath("/");
                File path = new File("/Users/kaidan/ProjectFiles/UserHeader/"+currentUser.getId(),headFileName);
                if(!path.getParentFile().exists()){
                    if ( path.getParentFile().mkdirs()) {
                        if (path.createNewFile())
                            FileUtil.copyFile("/Users/kaidan/ProjectFiles/DefaultFiles/defaultHeadPic.jpg", "/Users/kaidan/ProjectFiles/UserHeader/"+currentUser.getId() + "/defaultHeadPic.jpg");
                    }else{
                            throw new ParamRequestException("操作失败");
                    }
                }
                head.transferTo(path);
                currentUser.setHeader(headFileName);
            }
        } catch (IOException e) {
            throw new ParamRequestException(300,e.getMessage());
        }
        return userService.updateUser(currentUser);
    }

}
