package com.taiji.frame.common.util.cache;

import lombok.Getter;
import lombok.Setter;

/**
 * Created by CHX on 2016/1/30.
 */
public class CacheObject<T> {
    @Getter
    @Setter
    private T t;
}
