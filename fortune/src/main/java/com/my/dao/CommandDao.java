package com.my.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import com.my.entity.Command;

public interface CommandDao extends JpaRepository<Command, Integer>, JpaSpecificationExecutor<Command> {

	@Query(value="select t from Command t where t.category_name=?1 order by t.title desc ")
	List<Command> getByCategory(String name);
	
}
