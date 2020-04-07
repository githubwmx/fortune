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

import com.my.api.ICommandService;
import com.my.dao.CommandDao;
import com.my.entity.Command;

@Service
public class CommandService implements ICommandService {

	@Autowired
	private CommandDao entityDao;

	public CommandDao getCommandDao() {
		return entityDao;
	}

	public void setCommandDao(CommandDao CommandDao) {
		this.entityDao = CommandDao;
	}

	@Override
	public void save(Command entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void update(Command entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void delete(int id) {
		this.entityDao.deleteById(id);
	}

	@Override
	public Command getById(Integer id) {
		return this.entityDao.getOne(id);
	}

	@Override
	public List<Command> getAll() {
		return this.entityDao.findAll();
	}

	@SuppressWarnings("serial")
	@Override
	public Page<Command> getPage(Pageable pageable, String keyword) {
		Page<Command> findAll = entityDao.findAll(new Specification<Command>() {
			@Override
			public Predicate toPredicate(Root<Command> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
		        List<Predicate> list = new ArrayList<Predicate>();
		        list.add(criteriaBuilder.equal(root.get("is_delete").as(int.class), 0));
		        Predicate[] p = new Predicate[list.size()];
		        return criteriaBuilder.and(list.toArray(p));				
			}
		}, pageable);
		return findAll;		
	}

	@Override
	public List<Command> getByCategory(String name) {
		return this.entityDao.getByCategory(name);	
	}

}
