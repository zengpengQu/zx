package com.taiji.frame.model.vo.passportuser;

import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import java.beans.Transient;
import java.io.Serializable;

/**
 * 证件办理用户 Vo
 *
 * @date 2018.12.25
 */
public class PassportUserVo implements Jsonable, Serializable{

    @Getter
    @Setter
    private String id;

    /**
     * 姓名
     */
    @Getter
    @Setter
    private String empName;

    @Getter
    @Setter
    private String sex;

    @Getter
    @Setter
    private String nation;

    @Getter
    @Setter
    private String birthday;

    @Getter
    @Setter
    private String birthplace;

    @Getter
    @Setter
    private String phone;

    @Getter
    @Setter
    private String deptName;

    @Getter
    @Setter
    private String mainDuty;

    @Getter
    @Setter
    private String rankName;

    /**
     * 证件办理状态
     */
    @Getter
    @Setter
    private String transactStatus;


    @javax.persistence.Transient
    public String getSexStr() {
        if (null == sex) {
            return "未知";
        } else if (sex.equals("0")) {
            return "男";
        } else if (sex.equals("1")) {
            return "女";
        } else {
            return "未知";
        }
    }

    @Transient
    @Override
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("deptName", deptName == null? "" : deptName);
        jsonObject.put("empName", empName== null? "" : empName);
        jsonObject.put("phone", phone== null? "" : phone);
        jsonObject.put("sexStr", getSexStr());
        jsonObject.put("rankName", rankName== null? "" : rankName);
        jsonObject.put("nation", nation== null? "" : nation);
        jsonObject.put("birthday", birthday == null? "" : birthday);
        jsonObject.put("birthplace", birthplace== null? "" : birthplace);
        jsonObject.put("mainDuty", mainDuty== null? "" : mainDuty);
        jsonObject.put("transactStatus", null != transactStatus);

        return jsonObject;
    }
}
