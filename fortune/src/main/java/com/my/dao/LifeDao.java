package com.my.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.my.entity.Life;

public interface LifeDao extends JpaRepository<Life, Integer>, JpaSpecificationExecutor<Life> {

	@Query(value="select t from Life t where t.category_name is null or t.category_name='' order by t.title ")
	List<Life> getAllTitle();

	@Query(value="select t from Life t where t.category_name=?1 order by t.title desc ")
	List<Life> getByCategory(String name);

	@Query(value="select t from Life t where t.title like %?1% or t.content like %?1% order by t.title ")
	List<Life> getByKeyword(String keyword);

	@Query(value="select t.* from Life t where (t.content like %?1% and t.content like %?2%) or (t.category_name like %?1% and t.title like %?2%) or (t.category_name like %?1% and t.content like %?2%) order by t.title ", nativeQuery=true)
	List<Life> getByKeywordTwo(String string, String string2);

	@Query(value="select category_name,count(category_name) total from life where category_name != '' group by category_name order by category_name;", nativeQuery=true)
	List<Object[]> getAllCategory();

	@Transactional
	@Modifying
	@Query(value="delete from life where category_name = 'del' ", nativeQuery=true)
	void deleteDel();
	
}
