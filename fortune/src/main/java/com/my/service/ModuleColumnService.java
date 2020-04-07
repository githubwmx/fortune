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

import com.my.api.IModuleColumnService;
import com.my.dao.ModuleColumnDao;
import com.my.entity.ModuleColumn;

@Service
public class ModuleColumnService implements IModuleColumnService {

	@Autowired
	private ModuleColumnDao entityDao;

	public ModuleColumnDao getModuleColumnDao() {
		return entityDao;
	}

	public void setModuleColumnDao(ModuleColumnDao ModuleColumnDao) {
		this.entityDao = ModuleColumnDao;
	}

	@Override
	public void save(ModuleColumn entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void update(ModuleColumn entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void delete(int id) {
		this.entityDao.deleteById(id);
	}

	@Override
	public ModuleColumn getById(Integer id) {
		return this.entityDao.getOne(id);
	}

	@Override
	public List<ModuleColumn> getAll() {
		return this.entityDao.findAll();
	}

	@SuppressWarnings("serial")
	@Override
	public Page<ModuleColumn> getPage(Pageable pageable, String keyword) {
		Page<ModuleColumn> findAll = entityDao.findAll(new Specification<ModuleColumn>() {
			@Override
			public Predicate toPredicate(Root<ModuleColumn> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
		        List<Predicate> list = new ArrayList<Predicate>();
		        list.add(criteriaBuilder.equal(root.get("is_delete").as(int.class), 0));
		        Predicate[] p = new Predicate[list.size()];
		        return criteriaBuilder.and(list.toArray(p));				
			}
		}, pageable);
		return findAll;		
	}

	@Override
	public List<ModuleColumn> getByModuleId(Integer id) {
		return entityDao.getByModuleId(id);
	}
	
}
