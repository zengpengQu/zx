package com.taiji.frame.model.vo;

import com.taiji.frame.model.systempara.SysLog;
import lombok.Getter;
import lombok.Setter;

/**
 * 日志Vo
 * @author qzp
 * @date 2018/9/27
 */
public class SysLogVo extends SysLog {

    /**
     * 操作类型 0：新增 1：修改 2：删除 3：登录 4：重置密码,5:激活 & 禁用,6:导入，7:导出
     * */
    @Getter
    @Setter
    private int recordType;

    /**
     * entity ID
     * */
    @Getter
    @Setter
    private String entityId;

    /**
     * entity name
     * */
    @Getter
    @Setter
    private String entityName;

    /**
     * 用户信息
     * */
    @Getter
    @Setter
    private UserVo userVo;

    /**
     * 用户访问IP
     * */
    @Getter
    @Setter
    private String userIp;

    /**
     * 保存类型，如：值班日报、部门、督查...
     * */
    @Getter
    @Setter
    private String typeName;

    /**
     * 操作结果
     * */
    @Getter
    @Setter
    private String result;

    /**
     * 请求URL
     * */
    @Getter
    @Setter
    private String method;
}
