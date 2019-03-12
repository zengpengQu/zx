package com.taiji.frame.common.constants;

/**
 * @author BT4900
 * 密级
 */

public enum SecretLevel {

    /**
     * 秘密
     * */
    SECRET("0"),
    /**
     * 机密
     * */
    CONFIDENCE("1"),
    /**
     * 绝密
     * */
    TOP_SECRET("2");

    private final String value;

    SecretLevel(String value) {
        this.value = value;
    }

    public String value(){
        return value;
    }
}
