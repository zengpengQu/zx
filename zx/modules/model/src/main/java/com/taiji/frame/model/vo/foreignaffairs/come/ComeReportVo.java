package com.taiji.frame.model.vo.foreignaffairs.come;

import com.taiji.frame.model.entity.foreignaffairs.come.ComeReport;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 来访简报 Vo
 * @author yx
 */
public class ComeReportVo extends ComeReport implements Jsonable, Serializable{

    /**
     * 来访信息 ID
     */
    @Setter
    @Getter
    public String comeInfoId;

    /**
     * 报送单位
     */
    @Setter
    @Getter
    public String sendOrg;

    /**
     * 报送日期字符串
     */
    @Setter
    @Getter
    public String sendDateStr;

    /**
     * 简报标题
     */
    @Setter
    @Getter
    public String title;

    /**
     * 简报内容
     */
    @Setter
    @Getter
    public String content;

    /**
     * 附件 ID
     */
    @Setter
    @Getter
    public String fileIds;


}
