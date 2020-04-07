package com.my.api;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.my.entity.Command;

public interface ICommandService {

	void save(Command entity);

	void update(Command entity);

	void delete(int id);

	Command getById(Integer id);

	List<Command> getAll();

	Page<Command> getPage(Pageable pageable, String keyword);

	List<Command> getByCategory(String name);

}
