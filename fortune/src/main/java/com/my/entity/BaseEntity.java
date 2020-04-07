package com.my.entity;

import javax.persistence.Transient;

public class BaseEntity {

    @Transient
    private String ids;

    public BaseEntity() {
    	
	}
    
	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}
    
}
