package com.taiji.frame.model.entity.inspection.place;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
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
 * @author sy
 * 活动安排表
 */
@Entity
@Table(name = "IN_ACT_LIST", schema = "SCH_DUTY")
public class Place extends IdEntity implements Jsonable, Serializable {

    /**
     * 来源类别
     */
    @Getter
    @Setter
    public String actTypeId;
    /**
     * 日期类别ID  暂无用
     */
    @Getter
    @Setter
    public String dateTypeId;

    /**
     * 承办单位ID
     */
    @Setter
    public DicDept dicDept;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "ORG_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {
        return dicDept;
    }
    /**
     * 发送状态
     * 0：未上报，1：已上报，2：已确认，
     * 3：未反馈，4：已发送需要调整原因，5：已调整
     * 8：已反馈
     */
    @Getter
    @Setter
    public String reportState;

    /**
     * 标题
     */
    @Getter
    @Setter
    public String title;

    /**
     * 年度
     */
    @Setter
    @Getter
    public String nowTime;
    /**
     * 备注
     */
    @Getter
    @Setter
    public String notes;
    /**
     * 保存，修改时间
     */
    @Setter
    public Date beginTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getBeginTime() {
        return beginTime;
    }
    /**
     * 结束时间（无用）
     */
    @Setter
    public Date endTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getEndTime() {
        return endTime;
    }

    /**
     * 地点
     */
    @Getter
    @Setter
    public String place;

    /**
     * 特殊地点
     */
    @Getter
    @Setter
    public String specialPlace;

    /**
     * 上报时间
     */
    @Setter
    public Date createTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }


    /**
     * 删除标志 0未删除
     */
    @Getter
    @Setter
    public String delFlag;



    /**
     * 反馈部门信息
     */
    @Setter
    public Feedback feedback;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = Feedback.class)
    @JoinColumn(name = "FEEDBACK_ID", referencedColumnName = "ID")
    public Feedback getFeedback() {
        return feedback;
    }

    /**
     * 操作人信息ID
     */
    @Setter
    public DicUser dicUser;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "DICUSER_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {
        return dicUser;
    }

    /**
     * 日期类型集合
     */
    @Setter
    private List<DateType> dateTypeLists;
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "placeId", targetEntity = DateType.class)
    @Where(clause = "DEL_FLAG = 0")
    public List<DateType> getDateTypeLists() {
        return dateTypeLists;
    }


    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("actTypeName", actTypeId);
        try{
            jsonObject.put("dicDeptName", dicDept== null ? "" : dicDept.getDeptName());
            jsonObject.put("dicDeptId", dicDept== null ? "" : dicDept.getId());
        }catch (Exception e){
            jsonObject.put("dicDeptName","");
            jsonObject.put("dicDeptId","");
        }

        jsonObject.put("title", title);
        jsonObject.put("place", place);
        jsonObject.put("createTime", DateUtil.dateToString(createTime,DateUtil.FORMAT_DAY));

        jsonObject.put("notes", notes);
        if(reportState!=null) {
            switch (reportState) {
                case "0":
                    jsonObject.put("statusStr", "待上报");
                    break;
                case "1":
                    jsonObject.put("statusStr", "待确认");
                    break;
                case "2":
                    jsonObject.put("statusStr", "待反馈");
                    break;
                case "3":
                    jsonObject.put("statusStr", "待反馈");
                    break;
                case "4":
                    jsonObject.put("statusStr", "待调整");
                    break;
                case "5":
                    jsonObject.put("statusStr", "待确认");
                    break;
                case "8":
                    jsonObject.put("statusStr", "已反馈");
                    break;
                default:
            }
        }
        jsonObject.put("status", reportState);
        jsonObject.put("nowTime",  nowTime);
        jsonObject.put("feedbackId", feedback== null ? "" : feedback.getId());
        jsonObject.put("specialPlace", specialPlace);

        try{
            //用于前台显示     str，地点 str2 时间
            //用于判断是否存在冲突  str3，时间地点相同，str4：月3次，str5：年6次 ，状态不为0是存在冲突\
            //定义长度，
            String[] str=null,str2=null,str3=null,str4=null,str5=null;
            if(this.dateTypeLists != null){
                int c = this.dateTypeLists.size();
                str = new String[c];
                str2 = new String[c];
                str3 = new String[c];
                str4 = new String[c];
                str5 = new String[c];
                for (int i = 0; i < this.dateTypeLists.size(); i++) {
                    DateType dateType = this.dateTypeLists.get(i);
                    if("0".equals(dateType.getDelFlag())){
                        //判断删除标志等于0的数据进行显示
                        str[i] = dateType.getPlace().getDistrictName();
                        String Str2_1="", Str2_2="";
                        if(dateType.getBeginTime()!=null) {
                            Str2_1 = DateUtil.getDateEarly(dateType.getBeginTime());
                        }
                        if(dateType.getEndTime()!=null){
                            Str2_2 = DateUtil.getDateEarly(dateType.getEndTime());
                        }

                        if("".equals(Str2_1)){
                            str2[i] = "(开始时间未确定) 至 "+Str2_2;
                        }
                        if("".equals(Str2_2)){
                            str2[i] = Str2_1+" 至 (结束时间未确定)";
                        }
                        if("".equals(Str2_2) && "".equals(Str2_1) ){
                            str2[i] = "(开始时间未确定) 至 (结束时间未确定)";
                        }
                        if(!"".equals(Str2_1) && !"".equals(Str2_2) ){
                            if(Str2_1.equals(Str2_2)){
                                str2[i] = Str2_1;
                            }else {
                                str2[i] = Str2_1 + " 至 " + Str2_2;
                            }
                        }
                        str3[i] = dateType.getIsClash();
                        str4[i] = dateType.getIsClashDay();
                        str5[i] = dateType.getIsClashYear();
                    }

                }
                jsonObject.put("dateType" ,str );
                jsonObject.put("dataTimes" ,str2);
                boolean yes = false;
                for(int i=0;i<str3.length;i++){
                    if(!"0".equals(str3[i]) || !"0".equals(str4[i]) || !"0".equals(str5[0])){
                        yes = true;
                        break;
                    }
                }
                jsonObject.put("isClashYes",yes);
                jsonObject.put("isClashDate",str3);
                jsonObject.put("isClashDateDay",str4);
                jsonObject.put("isClashDateYear",str5);
            }
        }catch (Exception e){
        }
        jsonObject.put("dataTime", DateUtil.dateToString(beginTime, DateUtil.FORMAT_DAY) == "" ?
                DateUtil.dateToString(beginTime, DateUtil.FORMAT_DAY_CN) :
                DateUtil.dateToString(beginTime, DateUtil.FORMAT_DAY_CN)+"至"+DateUtil.dateToString(endTime, DateUtil.FORMAT_DAY_CN));


        return jsonObject;
    }
}
