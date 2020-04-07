package com.my.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import com.my.entity.Module;

public interface ModuleDao extends JpaRepository<Module, Integer>, JpaSpecificationExecutor<Module> {

	@Query(value="select t from Module t where t.table_name=?1 ")
	Module getByTableName(String table_name);

}
