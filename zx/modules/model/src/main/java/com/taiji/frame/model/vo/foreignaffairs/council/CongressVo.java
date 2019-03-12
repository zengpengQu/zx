package com.taiji.frame.model.vo.foreignaffairs.council;

import com.taiji.frame.model.entity.foreignaffairs.council.Congress;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;


/**
 * @author sy
 */
public class CongressVo extends Congress implements Serializable {

    /**
     * 会议标题
     */
    @Getter
    @Setter
    public String title;

    @Setter
    @Getter
    public  String isNo;

    /**
     * 会议时间
     */
    @Setter
    @Getter
    public String timeStr;
    /**
     * 会议地点
     */
    @Getter
    @Setter
    public String meetingSite;
    /**
     * 会议其它备注
     */
    @Getter
    @Setter
    public String  other;
    /**
     * 会议内容
     */
    @Getter
    @Setter
    public String content;


    @Getter
    @Setter
    public String userNames;

}
