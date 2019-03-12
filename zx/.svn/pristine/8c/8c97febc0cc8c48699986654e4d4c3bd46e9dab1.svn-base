package com.taiji.frame.common.util;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.beanutils.DynaBean;
import org.apache.commons.beanutils.DynaProperty;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;

/**
 * @author pengyx
 */
public class BeanCopyUtil extends BeanUtilsBean {

    private static final Logger log = LoggerFactory.getLogger(BeanCopyUtil.class);

    public void copyNotNullProperties(Object orig, Object dest, boolean ignoreNullFlag)
            throws IllegalAccessException, InvocationTargetException {

        if (dest == null) {
            throw new IllegalArgumentException
                    ("No destination bean specified");
        }
        if (orig == null) {
            throw new IllegalArgumentException("No origin bean specified");
        }
        if (log.isDebugEnabled()) {
            log.debug("BeanUtils.copyProperties(" + dest + ", " +
                    orig + "," + ignoreNullFlag + ")");
        }
        if (orig instanceof DynaBean) {
            DynaProperty[] origDescriptors =
                    ((DynaBean) orig).getDynaClass().getDynaProperties();
            for (int i = 0; i < origDescriptors.length; i++) {
                String name = origDescriptors[i].getName();
                if (getPropertyUtils().isReadable(orig, name) && getPropertyUtils().isWriteable(dest, name)) {
                    Object value = ((DynaBean) orig).get(name);
                    if (ignoreNullFlag) {
                        if (value != null) {
                            copyProperty(dest, name, value);
                        }
                    } else {
                        copyProperty(dest, name, value);
                    }
                }
            }
        } else if (orig instanceof Map) {
            @SuppressWarnings("unchecked")
            Map<String, Object> propMap = (Map<String, Object>) orig;
            for (Map.Entry<String, Object> entry : propMap.entrySet()) {
                String name = entry.getKey();
                Object value = entry.getValue();
                if (getPropertyUtils().isWriteable(dest, name)) {
                    if (ignoreNullFlag) {
                        if (value != null) {
                            copyProperty(dest, name, value);
                        }
                    } else {
                        copyProperty(dest, name, value);
                    }
                }
            }
        } else {
            PropertyDescriptor[] origDescriptors = getPropertyUtils().getPropertyDescriptors(orig);
            for (int i = 0; i < origDescriptors.length; i++) {
                String name = origDescriptors[i].getName();
                if ("class".equals(name)) {
                    continue;
                }
                if (getPropertyUtils().isReadable(orig, name) && getPropertyUtils().isWriteable(dest, name)) {
                    try {
                        Object value = getPropertyUtils().getSimpleProperty(orig, name);
                        if (ignoreNullFlag) {
                            if (value != null) {
                                copyProperty(dest, name, value);
                            }
                        } else {
                            copyProperty(dest, name, value);
                        }
                    } catch (NoSuchMethodException e) {
                        // Should not happen
                    }
                }
            }
        }
    }
}
