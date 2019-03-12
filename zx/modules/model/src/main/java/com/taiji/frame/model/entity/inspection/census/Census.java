package com.taiji.frame.model.entity.inspection.census;

import com.fasterxml.jackson.annotation.JsonFormat;
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
 * @author sy
 *
 */
@Entity
@Table(name = "PU_ADDRESS_TEAM", schema = "SCH_DUTY")
public class Census extends IdEntity implements Jsonable, Serializable {


    /**
     * 分组名称
     */
    @Getter
    @Setter
    public String teamName;



    /**
     * 是否叶子节点
     */
    @Getter
    @Setter
    public String isLeaf;

    /**
     * 填报日期
     */
    @Setter
    public Date createTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    public String delFlag;


    @Setter
    @Getter
    public String deptId;



    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        return jsonObject;
    }
}