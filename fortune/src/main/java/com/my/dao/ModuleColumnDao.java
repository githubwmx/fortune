package com.my.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import com.my.entity.ModuleColumn;

public interface ModuleColumnDao extends JpaRepository<ModuleColumn, Integer>, JpaSpecificationExecutor<ModuleColumn> {

	@Query("select t from ModuleColumn t where t.module_id=?1")
	List<ModuleColumn> getByModuleId(Integer id);

}
