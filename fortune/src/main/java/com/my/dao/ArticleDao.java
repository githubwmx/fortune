package com.my.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.my.entity.Article;

public interface ArticleDao extends JpaRepository<Article, Integer>, JpaSpecificationExecutor<Article> {

	@Query(value="select t from Article t where t.category_name is null or t.category_name='' order by t.title  ")
	List<Article> getAllTitle();

	@Query(value="select t from Article t where t.category_name=?1 order by t.label,t.title ")
	List<Article> getByCategory(String name);

	@Query(value="select t.* from Article t where t.title like %?1% or t.content like %?1%", nativeQuery=true)
	List<Article> getByKeyword(String keyword);
	@Query(value="select t.* from Article t where t.title=?1 or t.optimization like %?1% limit 0,10", nativeQuery=true)
	List<Article> getByKeywordTitleAllMatch(String keyword);
	@Query(value="select t.* from Article t where t.title like %?1% limit 0,10 ", nativeQuery=true)
	List<Article> getByKeywordTitleLike(String keyword);
	@Query(value="select t.* from Article t where t.content like %?1% limit 0,10 ", nativeQuery=true)
	List<Article> getByKeywordContentLike(String keyword);

	
	@Query(value="select t.* from Article t where (t.category_name like %?1% and t.title like %?2%) or (t.content like %?1% and t.content like %?2%) or (t.category_name like %?1% and t.content like %?2%) ", nativeQuery=true)
	List<Article> getByKeywordTwo(String string, String string2);

	//	@Query(value="select distinct t.category_name from article t order by t.category_name", nativeQuery=true)
//	List<String> getAllCategory();

	@Query(value="select category_name,count(category_name) total from article where category_name != '' group by category_name order by category_name;", nativeQuery=true)
	List<Object[]> getAllCategory();

	@Query(value="select t from Article t where t.category_name = ?1")
	List<Article> getByKeyword4Interview(String keyword);

	@Query(value="select t.* FROM article t where t.category_name like '【%' order by t.category_name ", nativeQuery=true)
	List<Article> getInterviewAll();

	@Query(value=
			"(select t.* FROM article t where t.category_name like '[]%' and t.category_name not like '[][]%' order by RAND() limit 0,10)\n" +
					"union all \n" +
					"(select t2.* from article t2 where t2.category_name not like '[]%' order by RAND() limit 0,10)\n" +
					"union all \n" +
					"(select t3.* from article t3 where t3.category_name like '[][]%' order by RAND() limit 0,5)"			
			, nativeQuery=true)
	List<Article> getByRandom(Integer number);

	@Transactional
	@Modifying
	@Query(value="delete from article where category_name = 'del' ", nativeQuery=true)
	void deleteDel();

	@Query(value="select count(1) from article where category_name like '[]%' ", nativeQuery=true)
	long getReviewCount();
	
}
