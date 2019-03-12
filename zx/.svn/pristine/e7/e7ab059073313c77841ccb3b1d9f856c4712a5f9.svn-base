package com.taiji.frame.model.entity.foreignaffairs.taiwan;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.hibernate.annotations.Where;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author qzp
 * @date 2018/08/07
 * 台湾社团信息
 */
@Entity
@Table(name = "DM_PPM_TAIWAN_PARTY",schema = "SCH_DUTY")
public class TaiWanParty extends IdEntity implements Jsonable,Serializable {

    /**
     * 社团名称
     */
    @Setter
    @Getter
    private String partyName;

    /**
     * 社团简介
     */
    @Setter
    @Getter
    private String partyDesc;

    /**
     * 主要人士
     */
    @Setter
    List<TaiWanPolitics> taiWanPoliticsList;

    @OneToMany(cascade = CascadeType.ALL,fetch = FetchType.LAZY,mappedBy = "taiWanParty",targetEntity = TaiWanPolitics.class)
    @Where(clause = "DEL_FLAG = 0")
    public List<TaiWanPolitics> getTaiWanPoliticsList() {
        return taiWanPoliticsList;
    }

    /**
     * 与政协交往情况
     */
    @Setter
    @Getter
    private String cppccInteract;

    /**
     * 创建时间
     */
    private Date createTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 更新时间
     */
    private Date updateTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * 文件附件列表 list
     */
    @Setter
    private List<TaiWanPartyFile> wanPartyFileList;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "taiWanParty", targetEntity = TaiWanPartyFile.class)
    public List<TaiWanPartyFile> getWanPartyFileList() {
        return wanPartyFileList;
    }

    /**
     * 备注
     */
    @Getter
    @Setter
    private String notes;

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
        jsonObject.put("id",id);
        jsonObject.put("partyName",partyName);
        jsonObject.put("partyDesc",partyDesc);
        jsonObject.put("cppccInteract",cppccInteract);
        if (null != getTaiWanPoliticsList() && getTaiWanPoliticsList().size() > 0) {
            StringBuffer names = new StringBuffer();
            for (TaiWanPolitics taiWanPolitics : getTaiWanPoliticsList()) {
                String mainName = taiWanPolitics.getMainName();
                if(!mainName.equals("")) {
                    names.append(taiWanPolitics.getMainName() + ",");
                }
            }
            jsonObject.put("names", names.substring(0, names.length() - 1));
        } else {
            jsonObject.put("names", "无主要人士");
        }
        jsonObject.put("createTime",DateUtil.dateToString(createTime, DateUtil.FORMAT_DAY));
        jsonObject.put("updateTime",DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("notes",notes);
        jsonObject.put("delFlag",delFlag);
        if (null != getWanPartyFileList() && getWanPartyFileList().size() > 0){
            StringBuffer fileNames = new StringBuffer();
            for (int i = 0; i < getWanPartyFileList().size(); i ++) {
                if (getWanPartyFileList().size() - 1 == i) {
                    fileNames.append(getWanPartyFileList().get(i).getFileName());
                } else {
                    fileNames.append(getWanPartyFileList().get(i).getFileName() + "，");
                }
            }
            jsonObject.put("fileNames", fileNames.toString());
        } else {
            jsonObject.put("fileNames", "无附件");
        }
        return jsonObject;
    }
}
