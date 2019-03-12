package com.taiji.frame.model.systempara;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.Date;

/**
 * 系统日志
 * Created by CHX on 2016/5/11.
 */
@Entity
@Table(name="TB_SYS_LOG",schema = "SCH_DUTY")
public class SysLog extends IdEntity implements Jsonable {


    @Getter
    @Setter
    private  String urlDscr;

    @Getter
    @Setter
    private String updEmpId;

    @Getter
    @Setter
    private Date updDate;

    @Getter
    @Setter
    private String fromIp;

    @Getter
    @Setter
    private String dscr;

    @Getter
    @Setter
    private String updEmpName;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("urlDscr", urlDscr);
        jsonObject.put("fromIp",fromIp);
        jsonObject.put("dscr", dscr);
        jsonObject.put("updEmpName", updEmpName);
        jsonObject.put("updDate", DateUtil.dateToString(updDate,DateUtil.FORMAT_DAY_HOUR_MIN));
        return jsonObject;
    }
}
