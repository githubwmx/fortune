package com.my.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.my.entity.Category;

public interface CategoryDao extends JpaRepository<Category, Integer>, JpaSpecificationExecutor<Category> {
	
}
