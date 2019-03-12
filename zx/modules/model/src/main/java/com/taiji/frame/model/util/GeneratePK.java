package com.taiji.frame.model.util;

import org.hibernate.HibernateException;
import org.hibernate.MappingException;
import org.hibernate.dialect.Dialect;
import org.hibernate.engine.spi.SessionImplementor;
import org.hibernate.id.Configurable;
import org.hibernate.id.IdentifierGenerator;
import org.hibernate.type.Type;

import java.io.Serializable;
import java.util.Properties;
import java.util.UUID;

public class GeneratePK implements Configurable, IdentifierGenerator {

	@Override
	public void configure(Type type, Properties params, Dialect d)
			throws MappingException {
	}

	@Override
	public Serializable generate(SessionImplementor session, Object object)
			throws HibernateException {
		String Id = ((IdEntity)object).getId();
		
		if(Id != null && !"".equals(Id.trim()))
		{
			return Id;
		}
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

}
