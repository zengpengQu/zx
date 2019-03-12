package com.taiji.frame.model.entity.foreignaffairs.taiwanCard;

import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @author qzp
 * @date 2018/08/10
 * 赴台信息列表人员实体
 */
@Entity
@Table(name = "DM_PPM_TAIWAN_INFO_USER",schema = "SCH_DUTY")
public class TaiWanInfoUser extends IdEntity implements Jsonable,Serializable {
    private static final Logger LOG = LoggerFactory.getLogger(TaiWanInfoUser.class);

    /**
     * 台湾信息
     */
    @Setter
    private TaiWanInfo taiWanInfo;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = TaiWanInfo.class)
    @JoinColumn(name = "TAIWAN_INFO_ID", referencedColumnName = "ID")
    public TaiWanInfo getTaiWanInfo() {
        if (taiWanInfo != null){
            try {
                taiWanInfo.getId();
            }catch (Exception e){
                return null;
            }
        }
        return taiWanInfo;
    }

    /**
     * 用户信息
     */
    @Setter
    private DicUser dicUser;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "TAIWAN_USER_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {
        if (dicUser != null){
            try {
                dicUser.getId();
            }catch (Exception e){
                return null;
            }
        }
        return dicUser;
    }

    /**
     * 部门信息
     */
    @Setter
    private DicDept dicDept;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "TAIWAN_DEPT_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {
        if(dicDept != null) {
            try {
                dicDept.getDeptName();
            } catch (Exception e) {
                LOG.error("获取关联对象 DicDept dicDept 错误", e);
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 赴台身份
     */
    @Setter
    @Getter
    private String degree;

    /**
     * 备注
     */
    @Setter
    @Getter
    private String notes;


    /**
     * 本职职务
     */
    @Setter
    @Getter
    private String duty;


    /**
     * 赴台职务
     */
    @Setter
    @Getter
    private String dutyTai;



    /**
     * 删除标志
     */
    @Setter
    @Getter
    private String delFlag;



    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",id);
        return jsonObject;
    }
}
