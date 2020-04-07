package com.my.api;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.my.entity.Article;

public interface IArticleService {

	void save(Article entity);

	void update(Article entity);

	void delete(int id);

	Article getById(Integer id);

	List<Article> getAll();

	Page<Article> getPage(Pageable pageable, String keyword);

	List<Article> getAllTitle();

	List<Article> getByCategory(String name);

	List<Article> getByKeyword(String keyword);

	List<Object[]> getAllCategory();

	List<Article> getByRandom(Integer number);

	void deleteDel();

	long getReviewCount();

}
