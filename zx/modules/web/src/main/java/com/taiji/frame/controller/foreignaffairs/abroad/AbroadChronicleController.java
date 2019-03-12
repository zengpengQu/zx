package com.taiji.frame.controller.foreignaffairs.abroad;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.Chronicle;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.abroad.AbroadChronicleVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadChronicleService;
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
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "/abroad-chronicle")
public class AbroadChronicleController extends BaseController<Chronicle> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private AbroadChronicleService abroadChronicleService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private SysLogService sysLogService;


    /**
     * 页面跳转
     */
    @RequestMapping(value = "/abroad-chronicle-list", method = RequestMethod.GET)
    public String list(String abroadInfoId, ModelMap modelMap) {
        modelMap.addAttribute("abroadInfoId", abroadInfoId);
        AbroadInfo abroadInfo = abroadInfoService.get(abroadInfoId);
        modelMap.put("abroadInfo", abroadInfo);
        return "foreignaffairs/abroad/abroad-chronicle-list";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-chronicle-list.do", produces = "text/html;charset=UTF-8")
    public String chronicleListLoad(Carrier<Chronicle> carrier, AbroadChronicleVo abroadChronicleVo) {
        HashMap map = new HashMap(16);
        try {
            if (!StringUtils.isEmpty(abroadChronicleVo.getAbroadInfoId())) {
                map.put("abroadInfoId", abroadChronicleVo.getAbroadInfoId());
            }
            abroadChronicleService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑弹窗
     */
    @RequestMapping(value = "/load-chronicle-edit.do", method = RequestMethod.GET)
    public String abroadChronicleEdit(ModelMap modelMap, String id) {
        Chronicle chronicle = null;
        if (!StringUtils.isEmpty(id)) {
            chronicle = abroadChronicleService.get(id);
        }
        modelMap.addAttribute("chronicle", chronicle);
        return "foreignaffairs/abroad/abroad-chronicle-edit";
    }

    /**
     * 新增/编辑保存
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-chronicle-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveAbroadChronicle(HttpServletRequest request, AbroadChronicleVo abroadChronicleVo) {
        Map<String, Object> map = new HashMap<>(2);

        Chronicle chronicle;
        String id = abroadChronicleVo.getId();
        if (id != null) {
            chronicle = abroadChronicleService.get(id);
        } else {
            chronicle = new Chronicle();
            chronicle.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
        }

        try {
            AbroadInfo abroadInfo = abroadInfoService.get(abroadChronicleVo.getAbroadInfoId());
            chronicle.setAbroadInfo(abroadInfo);

            chronicle.setGroupName(abroadInfo.getGroupName());
            chronicle.setDicParam(abroadInfo.getGroupLevel());
            chronicle.setContent(abroadChronicleVo.getContent());
            Date beginTime = DateUtil.stringToDate(abroadChronicleVo.getBeginTimeStr(), DateUtil.FORMAT_DAY);
            chronicle.setBeginTime(beginTime);
            Date endTime = DateUtil.stringToDate(abroadChronicleVo.getEndTimeStr(), DateUtil.FORMAT_DAY);
            chronicle.setEndTime(endTime);
            chronicle.setNotes(abroadChronicleVo.getNotes());

            chronicle.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
            chronicle.setDelFlag("0");

            abroadChronicleService.save(chronicle);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("大事记");
            if(org.apache.commons.lang.StringUtils.isEmpty(abroadChronicleVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(chronicle.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(chronicle.getId());
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
    @RequestMapping(value = "/abroad-chronicle-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteAbroadChronicle(String id) {
        Map<String, Object> map = new HashMap<>(2);
        try {
            Chronicle chronicle = abroadChronicleService.get(id);
            abroadChronicleService.delete(chronicle);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("大事记");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(chronicle.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(chronicle.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }



}
