package com.taiji.frame.model.vo.pubinfo.batch;

import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.Transient;
import java.io.Serializable;

/**
 * 呈批件数据汇总的实体
 * @author wsh
 * @date 2018/9/20
 */
public class DataExportVo implements Jsonable,Serializable {

    /**
     * 标题或事由
     */
    @Getter
    @Setter
    public String title;

    /**
     * 报送单位
     */
    @Getter
    @Setter
    public String orgName;

    /**
     * 报送领导
     */
    @Setter
    @Getter
    public String leaName;

    /**
     * 上报的日期
     */
    @Getter
    @Setter
    public String sendTime;

    /**
     * 签报人
     *
     */
    @Getter
    @Setter
    public String signature;

    /**
     * 是否会签
     *
     */
    @Getter
    @Setter
    public String counterSignFlag;

    @Transient
    public String getCounterSignFlagStr() {
        if (null == counterSignFlag) {
            return "未知";
        } else if (counterSignFlag.equals("1")) {
            return "是";
        } else if (counterSignFlag.equals("0")) {
            return "否";
        } else {
            return "未知";
        }
    }


    /**
     *   会签单位
     */
    @Getter
    @Setter
    public String counterSignUnit;

    /**
     * 查询条件的开始时间
     *
     */
    @Setter
    @Getter
    public String startTime;

    /**
     * 查询条件的结束时间
     *
     */
    @Getter
    @Setter
    public String endTime;

    /**
     * 查询条件的关键字
     *
     */
    @Setter
    @Getter
    public String keyWord;

    /**
     * 查询条件的领导名称
     *
     */
    @Getter
    @Setter
    public String leader;

    /**
     * 查询条件中的报送单位或者承办单位
     *
     */
    @Setter
    @Getter
    public String dept;

    /**
     * 查询条件中的报送单位
     */
    @Setter
    @Getter
    public String deptId;

    /**
     * 数据导出中的流水号
     * @return
     */
    @Getter
    @Setter
    public String number;


    @Override
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();

        jsonObject.put("title",title == null ? "" : title);
        jsonObject.put("orgName",orgName == null ? "" : orgName);
        jsonObject.put("leaName",leaName == null ? "" : leaName);
        jsonObject.put("sendTime",sendTime == null ? "" :sendTime);
        jsonObject.put("signature",signature == null ? "":signature);
        jsonObject.put("counterSignFlag",counterSignFlag == null ? "" : counterSignFlag);
        jsonObject.put("counterSignFlagStr",getCounterSignFlagStr() == null ? "":this.getCounterSignFlagStr() );
        jsonObject.put("counterSignUnit",counterSignUnit == null ? "" :counterSignUnit);
        jsonObject.put("startTime",startTime == null ? "" :startTime);
        jsonObject.put("endTime",endTime == null ? "" :endTime);
        jsonObject.put("keyWord",keyWord == null ? "" :keyWord);
        jsonObject.put("leader",leader == null ? "" :leader);
        jsonObject.put("dept",dept == null ? "" :dept);
        jsonObject.put("number",number==null? "": number+"");

        return jsonObject;
    }
}
