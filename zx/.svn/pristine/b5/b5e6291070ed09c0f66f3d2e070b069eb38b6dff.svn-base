package com.taiji.frame.controller.foreignaffairs.taiwan;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.taiwan.TaiWanParty;
import com.taiji.frame.model.entity.foreignaffairs.taiwan.TaiWanPolitics;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.service.foreignaffairs.taiwan.TaiWanPartyService;
import com.taiji.frame.service.foreignaffairs.taiwan.TaiWanPoliticsService;
import com.taiji.frame.service.systempara.SysLogService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qzp
 * @date 2018/08/07
 * 台湾主要人士控制器
 */
@Controller
@RequestMapping(value = "/taiwan-politics")
public class TaiWanPoliticsController extends BaseController<TaiWanPolitics> {

    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanPoliticsController.class);

    @Autowired
    private TaiWanPoliticsService taiWanPoliticsService;

    @Autowired
    private TaiWanPartyService taiWanPartyService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 页面跳转
     * @return
     */
    @RequestMapping(value = "/taiwan-politics-list",method = RequestMethod.GET)
    public String jumpPage(){
        return "foreignaffairs/taiwan/taiwan-politics-list";
    }

    /**
     * 台湾主要人士信息列表
     * @param carrier
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-taiwan-politics-list.do",produces = "text/html;charset=UTF-8")
    public String list(Carrier<TaiWanPolitics> carrier, String mainName){
        Map<String, Object> map = new HashMap<String, Object>(1);
        try {
            if (StringUtils.isNotEmpty(mainName)){
                map.put("mainName","%" + mainName + "%");
            }
            taiWanPoliticsService.load(carrier,map);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(),e);
        }
        System.out.println("haha: "+gridResult(carrier));
        return gridResult(carrier);
    }

    /**
     * 台湾社团下的主要人士详情
     * @param carrier
     * @param partyId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-taiwan-politics-view-list.do",produces = "text/html;charset=UTF-8")
    public String viewList(Carrier<TaiWanPolitics> carrier, String partyId){
        Map<String, Object> map = new HashMap<String, Object>(1);
        try {
            if (StringUtils.isNotEmpty(partyId)){
                map.put("partyId",partyId);
            }
            taiWanPoliticsService.viewLoad(carrier,map);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(),e);
        }
        return gridResult(carrier);
    }

    /**
     * 跳转到新增或编辑页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-taiwan-politics-edit",method = RequestMethod.GET)
    public String jumpEditPage(ModelMap modelMap, String id){
        TaiWanPolitics taiWanPolitics = null;
        if(StringUtils.isNotEmpty(id)){
            //编辑
            taiWanPolitics = taiWanPoliticsService.get(id);
        }
        String currDate = DateUtil.dateToString(new Date(), DateUtil.FORMAT_DAY);
        List<TaiWanParty> list = taiWanPartyService.getList();
        modelMap.addAttribute("list",list);
        modelMap.addAttribute("taiWanPolitics",taiWanPolitics);
        modelMap.addAttribute("currDate",currDate);
        return "foreignaffairs/taiwan/taiwan-politics-edit";
    }

    /**
     * 新增或编辑--保存数据
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-taiwan-politics-save.do",method = RequestMethod.POST)
    public Map<String,Object> saveOrUpdate(String partyId,TaiWanPolitics taiWanPolitics,String birthdayStr){
        Map<String, Object> map = taiWanPoliticsService.saveOrUpdate(partyId,taiWanPolitics,birthdayStr,getSysLogVo());
        return map;
    }

    /**
     * 删除某条台湾主要人士
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-taiwan-politics-delete.do",method = RequestMethod.POST)
    public Map<String,Object> delDateById(String id){
        HashMap map = new HashMap(3);
        try {
            TaiWanPolitics taiWanPolitics = taiWanPoliticsService.get(id);
            taiWanPolitics.setDelFlag("1");
            taiWanPolitics.setMainName("");
            taiWanPoliticsService.save(taiWanPolitics);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("台湾主要人士");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(taiWanPolitics.getMainName());
            sysLogVo.setEntityId(taiWanPolitics.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOGGER.debug(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }
}
