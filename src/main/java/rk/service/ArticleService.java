package rk.service;

import rk.Model.ResultInfo;
import rk.dao.ArticleDao;
import rk.po.WebArticle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rk.util.AssertUtil;
import rk.util.StringUtil;

import java.util.List;

@Service
public class ArticleService {

    @Autowired
    private ArticleDao articleDao;

    public ResultInfo update(WebArticle webArticle) {
        AssertUtil.isTrue(articleDao.updateById(webArticle) < 1, "更新失败");
        return new ResultInfo();

    }


    public boolean deleteArticle(Integer id) {
        return articleDao.deleteById(id) == 1;
    }

    public List<WebArticle> queryArticlesByUserId(Integer userId) {
        return articleDao.queryArticlesByUserId(userId);
    }

    public ResultInfo insertArticle(WebArticle article) {
        AssertUtil.isTrue(StringUtil.isNullorEmpty(article.getTitle(),article.getContent()),"标题或文章内容不能为空");
        return articleDao.insert(article)==1?new ResultInfo(200,"保存成功"):new ResultInfo(300,"保存失败");
    }
}

