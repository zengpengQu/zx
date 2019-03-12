package com.taiji.frame.model.entity.foreignaffairs.businessPassport;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
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
 * 因公护照借出归还操作记录
 * Created by yuLei on 2018/7/27.
 */
@Entity
@Table(name = "BP_BORROW_RETURN_PASSPORT_RECORD", schema = "SCH_DUTY")
public class BorrowReturnRecord extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(BorrowReturnRecord.class);

    public BorrowReturnRecord() {}

    /**
     * 借取人
     */
    @Getter
    @Setter
    private String borrowPerson;

    /**
     * 借取人电话
     */
    @Getter
    @Setter
    private String borrowPersonTel;

    /**
     * 应归还日期
     */
    private Date returnDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getReturnDate() {
        return returnDate;
    }

    /**
     * 借出经办人
     */
    @Getter
    @Setter
    private String borrowAgent;

    /**
     * 实际归还日期
     */
    private Date actualReturnDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setActualReturnDate(Date actualReturnDate) {
        this.actualReturnDate = actualReturnDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getActualReturnDate() {
        return actualReturnDate;
    }

    /**
     * 归还经办人
     */
    @Getter
    @Setter
    private String returnAgent;

    /**
     * 护照ID
     */
    @Setter
    public BusinessPassport businessPassport;

    /**
     * 状态码(0:注销,1:销毁,2:注销并销毁,3:借出,4:归还)
     */
    @Getter
    @Setter
    private String status;

    /**
     * 注销理由
     */
    @Getter
    @Setter
    private String cancelReason;

    /**
     * 销毁理由
     */
    @Getter
    @Setter
    private String destroyReason;

    /**
     * 注销并销毁理由
     */
    @Setter
    @Getter
    private String cancelAndDestroyReason;

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

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = BusinessPassport.class)
    @JoinColumn(name = "PASSPORT_ID", referencedColumnName = "ID")
    public BusinessPassport getBusinessPassport() {

        if(businessPassport != null)
        {
            try {
                businessPassport.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 BusinessPassport businessPassport 错误 ",e);
                return null;
            }
        }
        return businessPassport;
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("borrowPerson", borrowPerson);
        jsonObject.put("borrowPersonTel", borrowPersonTel);
        jsonObject.put("returnDate", DateUtil.dateToString(returnDate, DateUtil.FORMAT_DAY));
        jsonObject.put("borrowAgent", borrowAgent);
        jsonObject.put("actualReturnDate", DateUtil.dateToString(actualReturnDate, DateUtil.FORMAT_DAY));
        jsonObject.put("returnAgent", returnAgent);
        jsonObject.put("status", status);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_TIME));
        if (status.equals("0")) {
            jsonObject.put("statusValue", "注销");
        } else if (status.equals("1")) {
            jsonObject.put("statusValue", "销毁");
        } else if (status.equals("2")) {
            jsonObject.put("statusValue", "注销并销毁");
        } else if (status.equals("3")) {
            jsonObject.put("statusValue", "借出");
        } else if (status.equals("4")) {
            jsonObject.put("statusValue", "归还");
        }
        jsonObject.put("cancelReason", cancelReason);
        jsonObject.put("destroyReason", destroyReason);
        jsonObject.put("cancelAndDestroyReason", cancelAndDestroyReason);
        return jsonObject;
    }

}
