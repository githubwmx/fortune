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

import com.my.api.ICategoryService;
import com.my.dao.CategoryDao;
import com.my.entity.Category;

@Service
public class CategoryService implements ICategoryService {

	@Autowired
	private CategoryDao entityDao;

	public CategoryDao getCategoryDao() {
		return entityDao;
	}

	public void setCategoryDao(CategoryDao CategoryDao) {
		this.entityDao = CategoryDao;
	}

	@Override
	public void save(Category entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void update(Category entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void delete(int id) {
		this.entityDao.deleteById(id);
	}

	@Override
	public Category getById(Integer id) {
		return this.entityDao.getOne(id);
	}

	@SuppressWarnings("deprecation")
	@Override
	public List<Category> getAll() {
		Sort sort = new Sort(new Order(Direction.ASC, "name"));
		return entityDao.findAll(sort);
	}

	@SuppressWarnings("serial")
	@Override
	public Page<Category> getPage(Pageable pageable, String keyword) {
		Page<Category> findAll = entityDao.findAll(new Specification<Category>() {
			@Override
			public Predicate toPredicate(Root<Category> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
		        List<Predicate> list = new ArrayList<Predicate>();
		        list.add(criteriaBuilder.equal(root.get("is_delete").as(int.class), 0));
		        Predicate[] p = new Predicate[list.size()];
		        return criteriaBuilder.and(list.toArray(p));				
			}
		}, pageable);
		return findAll;		
	}
	
}
