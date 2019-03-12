package com.taiji.frame.model.entity.pubinfo.batch;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
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
 * @author wsh
 * @date 2018/9/18
 * 报送领导的信息管理
 */
@Entity
@Table(name = "PU_LEADER_MANAGE", schema = "SCH_DUTY")
public class LeaderManage extends IdEntity implements Jsonable {

    /**
     *   领导姓名
     * */
    @Getter
    @Setter
    public String leaName;

    /**
     * 职务的编号
     * */
    @Setter
    public DicDuty dicDuty;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDuty.class)
    @JoinColumn(name = "DUTY_ID", referencedColumnName = "ID")
    public DicDuty getDicDuty() {

        if(dicDuty != null)
        {
            try {
               dicDuty.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return dicDuty;
    }

    /**
     * 职务的名称
     *
     */
    @Getter
    @Setter
    public String duName;

    @Getter
    @Setter
    public String sex;//性别 0男性，1女性
    /**
     * 出生日期
     */
    public Date birthday;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getBirthday() {
        return birthday;
    }
    //秘书姓名
    @Getter
    @Setter
    public String secretart;
    @Getter
    @Setter
    public String phone;//手机号
    @Getter
    @Setter
    public String tel;//办公电话

    /**
     *  删除标志位
     */
    @Getter
    @Setter
    public String delFlag;

    /**
     * 职务的排序字段,暂时废除
     * @return
     */
    @Setter
    @Getter
    public String sort;

    /**
     * 人员的排序字段
     * @return
     */
    @Getter
    @Setter
    public Integer seq;

    @Transient
    public String getSexStr() {
        if (null == sex) {
            return "未知";
        } else if (sex.equals("1")) {
            return "男";
        } else if (sex.equals("0")) {
            return "女";
        } else {
            return "未知";
        }
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("leaName", leaName);
        jsonObject.put("seq",seq);
        jsonObject.put("dutyName", null == getDicDuty() ? "" : getDicDuty().getId());
        jsonObject.put("sex", sex);
        jsonObject.put("sexStr",getSexStr());
        jsonObject.put("birthday", DateUtil.dateToString(birthday,DateUtil.FORMAT_DAY));
        jsonObject.put("secretart", secretart);
        jsonObject.put("phone", phone);
        jsonObject.put("tel", tel);
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("sort",sort);
        jsonObject.put("duName",duName);
        return jsonObject;
    }


}
