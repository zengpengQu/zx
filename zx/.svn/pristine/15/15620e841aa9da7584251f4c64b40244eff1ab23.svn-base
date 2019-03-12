package com.taiji.frame.controller.foreignaffairs.abroad;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.businessPassport.BusinessPassport;
import com.taiji.frame.model.vo.foreignaffairs.abroad.AbroadPassportVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadPassportService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

@Controller
@RequestMapping(value = "/abroad-passport")
public class AbroadPassportController extends BaseController<BusinessPassport> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private AbroadPassportService abroadPassportService;


    /**
     * 页面跳转
     */
    @RequestMapping(value = "/abroad-passport-list", method = RequestMethod.GET)
    public String list(String abroadInfoId, ModelMap modelMap) {
        modelMap.addAttribute("abroadInfoId", abroadInfoId);
        return "foreignaffairs/abroad/abroad-passport-list";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-passport-list.do", produces = "text/html;charset=UTF-8")
    public String passportListLoad(Carrier<BusinessPassport> carrier, AbroadPassportVo abroadPassportVo) {
        HashMap map = new HashMap(16);
        try {
            if (StringUtils.isNotEmpty(abroadPassportVo.getAbroadInfoId())) {
                map.put("abroadInfoId", abroadPassportVo.getAbroadInfoId());
                abroadPassportService.load(carrier, map);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }



}
