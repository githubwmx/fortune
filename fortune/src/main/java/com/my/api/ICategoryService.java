package com.my.api;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.my.entity.Category;

public interface ICategoryService {

	void save(Category entity);

	void update(Category entity);

	void delete(int id);

	Category getById(Integer id);

	List<Category> getAll();

	Page<Category> getPage(Pageable pageable, String keyword);

}
