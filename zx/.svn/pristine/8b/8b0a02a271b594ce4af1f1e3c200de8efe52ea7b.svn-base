package com.taiji.frame.common.util.cache;

import com.google.common.collect.Lists;

import java.util.Collections;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;


/**
 * 保存数据方法
 * Created by WD on 2017/5/5.
 */
public class NetDataCache {

    private static Map<String, CacheList<?>> cacheListMap = Collections.synchronizedMap(new Hashtable<String, CacheList<?>>());

    public static <T> void putCacheList(Class<T> t, List<T> list)
    {
        String clazz = t.getName();
        CacheList<T> temp = (CacheList<T>) cacheListMap.get(clazz);
        if(null != temp)
        {
            List<T> tempList = temp.getList();
            tempList.clear();
            tempList.addAll(list);
        }
        else
        {
            temp = new CacheList<>();
            temp.setList(list);
            cacheListMap.put(clazz,temp);
        }
    }

    public static <T> List<T> getCacheList(Class<T> t)
    {
        List<T> list;
        String clazz = t.getName();
        CacheList<T> temp = (CacheList<T>) cacheListMap.get(clazz);
        if(null != temp)
        {
            list = temp.getList();
        }
        else
        {
            list = Lists.newArrayList();
        }

        return list;
    }
}
