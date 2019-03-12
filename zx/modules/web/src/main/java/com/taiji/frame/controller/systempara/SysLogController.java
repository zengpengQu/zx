package com.taiji.frame.controller.systempara;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.systempara.SysLog;
import com.taiji.frame.service.systempara.SysLogService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * 系统日志
 * Created by CHX on 2016/5/11.
 */
@Controller
@RequestMapping("syslog")
public class SysLogController extends BaseController<SysLog> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private SysLogService sysLogService;

    @RequestMapping(value = "/load.do",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String load(Carrier carrier, String searchName,String startTime,String endTime,String userId) {
        Map<String,Object> map = new HashMap<>();
        try {
            if (!StringUtils.isEmpty(searchName)) {
                map.put("searchName", "%"+searchName+"%");
            }
            if(!StringUtils.isEmpty(startTime)) {
                map.put("startTime", startTime);
            }
            if(!StringUtils.isEmpty(endTime)) {
                map.put("endTime", endTime);
            }
            if(!StringUtils.isEmpty(userId)) {
                map.put("userId", userId);
            }
            sysLogService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 跳转到角色信息管理页面
     * @param map
     * @return
     */
    @RequestMapping(value = "/list.do", method = RequestMethod.GET)
    public String list(Map<String,Object> map){
        return "systempara/log-list";
    }

}
