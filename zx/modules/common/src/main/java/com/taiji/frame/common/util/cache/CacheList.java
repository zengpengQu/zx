package com.taiji.frame.common.util.cache;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * Created by CHX on 2016/1/30.
 */
public class CacheList<T> {
    @Getter
    @Setter
    private List<T> list;
}
