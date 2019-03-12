package com.taiji.frame.controller.foreignaffairs.abroad;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadGroupUserService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.systempara.DicDeptService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/abroad-group-user")
public class ImportUserController extends BaseController<DicUser> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private AbroadGroupUserService abroadGroupUserService;

    @Autowired
    private DicDeptService dicDeptService;


    /**
     * 页面跳转
     */
    @RequestMapping(value = "/abroad-user-list", method = RequestMethod.GET)
    public String list(String abroadInfoId, String comeInfoId, Map<String, Object> map) {
        map.put("abroadInfoId", abroadInfoId);
        map.put("comeInfoId", comeInfoId);

        return "foreignaffairs/abroad/abroad-group-import";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-user-list.do", produces = "text/html;charset=UTF-8")
    public String userListLoad(Carrier<DicUser> carrier, String userName, String deptId,
                               String abroadInfoId, String comeInfoId) {
        HashMap map = new HashMap(16);
        try {
            if (StringUtils.isNotEmpty(abroadInfoId)) {
                map.put("abroadInfoId", abroadInfoId);
            }

            if (StringUtils.isNotEmpty(comeInfoId)) {
                map.put("comeInfoId", comeInfoId);
            }

            if (StringUtils.isNotEmpty(userName)) {
                map.put("userName", "%"+ userName +"%");
            }

            if (StringUtils.isNotEmpty(deptId)) {
                List<DicDept> deptList = dicDeptService.getBelongDept(deptId);
                if (deptList.size() > 0) {
                    List<String> deptIds = new ArrayList<>();
                    for (DicDept dicDept : deptList) {
                        deptIds.add(dicDept.getId());
                    }
                    map.put("deptIds", deptIds);
                }
            }
            abroadGroupUserService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }



}
