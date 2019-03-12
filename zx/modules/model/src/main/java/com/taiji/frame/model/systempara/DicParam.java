package com.taiji.frame.model.systempara;

import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author yx
 * 通用字典表
 */
@Entity
@Table(name = "TB_DIC_PARAM", schema = "SCH_DUTY")
public class DicParam extends IdEntity implements Jsonable{

    /**
     * 字典分组
     */
    @Getter
    @Setter
    private Integer groupId;

    /**
     * 项目名
     */
    @Getter
    @Setter
    private String name;

    /**
     * 简称
     */
    @Getter
    @Setter
    private String simpleName;

    /**
     * 描述
     */
    @Getter
    @Setter
    private String dscr;

    /**
     * 顺序
     */
    @Getter
    @Setter
    private String seq;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("groupId", groupId);
        jsonObject.put("name", name);
        jsonObject.put("simpleName", simpleName);
        jsonObject.put("dscr", dscr);
        jsonObject.put("seq", seq);

        return jsonObject;
    }
}
