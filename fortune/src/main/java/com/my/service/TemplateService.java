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

import com.my.api.ITemplateService;
import com.my.dao.TemplateDao;
import com.my.entity.Template;

@Service
public class TemplateService implements ITemplateService {

	@Autowired
	private TemplateDao entityDao;

	public TemplateDao getTemplateDao() {
		return entityDao;
	}

	public void setTemplateDao(TemplateDao TemplateDao) {
		this.entityDao = TemplateDao;
	}

	@Override
	public void save(Template entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void update(Template entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void delete(int id) {
		this.entityDao.deleteById(id);
	}

	@Override
	public Template getById(Integer id) {
		return this.entityDao.getOne(id);
	}

	@Override
	public List<Template> getAll() {
		return this.entityDao.findAll();
	}

	@SuppressWarnings("serial")
	@Override
	public Page<Template> getPage(Pageable pageable, String keyword) {
		Page<Template> findAll = entityDao.findAll(new Specification<Template>() {
			@Override
			public Predicate toPredicate(Root<Template> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
		        List<Predicate> list = new ArrayList<Predicate>();
		        list.add(criteriaBuilder.equal(root.get("is_delete").as(int.class), 0));
		        Predicate[] p = new Predicate[list.size()];
		        return criteriaBuilder.and(list.toArray(p));				
			}
		}, pageable);
		return findAll;		
	}

	@Override
	public void deleteByName(String name) {
		entityDao.deleteByName(name);
	}
	
}
