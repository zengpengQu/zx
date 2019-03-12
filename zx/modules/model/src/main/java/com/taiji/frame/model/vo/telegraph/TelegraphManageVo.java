package com.taiji.frame.model.vo.telegraph;

import com.taiji.frame.model.entity.foreignaffairs.telegraph.TelegraphManage;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 电报管理Vo
 * @author qzp
 * @date 2018/07/26
 */
public class TelegraphManageVo extends TelegraphManage implements Jsonable,Serializable {

    /**
     * 附件ID
     */
    @Setter
    @Getter
    private String fileIds;

    /**
     * 电报ID
     */
    @Setter
    @Getter
    private String telegraphId;

    /**
     * 接收日期
     */
    @Getter
    @Setter
    private String receiveTimeStr;
}
