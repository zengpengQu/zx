package com.taiji.frame.controller.foreignaffairs.abroad;

import com.taiji.frame.controller.systempara.SysLogController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/abroad-gift")
public class AbroadGiftController {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);


    /**
     * 页面跳转
     */
    @RequestMapping(value = "/abroad-gift-list", method = RequestMethod.GET)
    public String list(String abroadInfoId, ModelMap modelMap) {
        modelMap.addAttribute("abroadInfoId", abroadInfoId);
        return "foreignaffairs/abroad/abroad-gift-list";
    }



}
