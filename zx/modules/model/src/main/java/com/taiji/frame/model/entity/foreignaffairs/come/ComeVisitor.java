package com.taiji.frame.model.entity.foreignaffairs.come;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;


/**
 * 来访外方人员
 *
 * @author yx
 */
@Entity
@Table(name = "FA_CVM_VISITOR", schema = "SCH_DUTY")
public class ComeVisitor extends IdEntity implements Jsonable, Serializable{

    private static final Logger LOG = LoggerFactory.getLogger(ComeVisitor.class);

    /**
     * 来访基本信息
     */
    @Setter
    public ComeInfo comeInfo;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = ComeInfo.class)
    @JoinColumn(name = "BASICINFO_ID", referencedColumnName = "ID")
    public ComeInfo getComeInfo() {
        if (comeInfo != null) {
            try {
                comeInfo.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 ComeInfo comeInfo 错误", e);
                return null;
            }
        }
        return comeInfo;
    }

    /**
     * 角色
     */
    @Setter
    private DicParam dicParam;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "ROLE_ID", referencedColumnName = "ID")
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
     * 姓名
     */
    @Setter
    @Getter
    public String name;

    /**
     * 中文名
     */
    @Setter
    @Getter
    public String cnName;
    /**
     * 性别
     */
    @Setter
    @Getter
    public String sex;

    /**
     * 电话
     */
    @Setter
    @Getter
    public String tel;

    /**
     * 生日
     */
    @Setter
    public Date birthday;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getBirthday() {
        return birthday;
    }

    /**
     * 职位
     */
    @Setter
    @Getter
    public String duty;

    /**
     * 备注
     */
    @Setter
    @Getter
    public String notes;

    /**
     * 更新时间
     */
    public Date updateTime;

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
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    public String delFlag;

    /**
     * 顺序
     */
    @Setter
    @Getter
    public Integer seq;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("comeInfoId", getComeInfo() == null ? "" : getComeInfo().getId());
        jsonObject.put("name", name);
        jsonObject.put("cnName", cnName);
        jsonObject.put("roleId", getDicParam() == null ? "" : getDicParam().getId());
        jsonObject.put("roleName", getDicParam() == null ? "" : getDicParam().getName());
        jsonObject.put("sex", sex);
        if ("0".equals(sex)) {
            jsonObject.put("sexStr", "男");
        } else if ("1".equals(sex)) {
            jsonObject.put("sexStr", "女");
        }
        jsonObject.put("tel", tel);
        jsonObject.put("birthdayStr", DateUtil.dateToString(birthday, DateUtil.FORMAT_DAY));
        jsonObject.put("duty", duty);
        jsonObject.put("notes", notes);
        jsonObject.put("seq", seq);

        return jsonObject;
    }
}
