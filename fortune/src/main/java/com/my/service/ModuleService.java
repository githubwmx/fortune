package com.my.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.my.api.IModuleService;
import com.my.dao.ModuleDao;
import com.my.entity.Module;

@Service
public class ModuleService implements IModuleService {

	@Autowired
	private ModuleDao entityDao;

	public ModuleDao getModuleDao() {
		return entityDao;
	}

	public void setModuleDao(ModuleDao ModuleDao) {
		this.entityDao = ModuleDao;
	}

	@Override
	public void save(Module entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void update(Module entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void delete(int id) {
		this.entityDao.deleteById(id);
	}

	@Override
	public Module getById(Integer id) {
		return this.entityDao.getOne(id);
	}

	@Override
	public List<Module> getAll() {
		return this.entityDao.findAll();
	}

	@SuppressWarnings("serial")
	@Override
	public Page<Module> getPage(Pageable pageable, String keyword) {
		Page<Module> findAll = entityDao.findAll(new Specification<Module>() {
			@Override
			public Predicate toPredicate(Root<Module> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
		        List<Predicate> list = new ArrayList<Predicate>();
		        list.add(criteriaBuilder.equal(root.get("is_delete").as(int.class), 0));
		        Predicate[] p = new Predicate[list.size()];
		        return criteriaBuilder.and(list.toArray(p));				
			}
		}, pageable);
		return findAll;		
	}

	@Override
	public Module getByTableName(String table_name) {
		return entityDao.getByTableName(table_name);
	}
	
}
