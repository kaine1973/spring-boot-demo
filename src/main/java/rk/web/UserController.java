package rk.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;
import rk.constants.CrmConstant;
import rk.model.ResultInfo;
import rk.exceptions.ParamRequestException;
import rk.model.UserInfo;
import rk.po.User;
import rk.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import rk.util.FileUtil;
import rk.util.StringUtil;
import rk.util.UserIDBase64;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;

@Controller
@RequestMapping(value = "user")
public class UserController{

    @Autowired
    private UserService userService;


    @ResponseBody
    @RequestMapping(value = "login",method = RequestMethod.POST)
    public ResultInfo login(User user, String remember, HttpSession session){
        User login = userService.queryUserByName(user);
        session.setAttribute("user",login);
        session.setAttribute(CrmConstant.USER_PERMISSIONS, new ArrayList<>( Arrays.asList("0")));
        ResultInfo resultInfo = new ResultInfo(200, "登录成功");
        if ("true".equals(remember)) {
            resultInfo.setResult(new UserInfo( UserIDBase64.encoderUserID(login.getId()),StringUtil.encypt(UserIDBase64.encoderUserID(login.getId())+login.getSalt())));
        }
        return resultInfo;
    }

    @RequestMapping("logout")
    @ResponseBody
    private ResultInfo logOut(HttpSession session, HttpServletRequest request, HttpServletResponse response){
        session.removeAttribute("user");
        session.removeAttribute(CrmConstant.USER_PERMISSIONS);
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

//    @RequestMapping("update")
//    public ResultInfo update(MultipartFile head, User AltUser, HttpSession session){
//        User currentUser = (User)session.getAttribute("user");
//        try {
//            if (null != head) {
//                String headFileName = StringUtil.genNewFileName()+".jpg";
//                String realPath = session.getServletContext().getRealPath("/");
//                File path = new File("/Users/kaidan/ProjectFiles/UserHeader/"+currentUser.getId(),headFileName);
//                if(!path.getParentFile().exists()){
//                    if ( path.getParentFile().mkdirs()) {
//                        if (path.createNewFile())
//                            FileUtil.copyFile("/Users/kaidan/ProjectFiles/DefaultFiles/defaultHeadPic.jpg", "/Users/kaidan/ProjectFiles/UserHeader/"+currentUser.getId() + "/defaultHeadPic.jpg");
//                    }else{
//                            throw new ParamRequestException("操作失败");
//                    }
//                }
//                head.transferTo(path);
//                currentUser.setHeader(headFileName);
//            }
//        } catch (IOException e) {
//            throw new ParamRequestException(300,e.getMessage());
//        }
//        return userService.updateUser(currentUser);
//    }

}
