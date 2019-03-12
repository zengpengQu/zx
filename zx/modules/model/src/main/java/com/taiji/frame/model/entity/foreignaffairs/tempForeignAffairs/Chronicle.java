package com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 大事记
 * Created by yuLei on 2018/7/17.
 */
@Entity
@Table(name = "DM_CHR_CHRONICLE", schema = "SCH_DUTY")
public class Chronicle extends IdEntity implements Jsonable, Serializable {

    public Chronicle() {}

    @Setter
    private TempAffairs tempAffairs;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = TempAffairs.class)
    @JoinColumn(name = "TEMPAFFAIR_ID", referencedColumnName = "ID")
    public TempAffairs getTempAffairs() {
        return tempAffairs;
    }

    /**
     * 外事出访
     */
    @Setter
    private AbroadInfo abroadInfo;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = AbroadInfo.class)
    @JoinColumn(name = "ABROADINFO_ID", referencedColumnName = "ID")
    public AbroadInfo getAbroadInfo() {
        return abroadInfo;
    }

    /**
     * 外事来访
     */
    @Setter
    private ComeInfo comeInfo;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = ComeInfo.class)
    @JoinColumn(name = "COME_AFFAIR_ID", referencedColumnName = "ID")
    public ComeInfo getComeInfo() {
        return comeInfo;
    }

    /**
     * 团组名称
     */
    @Getter
    @Setter
    private String groupName;

    /**
     * 团组级别
     */
    @Setter
    private DicParam dicParam;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "GROUP_LEVEL", referencedColumnName = "ID")
    public DicParam getDicParam(){
        if (dicParam != null){
            try {
                dicParam.getId();
            }catch (Exception e){
                return null;
            }
        }
        return dicParam;
    }

    /**
     * 开始时间
     */
    private Date beginTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getBeginTime() {
        return beginTime;
    }

    /**
     * 结束时间
     */
    private Date endTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getEndTime() {
        return endTime;
    }

    /**
     * 内容
     */
    @Getter
    @Setter
    private String content;

    /**
     * 备注
     */
    @Getter
    @Setter
    private String notes;

    /**
     * 创建时间
     */
    public Date createTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 更新时间
     */
    public Date updateTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * 国家名称
     */
    @Setter
    @Getter
    private String nationalName;

    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    private String delFlag;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("groupName", groupName);
        jsonObject.put("groupLevelId", getDicParam() == null ? "" : this.getDicParam().getId());
        jsonObject.put("groupLevel", getDicParam() == null ? "" : this.getDicParam().getName());
        jsonObject.put("beginTime", beginTime);
        jsonObject.put("endTime", endTime);
        jsonObject.put("beginTimeStr", DateUtil.dateToString(beginTime, DateUtil.FORMAT_DAY));
        jsonObject.put("endTimeStr", DateUtil.dateToString(endTime, DateUtil.FORMAT_DAY));
        jsonObject.put("notes", notes);
        jsonObject.put("content",content);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("nationalName", nationalName);
        jsonObject.put("delFlag", delFlag);
        return jsonObject;
    }

}
