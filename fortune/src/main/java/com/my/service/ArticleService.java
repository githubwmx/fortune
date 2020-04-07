package com.my.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.my.api.IArticleService;
import com.my.dao.ArticleDao;
import com.my.entity.Article;

@Service
public class ArticleService implements IArticleService {

	@Autowired
	private ArticleDao entityDao;

	public ArticleDao getArticleDao() {
		return entityDao;
	}

	public void setArticleDao(ArticleDao ArticleDao) {
		this.entityDao = ArticleDao;
	}

	@Override
	public void save(Article entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void update(Article entity) {
		this.entityDao.save(entity);
	}

	@Override
	public void delete(int id) {
		this.entityDao.deleteById(id);
	}

	@Override
	public Article getById(Integer id) {
		return this.entityDao.getOne(id);
	}

	@Override
	public List<Article> getAll() {
		return this.entityDao.findAll();
	}

	@SuppressWarnings("serial")
	@Override
	public Page<Article> getPage(Pageable pageable, String keyword) {
		Page<Article> findAll = entityDao.findAll(new Specification<Article>() {
			@Override
			public Predicate toPredicate(Root<Article> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
		        List<Predicate> list = new ArrayList<Predicate>();
		        list.add(criteriaBuilder.equal(root.get("is_delete").as(int.class), 0));
		        Predicate[] p = new Predicate[list.size()];
		        return criteriaBuilder.and(list.toArray(p));				
			}
		}, pageable);
		return findAll;		
	}

	@Override
	public List<Article> getAllTitle() {
		return entityDao.getAllTitle();
	}

	@Override
	public List<Article> getByCategory(String name) {
		return entityDao.getByCategory(name);
	}

	@Override
	public List<Article> getByKeyword(String keyword) {
		String[] split = keyword.split(" ");
		if(split.length==1) {
			if(keyword.equals("interview")) {
				return entityDao.getInterviewAll();
			} else if(keyword.startsWith("【")) {
				return entityDao.getByKeyword4Interview(keyword);
			} else {
				List<Article> list1 = entityDao.getByKeywordTitleAllMatch(keyword);
				List<Article> list2 = entityDao.getByKeywordTitleLike(keyword);
				List<Article> list3 = entityDao.getByKeywordContentLike(keyword);
				list1.addAll(list2);
				list1.addAll(list3);
				removeInterview(list1);
				removeDuplicate(list1);
				return list1;
			}
		} else {
			List<Article> list = entityDao.getByKeywordTwo(split[0],split[1]);
			removeInterview(list);
			return list;
		}
	}

	private void removeDuplicate(List<Article> list) {
		List<Integer> ids = new ArrayList<Integer>();
		if(CollectionUtils.isNotEmpty(list)) {
			Iterator<Article> iterator = list.iterator();
			while(iterator.hasNext()) {
				Article next = iterator.next();
				if(ids.contains(next.getId())) {
					iterator.remove();
				} else {
					ids.add(next.getId());
				}
			}
		}		
	}

	private void removeInterview(List<Article> list) {
		if(CollectionUtils.isNotEmpty(list)) {
			Iterator<Article> iterator = list.iterator();
			while(iterator.hasNext()) {
				Article next = iterator.next();
				if(next.getCategory_name().startsWith("【")) {
					iterator.remove();
				}
			}
		}
	}

	@Override
	public List<Object[]> getAllCategory() {
		return entityDao.getAllCategory();
	}

	@Override
	public List<Article> getByRandom(Integer number) {
		return entityDao.getByRandom(number);
	}

	@Override
	public void deleteDel() {
		entityDao.deleteDel();
	}

	@Override
	public long getReviewCount() {
		return entityDao.getReviewCount();
	}
	
}
