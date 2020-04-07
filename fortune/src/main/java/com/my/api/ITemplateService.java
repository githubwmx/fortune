package com.my.api;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.my.entity.Template;

public interface ITemplateService {

	void save(Template entity);

	void update(Template entity);

	void delete(int id);

	Template getById(Integer id);

	List<Template> getAll();

	Page<Template> getPage(Pageable pageable, String keyword);

	void deleteByName(String name);

}
