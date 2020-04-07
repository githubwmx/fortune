package com.my.api;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.my.entity.Copy;

public interface ICopyService {

	void save(Copy entity);

	void update(Copy entity);

	void delete(int id);

	Copy getById(Integer id);

	List<Copy> getAll();

	Page<Copy> getPage(Pageable pageable, String keyword);

}
