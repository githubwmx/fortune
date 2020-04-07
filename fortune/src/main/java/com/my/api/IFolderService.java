package com.my.api;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.my.entity.Folder;

public interface IFolderService {

	void save(Folder entity);

	void update(Folder entity);

	void delete(int id);

	Folder getById(Integer id);

	List<Folder> getAll();

	Page<Folder> getPage(Pageable pageable, String keyword);

}
