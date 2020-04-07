package com.my.api;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.my.entity.Life;

public interface ILifeService {

	void save(Life entity);

	void update(Life entity);

	void delete(int id);

	Life getById(Integer id);

	List<Life> getAll();

	Page<Life> getPage(Pageable pageable, String keyword);

	List<Life> getAllTitle();

	List<Life> getByCategory(String name);

	List<Life> getByKeyword(String keyword);

	List<Object[]> getAllCategory();

	void deleteDel();

}
