package com.taiji.frame.controller.foreignaffairs.abroad;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadNation;
import com.taiji.frame.model.systempara.DicNation;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.abroad.AbroadNationVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadNationService;
import com.taiji.frame.service.systempara.DicNationService;
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
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/abroad-nation")
public class AbroadNationController extends BaseController<AbroadNation> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private AbroadNationService abroadNationService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private DicNationService dicNationService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 页面跳转
     */
    @RequestMapping(value = "/abroad-nation-list", method = RequestMethod.GET)
    public String list(String abroadInfoId, ModelMap modelMap) {
        modelMap.addAttribute("abroadInfoId", abroadInfoId);
        return "foreignaffairs/abroad/abroad-nation-list";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-nation-list.do", produces = "text/html;charset=UTF-8")
    public String nationListLoad(Carrier<AbroadNation> carrier, AbroadNationVo abroadNationVo) {
        HashMap map = new HashMap(16);
        try {
            if (StringUtils.isNotEmpty(abroadNationVo.getAbroadInfoId())) {
                map.put("abroadInfoId", abroadNationVo.getAbroadInfoId());
                abroadNationService.load(carrier, map);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑弹窗
     */
    @RequestMapping(value = "/load-nation-edit.do", method = RequestMethod.GET)
    public String abroadNationEdit(ModelMap modelMap, String id) {
        AbroadNation abroadNation = null;
        if (StringUtils.isNotEmpty(id)) {
            abroadNation = abroadNationService.get(id);
        }
        List<DicNation> dicNationList = dicNationService.findDicNationList();
        modelMap.put("dicNationList", dicNationList);
        modelMap.addAttribute("abroadNation", abroadNation);
        return "foreignaffairs/abroad/abroad-nation-edit";
    }

    /**
     * 新增/编辑保存
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-nation-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveAbroadNation(HttpServletRequest request, AbroadNationVo abroadNationVo) {
        Map<String, Object> map = new HashMap<>(2);

        AbroadNation abroadNation;
        String id = abroadNationVo.getId();
        if (id != null) {
            abroadNation = abroadNationService.get(id);
        } else {
            abroadNation = new AbroadNation();
            abroadNation.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
        }

        try {
            AbroadInfo abroadInfo = abroadInfoService.get(abroadNationVo.getAbroadInfoId());
            abroadNation.setAbroadInfo(abroadInfo);

            if (StringUtils.isNotEmpty(abroadNationVo.getNationId())) {
                abroadNation.setNationId(abroadNationVo.getNationId());
                /*NationManagement nationManagement = nationManagementService.get(abroadNationVo.getNationId());
                abroadNation.setNationName(nationManagement.getNationName());*/
            }

            abroadNation.setNationName(abroadNationVo.getNationName());
            abroadNation.setUnitName(abroadNationVo.getUnitName());
            abroadNation.setForeignName(abroadNationVo.getForeignName());
            abroadNation.setChineseName(abroadNationVo.getChineseName());
            abroadNation.setTrsCountry(abroadNationVo.getTrsCountry());

            abroadNation.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
            abroadNation.setDelFlag("0");

            abroadNationService.save(abroadNation);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
            if(org.apache.commons.lang.StringUtils.isEmpty(abroadNationVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(abroadNation.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(abroadNation.getId());
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
    @RequestMapping(value = "/abroad-nation-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteAbroadNation(String id) {
        Map<String, Object> map = new HashMap<>(2);
        try {
            AbroadNation abroadNation = abroadNationService.get(id);
            abroadNationService.delete(abroadNation);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(abroadNation.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(abroadNation.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }



}
