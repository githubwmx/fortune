package com.my.api;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.my.entity.Module;

public interface IModuleService {

	void save(Module entity);

	void update(Module entity);

	void delete(int id);

	Module getById(Integer id);

	List<Module> getAll();

	Page<Module> getPage(Pageable pageable, String keyword);

	Module getByTableName(String table_name);

}
