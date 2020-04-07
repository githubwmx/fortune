package com.my.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
@Entity
@Table(name = "module_column")
public class ModuleColumn extends BaseEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id")
	private Integer id;
	private Date createtime, updatetime;
	private int is_delete;

	private String column_;
	private String name;
	private String nameUF; // 首字母大写
	private String raw_type;
	private String mybatis_type;
	private String comment_;
	@JsonIgnore
//	@ManyToOne
//	@JoinColumn(name="module_id")
//	private Module module;	
	private Integer module_id;
	
	@Override
	public String toString() {
		return "";
	}
	
	public ModuleColumn() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public int getIs_delete() {
		return is_delete;
	}

	public void setIs_delete(int is_delete) {
		this.is_delete = is_delete;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRaw_type() {
		return raw_type;
	}

	public void setRaw_type(String raw_type) {
		this.raw_type = raw_type;
	}

	public String getMybatis_type() {
		return mybatis_type;
	}

	public void setMybatis_type(String mybatis_type) {
		this.mybatis_type = mybatis_type;
	}

	public String getColumn_() {
		return column_;
	}

	public void setColumn_(String column_) {
		this.column_ = column_;
	}

	public String getComment_() {
		return comment_;
	}

	public void setComment_(String comment_) {
		this.comment_ = comment_;
	}

	public String getNameUF() {
		return nameUF;
	}

	public void setNameUF(String nameUF) {
		this.nameUF = nameUF;
	}

	public Integer getModule_id() {
		return module_id;
	}

	public void setModule_id(Integer module_id) {
		this.module_id = module_id;
	}
	
}
