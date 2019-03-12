package com.taiji.frame.common.constants;


/**
 * 卫士通资源信息状态：0-在用，1-停用，2-销毁
 */
public enum ResourceStatus {

    /**
     * 在用
     */
    IN_USE(0),

    /**
     * 停用
     */
    DEPRECATED(1),

    /**
     * 销毁
     */
    DESTROYED(2);


    private final Integer value;

    ResourceStatus(Integer value) {
        this.value = value;
    }

    public Integer value() {
        return value;
    }
}
