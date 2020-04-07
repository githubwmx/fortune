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
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.my.api.ICopyService;
import com.my.dao.CopyDao;
import com.my.entity.Copy;

@Service
public class CopyService implements ICopyService {

	@Autowired
	private CopyDao entityDao;

	public CopyDao getCopyDao() {
		return entityDao;
	}

	public void setCopyDao(CopyDao CopyDao) {
		this.entityDao = CopyDao;
	}

	@Override
	public void save(Copy entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void update(Copy entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void delete(int id) {
		this.entityDao.deleteById(id);
	}

	@Override
	public Copy getById(Integer id) {
		return this.entityDao.getOne(id);
	}

	@Override
	public List<Copy> getAll() {
		Sort sort = new Sort(new Order(Direction.ASC, "title"));
		return entityDao.findAll(sort);
	}

	@SuppressWarnings("serial")
	@Override
	public Page<Copy> getPage(Pageable pageable, String keyword) {
		Page<Copy> findAll = entityDao.findAll(new Specification<Copy>() {
			@Override
			public Predicate toPredicate(Root<Copy> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
		        List<Predicate> list = new ArrayList<Predicate>();
		        list.add(criteriaBuilder.equal(root.get("is_delete").as(int.class), 0));
		        Predicate[] p = new Predicate[list.size()];
		        return criteriaBuilder.and(list.toArray(p));				
			}
		}, pageable);
		return findAll;		
	}
	
}
