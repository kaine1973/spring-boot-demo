package rk.dao;


import rk.po.WebArticle;

import java.util.List;

public interface ArticleDao extends CommonDao {

    List<WebArticle> queryArticlesByUserId(Integer userId);
}
