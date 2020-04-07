package com.my.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.my.entity.Copy;

public interface CopyDao extends JpaRepository<Copy, Integer>, JpaSpecificationExecutor<Copy> {
	
}
