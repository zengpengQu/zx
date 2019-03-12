package com.taiji.frame.common.constants;

public enum  DefaultPassword {

    // 默认密码
    pass("qwerty");

    public String value() {
        return value;
    }

    private final String value;
    DefaultPassword(String value) {
        this.value = value;
    }
}
