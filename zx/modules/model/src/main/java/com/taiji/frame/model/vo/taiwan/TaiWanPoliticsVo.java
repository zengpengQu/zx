package com.taiji.frame.model.vo.taiwan;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * @author qzp
 * @date 2018/08/07
 * 台湾主要人士
 */
public class TaiWanPoliticsVo implements Serializable {

    @Setter
    @Getter
    private String id;

    /**
     * 姓名
     */
    @Setter
    @Getter
    private String mainName;

    /**
     * 性别 0男性，1女性
     */
    @Setter
    @Getter
    private String gender;


    /**
     * 出生日期
     */
    @Setter
    @Getter
    private String birthdayStr;

    /**
     * 所属单位
     */
    @Setter
    @Getter
    private String belongOrg;

    /**
     * 职务
     */
    @Setter
    @Getter
    private String duty;


    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    private String delFlag;

}
