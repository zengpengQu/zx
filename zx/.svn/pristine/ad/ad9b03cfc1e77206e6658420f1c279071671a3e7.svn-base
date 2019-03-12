package com.taiji.frame.model.entity.foreignaffairs.passportRecord;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicUser;
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
 * 证件借用流转记录
 * Created by yuLei on 2018/8/1.
 */
@Entity
@Table(name = "DM_PPM_BORROW_RECORD", schema = "SCH_DUTY")
public class BorrowRecord extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(BorrowRecord.class);

    public BorrowRecord() {}

    /**
     * 借取人
     */
    @Getter
    @Setter
    private String borrower;

    /**
     * 归还人
     */
    @Getter
    @Setter
    private String returnPeople;

    /**
     * 经办人
     */
    @Setter
    public DicUser dicUser;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "AGENT", referencedColumnName = "ID")
    public DicUser getDicUser() {
        if(dicUser != null)
        {
            try {
                dicUser.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 DicUser dicUser  错误",e);
                return null;
            }
        }
        return dicUser;
    }

    /**
     * 借出时间
     */
    private Date borrowTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setBorrowTime(Date borrowTime) {
        this.borrowTime = borrowTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getBorrowTime() {
        return borrowTime;
    }

    /**
     * 归还时间
     */
    private Date returnTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setReturnTime(Date returnTime) {
        this.returnTime = returnTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getReturnTime() {
        return returnTime;
    }

    /**
     * 备注
     */
    @Getter
    @Setter
    private String notes;

    /**
     * 流转状态码(0:交出,1:借出,2:归还,3:取走,4:港澳通行证销毁状态)
     */
    @Getter
    @Setter
    private String status;

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
     * 证件/通行证ID
     */
    @Getter
    @Setter
    private String permitId;

    /**
     * 状态码(0:因私护照,1:赴台通行证,2:港澳通行证)
     */
    @Getter
    @Setter
    private String permitType;

    /**
     * 销毁原因
     */
    @Setter
    @Getter
    private String destroyReason;


    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("borrower", borrower);
        jsonObject.put("returnPeople", returnPeople);
        jsonObject.put("peopleId", null == getDicUser() ? "" : getDicUser().getId());
        jsonObject.put("empName", null == getDicUser() ? "" : getDicUser().getEmpName());
        jsonObject.put("borrowTime", DateUtil.dateToString(borrowTime, DateUtil.FORMAT_DAY));
        jsonObject.put("returnTime", DateUtil.dateToString(returnTime, DateUtil.FORMAT_DAY));
        jsonObject.put("notes", notes);
        jsonObject.put("status", status);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_TIME));
        jsonObject.put("permitId", permitId);
        jsonObject.put("permitType", permitType);
        if (status.equals("0")) {
            jsonObject.put("statusValue", "交出");
        } else if (status.equals("1")) {
            jsonObject.put("statusValue", "借出");
        } else if (status.equals("2")) {
            jsonObject.put("statusValue", "归还");
        } else if (status.equals("3")) {
            jsonObject.put("statusValue", "取走");
        }else if (status.equals("4")) {
            jsonObject.put("statusValue", "销毁");
        }
        jsonObject.put("destroyReason", destroyReason);
        return jsonObject;
    }
}
