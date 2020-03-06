package rk.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import rk.Model.ResultInfo;
import rk.exceptions.ParamException;
import rk.po.WebUser;
import rk.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import rk.util.AssertUtil;
import rk.util.FileUtil;
import rk.util.StringUtil;

import javax.servlet.http.HttpSession;
import java.io.*;

@Controller
@RequestMapping(value = "user")
public class UserController{

    @Autowired
    private UserService userService;


    @RequestMapping(value = "login",method = RequestMethod.POST)
    public ModelAndView login(WebUser user, HttpSession session){
        session.setAttribute("user",userService.login(user));
        return new ModelAndView("redirect:/main");
    }

    @RequestMapping("updatePwd")
    @ResponseBody
    private ResultInfo updatePwd(String pwd, String newPwd, String newPwdRepeat, @CookieValue(value="userId",required=true) String id){
        return userService.updateUserPwd(pwd,newPwd,newPwdRepeat,id);
    }

    @RequestMapping("regist")
    public ModelAndView regist(WebUser user){
        userService.insertUser(user);
        return new ModelAndView("login");
    }

    @RequestMapping("update")
    public ResultInfo update(MultipartFile head,WebUser AltUser,HttpSession session){
        WebUser currentUser = (WebUser)session.getAttribute("user");
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
                            throw new ParamException("操作失败");
                    }
                }
                head.transferTo(path);
                currentUser.setHeadFileName(headFileName);
            }
        } catch (IOException e) {
            throw new ParamException(300,e.getMessage());
        }
        currentUser.setAge(AltUser.getAge());
        currentUser.setNick(AltUser.getNick());
        currentUser.setMood(AltUser.getMood());
        return userService.updateUser(currentUser);
    }

}
