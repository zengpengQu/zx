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
 * 民族
 * @author qzp
 * @date 2018/09/20
 */
@Entity
@Table(name = "TB_DIC_NATIONALITY",schema = "SCH_DUTY")
public class DicNationality extends IdEntity implements Jsonable {

    /**
     * 民族名
     */
    @Getter
    @Setter
    private String name;

    /**
     * 民族描述
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
        jsonObject.put("name", name);
        jsonObject.put("dscr", dscr);
        jsonObject.put("seq", seq);
        return jsonObject;
    }
}
