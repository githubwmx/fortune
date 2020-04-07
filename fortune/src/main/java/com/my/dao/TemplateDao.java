package com.my.dao;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.my.entity.Template;

public interface TemplateDao extends JpaRepository<Template, Integer>, JpaSpecificationExecutor<Template> {

	@Modifying
	@Transactional
	@Query("delete from Template where name = ?1 ")
	void deleteByName(String name);
	
}
