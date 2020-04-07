package com.my.api;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.my.entity.ModuleColumn;

public interface IModuleColumnService {

	void save(ModuleColumn entity);

	void update(ModuleColumn entity);

	void delete(int id);

	ModuleColumn getById(Integer id);

	List<ModuleColumn> getAll();

	Page<ModuleColumn> getPage(Pageable pageable, String keyword);

	List<ModuleColumn> getByModuleId(Integer id);

}
