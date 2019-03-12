package com.taiji.frame.controller.foreignaffairs.passportRecord;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.passportRecord.AskReturnRecord;
import com.taiji.frame.service.foreignaffairs.passportRecord.AskReturnRecordService;
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
import java.util.List;
import java.util.Map;

/**
 * 证照催还记录
 * Created by yuLei on 2018/8/2.
 */
@Controller
@RequestMapping(value = "/ask-return")
public class AskReturnRecordController extends BaseController<AskReturnRecord> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AskReturnRecordService askReturnRecordService;

    /**
     * 跳转至列表页
     * @param map
     * @return
     */
    @RequestMapping(value = "/ask-return-list", method = RequestMethod.GET)
    public String list(Map<String, Object> map) {
        return "foreignaffairs/passportRecord/ask-return-list";
    }

    /**
     * 组装表格数据
     * @param carrier
     * @param peopleName
     * @param documentCode
     * @param startTime
     * @param endTime
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-ask-return-list.do", produces = "text/html;charset=UTF-8")
    public String load(Carrier<AskReturnRecord> carrier, String peopleName, String documentCode, String startTime, String endTime) {
        HashMap<String, Object> map = new HashMap();
        try {
            if (StringUtils.isNotEmpty(peopleName)) {
                map.put("peopleName", "%" + peopleName + "%");
            }
            if (StringUtils.isNotEmpty(documentCode)) {
                map.put("documentCode", "%" + documentCode + "%");
            }
            if (StringUtils.isNotEmpty(startTime)) {
                map.put("startTime", startTime);
            }
            if (StringUtils.isNotEmpty(endTime)) {
                map.put("endTime", endTime);
            }
            askReturnRecordService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

}
