package com.taiji.frame.controller.foreignaffairs.tempForeignAffairs;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.Chronicle;
import com.taiji.frame.model.systempara.DicNation;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.service.foreignaffairs.tempForeignAffairs.ChronicleService;
import com.taiji.frame.service.systempara.DicNationService;
import com.taiji.frame.service.systempara.DicParamService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qzp
 * 大事记
 */
@Controller
@RequestMapping(value = "/chronicle")
public class ChronicleController extends BaseController<Chronicle> {
    private static final Logger LOG = LoggerFactory.getLogger(ChronicleController.class);

    @Autowired
    private ChronicleService chronicleService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private DicNationService dicNationService;

    /**
     * 页面跳转
     * @param map
     * @return
     */
    @RequestMapping(value = "/jump-to-chronicle-list",method = RequestMethod.GET)
    public String jumpList(Map<String,Object> map){
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(2);
        List<DicNation> dicNationList = dicNationService.findDicNationList();
        map.put("dicParamList",dicParamList);
        map.put("dicNationList",dicNationList);
        return "foreignaffairs/tempForeignAffairs/chronicle-list";
    }

    /**
     * 大事件表格展示
     * @param carrier 分页对象
     * @param groupLevel
     * @param beginTime
     * @param endTime
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-chronicle-list.do", produces = "text/html;charset=UTF-8")
    public String loadChronicle(Carrier<Chronicle> carrier,String groupLevel,String beginTime,String endTime,String nationalName){
        HashMap map = new HashMap(16);
        try {
            if (!StringUtils.isEmpty(groupLevel)) {
                map.put("groupLevel", groupLevel);
            }
            if (!StringUtils.isEmpty(beginTime)) {
                map.put("beginTime", beginTime);
            }
            if (!StringUtils.isEmpty(endTime)) {
                map.put("endTime", endTime);
            }
            if (!StringUtils.isEmpty(nationalName)) {
                map.put("nationalName", nationalName);
            }
            chronicleService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
//        System.out.println("数据为："+gridResult(carrier));
        return gridResult(carrier);
    }

}
