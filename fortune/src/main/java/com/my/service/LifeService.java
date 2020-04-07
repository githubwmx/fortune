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

import com.my.api.ILifeService;
import com.my.dao.LifeDao;
import com.my.entity.Life;

@Service
public class LifeService implements ILifeService {

	@Autowired
	private LifeDao entityDao;

	public LifeDao getLifeDao() {
		return entityDao;
	}

	public void setLifeDao(LifeDao LifeDao) {
		this.entityDao = LifeDao;
	}

	@Override
	public void save(Life entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void update(Life entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void delete(int id) {
		this.entityDao.deleteById(id);
	}

	@Override
	public Life getById(Integer id) {
		return this.entityDao.getOne(id);
	}

	@Override
	public List<Life> getAll() {
		return this.entityDao.findAll();
	}

	@SuppressWarnings("serial")
	@Override
	public Page<Life> getPage(Pageable pageable, String keyword) {
		Page<Life> findAll = entityDao.findAll(new Specification<Life>() {
			@Override
			public Predicate toPredicate(Root<Life> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
		        List<Predicate> list = new ArrayList<Predicate>();
		        list.add(criteriaBuilder.equal(root.get("is_delete").as(int.class), 0));
		        Predicate[] p = new Predicate[list.size()];
		        return criteriaBuilder.and(list.toArray(p));				
			}
		}, pageable);
		return findAll;		
	}

	@Override
	public List<Life> getAllTitle() {
		return entityDao.getAllTitle();
	}

	@Override
	public List<Life> getByCategory(String name) {
		return entityDao.getByCategory(name);
	}

	@Override
	public List<Life> getByKeyword(String keyword) {
		String[] split = keyword.split(" ");
		if(split.length==1) {
			return entityDao.getByKeyword(keyword);
		} else {
			return entityDao.getByKeywordTwo(split[0],split[1]);
		}
	}

	@Override
	public List<Object[]> getAllCategory() {
		return entityDao.getAllCategory();
	}

	@Override
	public void deleteDel() {
		entityDao.deleteDel();
	}
	
}
