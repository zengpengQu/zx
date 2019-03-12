package com.taiji.frame.model.vo.foreignaffairs.hkmacao;

import com.taiji.frame.model.entity.foreignaffairs.hkmacao.HkMaCao;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * @author qzp
 * @date 2018/08/02
 * 港澳通行证管理Vo
 */
public class HkMaCaoVo extends HkMaCao implements Jsonable,Serializable {

    /**
     * 附件 ID
     */
    @Setter
    @Getter
    public String fileId;

    /**
     * 港澳通行证ID
     */
    @Setter
    @Getter
    public String hkmacaoId;

    @Setter
    @Getter
    public String realName;

    /**
     * 人员姓名ID
     */
    @Setter
    @Getter
    private String peopleId;

    /**
     * 部门ID
     */
    @Setter
    @Getter
    private String department;

    /**
     * 签发日期
     */
    @Setter
    @Getter
    private String signDateStr;

    /**
     * 有效期至
     */
    @Setter
    @Getter
    private String validDateStr;
}
