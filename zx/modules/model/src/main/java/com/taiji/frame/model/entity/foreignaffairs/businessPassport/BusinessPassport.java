package com.taiji.frame.model.entity.foreignaffairs.businessPassport;

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
import java.util.List;

/**
 * 因公护照管理
 * Created by yuLei on 2018/7/23.
 */
@Entity
@Table(name = "BP_BUSINESS_PASSPORT", schema = "SCH_DUTY")
public class BusinessPassport extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(BusinessPassport.class);

    public BusinessPassport() {}

    /**
     * 护照持有人
     */
    @Setter
    public DicUser dicUser;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "USER_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {

        if(dicUser != null)
        {
            try {
                dicUser.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 DicUser dicUser 错误",e);
                return null;
            }
        }
        return dicUser;
    }

    /**
     * 护照号
     */
    @Getter
    @Setter
    private String passportNo;

    /**
     * 签发地点
     */
    @Getter
    @Setter
    private String issuePlace;

    /**
     * 签发日期
     */
    private Date issueDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getIssueDate() {
        return issueDate;
    }

    /**
     * 护照有效期
     */
    private Date validDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setValidDate(Date validDate) {
        this.validDate = validDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getValidDate() {
        return validDate;
    }

    /**
     * 保管单位
     */
    @Getter
    @Setter
    private String keepUnit;

    /**
     * 存放地址
     */
    @Getter
    @Setter
    private String storeAddress;

    /**
     * 注销日期
     */
    private Date cancelDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setCancelDate(Date cancelDate) {
        this.cancelDate = cancelDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getCancelDate() {
        return cancelDate;
    }

    /**
     * 注销理由
     */
    @Getter
    @Setter
    private String cancelReason;

    /**
     * 是否注销(0:未注销,1:注销)
     */
    @Getter
    @Setter
    private String isCancel;

    /**
     * 销毁日期
     */
    private Date destroyDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setDestroyDate(Date destroyDate) {
        this.destroyDate = destroyDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getDestroyDate() {
        return destroyDate;
    }

    /**
     * 销毁理由
     */
    @Getter
    @Setter
    private String destroyReason;

    /**
     * 是否销毁(0:未销毁,1:销毁)
     */
    @Getter
    @Setter
    private String isDestroy;

    /**
     * 注销并销毁理由
     */
    @Getter
    @Setter
    private String cancelAndDestroyReason;

    /**
     * 是否借出(0:未借出(归还),1:已借出)
     */
    @Getter
    @Setter
    private String isBorrow;

    /**
     * 是否已添加护照(0:未添加,1:添加)
     */
    @Getter
    @Setter
    private String isHavePassport;

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
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    private String delFlag;

    /**
     * 借取护照
     */
    @Setter
    private BorrowPassport borrowPassport;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "businessPassport", targetEntity = BorrowPassport.class)
    public BorrowPassport getBorrowPassport() {
        return borrowPassport;
    }

    /**
     * 归还护照
     */
    @Setter
    private ReturnPassport returnPassport;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "businessPassport", targetEntity = ReturnPassport.class)
    public ReturnPassport getReturnPassport() {
        return returnPassport;
    }

    /**
     * 因公护照操作记录
     */
    @Setter
    private List<BorrowReturnRecord> borrowReturnRecordList;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "businessPassport", targetEntity = BorrowReturnRecord.class)
    public List<BorrowReturnRecord> getBorrowReturnRecordList() {
        return borrowReturnRecordList;
    }

    /**
     * 附件关联表
     */
    @Setter
    private BusinessPassportFile businessPassportFile;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "businessPassport", targetEntity = BusinessPassportFile.class)
    public BusinessPassportFile getBusinessPassportFile() {
        return businessPassportFile;
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("userId", null == getDicUser() ? "" : getDicUser().getId());
        jsonObject.put("userName", null == getDicUser() ? "" : getDicUser().getEmpName());
        jsonObject.put("passportNo", passportNo);
        jsonObject.put("issuePlace", issuePlace);
        jsonObject.put("issueDate", DateUtil.dateToString(issueDate, DateUtil.FORMAT_DAY));
        jsonObject.put("validDate", DateUtil.dateToString(validDate, DateUtil.FORMAT_DAY));
        jsonObject.put("keepUnit", keepUnit);
        jsonObject.put("storeAddress", storeAddress);
        jsonObject.put("cancelDate", DateUtil.dateToString(cancelDate, DateUtil.FORMAT_DAY));
        jsonObject.put("cancelReason", cancelReason);
        jsonObject.put("isCancel", isCancel);
        jsonObject.put("isCancelStr", isCancel.equals("0") ? "未注销" : "已注销");
        jsonObject.put("destroyDate", DateUtil.dateToString(destroyDate, DateUtil.FORMAT_DAY));
        jsonObject.put("destroyReason", destroyReason);
        jsonObject.put("isDestroy", isDestroy);
        jsonObject.put("isDestroyStr", isDestroy.equals("0") ? "未销毁" : "已销毁");
        jsonObject.put("cancelAndDestroyReason", cancelAndDestroyReason);
        jsonObject.put("isBorrow", isBorrow);
        jsonObject.put("isHavePassport", isHavePassport);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("borrowPassportId", null == getBorrowPassport() ? "" : getBorrowPassport().getId());
        jsonObject.put("borrowAgent", null == getBorrowPassport() ? "" : getBorrowPassport().getBorrowAgent());
        jsonObject.put("borrowPerson", null == getBorrowPassport() ? "" : getBorrowPassport().getBorrowPerson());
        jsonObject.put("borrowPersonTel", null == getBorrowPassport() ? "" : getBorrowPassport().getBorrowPersonTel());
        jsonObject.put("returnDate", null == getBorrowPassport() ? "" : DateUtil.dateToString(getBorrowPassport().getReturnDate(), DateUtil.FORMAT_DAY));
        jsonObject.put("returnPassportId", null == getReturnPassport() ? "" : getReturnPassport().getId());
        jsonObject.put("returnAgent", null == getReturnPassport() ? "" : getReturnPassport().getReturnAgent());
        jsonObject.put("actualReturnDate", null == getReturnPassport() ? "" : DateUtil.dateToString(getReturnPassport().getActualReturnDate(), DateUtil.FORMAT_DAY));
        return jsonObject;
    }

}
