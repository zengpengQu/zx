package com.taiji.frame.controller.foreignaffairs.abroad;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadAirplane;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.abroad.AbroadAirplaneVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadAirplaneService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "/abroad-airplane")
public class AbroadAirplaneController extends BaseController<AbroadAirplane> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private AbroadAirplaneService abroadAirplaneService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 页面跳转
     */
    @RequestMapping(value = "/abroad-airplane-list", method = RequestMethod.GET)
    public String list(String abroadInfoId, ModelMap modelMap) {
        modelMap.addAttribute("abroadInfoId", abroadInfoId);
        return "foreignaffairs/abroad/abroad-airplane-list";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-airplane-list.do", produces = "text/html;charset=UTF-8")
    public String airplaneListLoad(Carrier<AbroadAirplane> carrier, AbroadAirplaneVo abroadAirplaneVo) {
        HashMap map = new HashMap(16);
        try {
            map.put("abroadInfoId", abroadAirplaneVo.getAbroadInfoId());
            abroadAirplaneService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑弹窗
     */
    @RequestMapping(value = "/load-airplane-edit.do", method = RequestMethod.GET)
    public String abroadAirplaneEdit(ModelMap modelMap, String id) {
        AbroadAirplane abroadAirplane = null;
        if (StringUtils.isNotEmpty(id)) {
            abroadAirplane = abroadAirplaneService.get(id);
        }
        modelMap.addAttribute("abroadAirplane", abroadAirplane);
        return "foreignaffairs/abroad/abroad-airplane-edit";
    }

    /**
     * 新增/编辑保存
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-airplane-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveAbroadAirplane(HttpServletRequest request, AbroadAirplaneVo abroadAirplaneVo) {
        Map<String, Object> map = new HashMap<>(2);

        AbroadAirplane abroadAirplane;
        if (StringUtils.isNotEmpty(abroadAirplaneVo.getId())) {
            abroadAirplane = abroadAirplaneService.get(abroadAirplaneVo.getId());
        } else {
            abroadAirplane = new AbroadAirplane();
            abroadAirplane.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
        }

        try {

            AbroadInfo abroadInfo = abroadInfoService.get(abroadAirplaneVo.getAbroadInfoId());
            abroadAirplane.setAbroadInfo(abroadInfo);

            abroadAirplane.setFlightNo(abroadAirplaneVo.getFlightNo());
            abroadAirplane.setFromName(abroadAirplaneVo.getFromName());
            abroadAirplane.setToName(abroadAirplaneVo.getToName());
            abroadAirplane.setAirModel(abroadAirplaneVo.getAirModel());
            abroadAirplane.setShippingChoose(abroadAirplaneVo.getShippingChoose());
            abroadAirplane.setTimeFlight(abroadAirplaneVo.getTimeFlight());
            abroadAirplane.setNoteInfo(abroadAirplaneVo.getNoteInfo());

            abroadAirplane.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
            abroadAirplane.setDelFlag("0");

            abroadAirplaneService.save(abroadAirplane);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
            if(org.apache.commons.lang.StringUtils.isEmpty(abroadAirplaneVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(abroadAirplane.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(abroadAirplane.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);

        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 删除
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-airplane-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteAbroadAirplane(String id) {
        Map<String, Object> map = new HashMap<>(2);
        try {
            AbroadAirplane abroadAirplane = abroadAirplaneService.get(id);
            //abroadAirplane.setDelFlag("1");
            //abroadAirplaneService.save(abroadAirplane);
            abroadAirplaneService.delete(abroadAirplane);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(abroadAirplane.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(abroadAirplane.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


}
