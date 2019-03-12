package com.taiji.frame.model.util;


import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import java.io.Serializable;

//基类
@MappedSuperclass
public abstract class IdEntity implements Serializable {

	protected String id;

	@Id
	@Column(name = "ID")
	@GeneratedValue(generator = "system-uuid" )
	@GenericGenerator(strategy="com.taiji.frame.model.util.GeneratePK", name = "system-uuid")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		if("".equals(id))
    	{
    		id = null;
    	}
		this.id = id;
	}


    @Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		IdEntity other = (IdEntity) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
}
