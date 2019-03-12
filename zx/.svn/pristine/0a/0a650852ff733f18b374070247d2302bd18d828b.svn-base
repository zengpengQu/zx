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
 * 借取护照
 * Created by yuLei on 2018/7/23.
 */
@Entity
@Table(name = "BP_BORROW_PASSPORT", schema = "SCH_DUTY")
public class BorrowPassport extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(BorrowPassport.class);

    public BorrowPassport() {}

    /**
     * 团组批件号
     */
    @Getter
    @Setter
    public String batchNumber;

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
     * 护照ID
     */
    @Setter
    public BusinessPassport businessPassport;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = BusinessPassport.class)
    @JoinColumn(name = "PASSPORT_ID", referencedColumnName = "ID")
    public BusinessPassport getBusinessPassport() {

        if(businessPassport != null)
        {
            try {
                businessPassport.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 BusinessPassport businessPassport 错误",e);
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
        jsonObject.put("batchNumber", batchNumber);
        return jsonObject;
    }

}
