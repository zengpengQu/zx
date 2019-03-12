package com.taiji.frame.controller.foreignaffairs.come;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeVisitor;
import com.taiji.frame.service.foreignaffairs.come.ComeVisitorService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

/**
 * @author yx
 * @date 2018/8/14
 */
@Controller
@RequestMapping(value = "/come/come-visitor")
public class ComeVisitorController extends BaseController<ComeVisitor> {

    private static final Logger LOG = LoggerFactory.getLogger(ComeVisitorController.class);

    @Autowired
    ComeVisitorService comeVisitorService;

    /**
     * load grid 来访人员表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-visitor-list.do", produces = "text/html;charset=UTF-8")
    public String loadVisitorList(Carrier<ComeVisitor> carrier, String comeInfoId) {
        HashMap map = new HashMap(1);
        try {
            if (!StringUtils.isEmpty(comeInfoId)) {
                map.put("comeInfoId", comeInfoId);
            }
            comeVisitorService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

}
