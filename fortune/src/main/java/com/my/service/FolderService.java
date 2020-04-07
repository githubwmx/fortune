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

import com.my.api.IFolderService;
import com.my.dao.FolderDao;
import com.my.entity.Folder;

@Service
public class FolderService implements IFolderService {

	@Autowired
	private FolderDao entityDao;

	public FolderDao getFolderDao() {
		return entityDao;
	}

	public void setFolderDao(FolderDao FolderDao) {
		this.entityDao = FolderDao;
	}

	@Override
	public void save(Folder entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void update(Folder entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void delete(int id) {
		this.entityDao.deleteById(id);
	}

	@Override
	public Folder getById(Integer id) {
		return this.entityDao.getOne(id);
	}

	@SuppressWarnings("deprecation")
	@Override
	public List<Folder> getAll() {
		Sort sort = new Sort(new Order(Direction.ASC, "path"));
		return entityDao.findAll(sort);
	}

	@SuppressWarnings("serial")
	@Override
	public Page<Folder> getPage(Pageable pageable, String keyword) {
		Page<Folder> findAll = entityDao.findAll(new Specification<Folder>() {
			@Override
			public Predicate toPredicate(Root<Folder> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
		        List<Predicate> list = new ArrayList<Predicate>();
		        list.add(criteriaBuilder.equal(root.get("is_delete").as(int.class), 0));
		        Predicate[] p = new Predicate[list.size()];
		        return criteriaBuilder.and(list.toArray(p));				
			}
		}, pageable);
		return findAll;		
	}
	
}
