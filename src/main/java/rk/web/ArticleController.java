package rk.web;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import rk.Model.ResultInfo;
import rk.po.WebArticle;
import rk.po.WebUser;
import rk.service.ArticleService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("article")
public class ArticleController  {

    @Autowired
    private ArticleService articleService;

    @RequestMapping("showArticles")
    public ModelAndView showArticles(HttpSession session){
        Object userId = session.getAttribute("userId");
        if (null != userId){
            List<WebArticle> articles = articleService.queryArticlesByUserId((int)userId);
            return new ModelAndView("article/articles").addObject("articles",articles);
        }else {
            return new ModelAndView("error").addObject("error",new ResultInfo(300,"出错了"));
        }
    }

    @RequestMapping("newArticle")
    public ModelAndView newArticle(){
        return new ModelAndView("article/new");
    }

    @RequestMapping("addArticle")
    @ResponseBody
    public ResultInfo addArticle(WebArticle article,HttpSession session){
        article.setUserId((int)session.getAttribute("userId"));
        return articleService.insertArticle(article);
    }


}
