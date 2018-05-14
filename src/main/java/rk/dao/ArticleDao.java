package rk.dao;

import rk.po.WebArticle;

import java.util.List;

public interface ArticleDao{

    List<WebArticle> queryArticlesByUserId(Integer userId);

    int updateById(WebArticle webArticle);

    int deleteById(Integer id);

    int insert(WebArticle article);
}
