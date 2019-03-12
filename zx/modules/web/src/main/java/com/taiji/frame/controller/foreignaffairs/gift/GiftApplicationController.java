package com.taiji.frame.controller.foreignaffairs.gift;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.gift.DicGiftType;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftApplication;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftInfo;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftsApplication;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.gift.GiftOutOrInRecordsVO;
import com.taiji.frame.service.foreignaffairs.gift.DicGiftTypeService;
import com.taiji.frame.service.foreignaffairs.gift.GiftApplicationService;
import com.taiji.frame.service.foreignaffairs.gift.GiftStoreService;
import com.taiji.frame.service.foreignaffairs.gift.GiftsApplicationService;
import com.taiji.frame.service.systempara.DicParamService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * xialiang
 * 2018-08-06
 * 礼品申请单控制器
 */
@Controller
@RequestMapping(value = "/giftApplication")
public class GiftApplicationController extends BaseController<GiftApplication> {
public static final Logger logger = LoggerFactory.getLogger(GiftApplicationController.class);


    @Autowired
    private UtilService utilService;

    @Autowired
    private GiftApplicationService giftApplicationService;

    @Autowired
    private GiftsApplicationService giftsApplicationService;

    @Autowired
    private GiftStoreService giftStoreService;

    @Autowired
    private DicGiftTypeService dicGiftTypeService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private SysLogService sysLogService;

    @RequestMapping(value = "/gift-application-manage",method = RequestMethod.GET)
    public String list(Map<String,Object> map){
        //系统时间
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);

        //申请状态
//        List<DicParam> dicParamList = dicParamService.getParamByGroupId(22);
//        map.put("dicParamList", dicParamList);

        return "foreignaffairs/gift/gift-application-manage/gift-application-list";
    }

    /**
     * 礼品申请单列表
     * @param carrier
     * @param activityName
     * @param applicationPerson
     * @param startTime
     * @param endTime
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-application-list.do", produces = "text/html;charset=UTF-8")
    public String giftApplicationListLoad(Carrier<GiftApplication> carrier, String activityName, String applicationPerson, String startTime, String endTime) {

        HashMap map = new HashMap();

        try {
            if (!StringUtils.isEmpty(activityName)) {
                map.put("activityName", "%" + activityName + "%");
            }
            if (!StringUtils.isEmpty(applicationPerson)) {
                map.put("applicationPerson", "%" + applicationPerson + "%");
            }
            if (!StringUtils.isEmpty(startTime)) {
                map.put("startTime",  startTime);
            }
            if (!StringUtils.isEmpty(endTime)) {
                map.put("endTime", endTime);
            }
            giftApplicationService.load(carrier, map);
        } catch (Exception e) {
            logger.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑礼品申请页面跳转
     */
    @RequestMapping(value = "/load-application-edit.do", method = RequestMethod.GET)
    public String giftApplicationEdit(String id, ModelMap modelMap) {
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);

        //申请状态
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(22);
        modelMap.put("dicParamList", dicParamList);

        // 未接收
        DicParam notAccept = dicParamService.get("2201");
        modelMap.addAttribute("notAccept", notAccept);

        if (!StringUtils.isEmpty(id)) {
            //根据ID查找礼品架信息
            GiftApplication giftApplication = giftApplicationService.get(id);
            modelMap.addAttribute("giftApplication", giftApplication);

            String comeInfoId = giftApplication.getComeInfoId();
            String abroadinfoId = giftApplication.getAbroadinfoId();
            modelMap.addAttribute("comeInfoId", comeInfoId);
            modelMap.addAttribute("abroadinfoId", abroadinfoId);

            List<GiftsApplication> giftsApplicationList = giftsApplicationService.getGiftsByApplicationId(id);
            modelMap.addAttribute("giftsApplicationList", giftsApplicationList);


        }
        return "foreignaffairs/gift/gift-application-manage/gift-application-edit";
    }


    /**
     * 新增/编辑礼品清单页面跳转
     */
    @RequestMapping(value = "/load-gift-choice-edit.do", method = RequestMethod.GET)
    public String giftChoiceEdit(String id, ModelMap modelMap) {

        if(StringUtils.isNotEmpty(id)){
            GiftInfo giftInfo = this.giftStoreService.get(id);
            if(null != giftInfo){
                GiftOutOrInRecordsVO giftApplicationVO = new GiftOutOrInRecordsVO();
                giftApplicationVO.setGiftCode(giftInfo.getGiftCode());
                giftApplicationVO.setGiftName(giftInfo.getGiftName());
                giftApplicationVO.setGiftCount(giftInfo.getGiftCount());
                giftApplicationVO.setGiftType(giftInfo.getDicGiftType().getId());
                modelMap.addAttribute("giftApplicationVO", giftApplicationVO);

            }

        }
        return "foreignaffairs/gift/gift-application-manage/gift-choice-edit";
    }

    /**
     * 保存
     */
    @ResponseBody
    @RequestMapping(value = "/load-application-save.do", method = RequestMethod.POST)
    public Map<String, Object> giftApplicationSave(@RequestBody GiftApplication giftApplication) {

        Map<String, Object> map = new HashMap<>(16);
        String id = giftApplication.getId();
        try {
            DicParam  dicParam = this.dicParamService.get(giftApplication.dicParam.getId());
            giftApplication.setDicParam(dicParam);
            giftApplication.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
            giftApplication.setDelFlag("0");
            //设置更新时间,当前系统时间
            giftApplication.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
            giftApplicationService.save(giftApplication);

            // 礼品清单
            List<GiftsApplication> giftsApplicationList = giftApplication.getGiftsApplicationList();
            for (GiftsApplication ga : giftsApplicationList) {
                String giftsApplicationId = ga.getId();
                GiftsApplication giftsApplication;
                if (StringUtils.isNotEmpty(giftsApplicationId)) {
                    giftsApplication = giftsApplicationService.get(giftsApplicationId);
                } else {
                    giftsApplication = new GiftsApplication();
                    giftsApplication.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    giftsApplication.setGiftApplication(giftApplication);
                    giftsApplication.setDelFlag("0");
                }
                giftsApplication.setGiftInfoId(ga.getGiftInfoId());
                giftsApplication.setGiftName(ga.getGiftName());
                giftsApplication.setGiftCode(ga.getGiftCode());
                giftsApplication.setGiftCount(ga.getGiftCount());
                giftsApplication.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                giftsApplicationService.save(giftsApplication);
            }

            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品清单");
            if(org.apache.commons.lang.StringUtils.isEmpty(id)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            logger.info(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 删除礼品
     */
    @ResponseBody
    @RequestMapping(value = "/load-application-delete.do", method = RequestMethod.POST)
    public Map<String, Object> giftApplicationDelete(String id) {

        Map<String, Object> map = new HashMap<>(1);
        try {
            GiftApplication giftApplication = this.giftApplicationService.get(id);
            //删除标志设为1
            giftApplication.setDelFlag("1");
            giftApplication.setUpdateTime(new Date());
            //保存数据
            giftApplicationService.save(giftApplication);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品清单");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(giftApplication.getApplicationPerson());
            sysLogVo.setEntityId(giftApplication.getId());
            sysLogVo.setResult("true");
        } catch (Exception e) {
            logger.info(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


    /**
     * 礼品查看
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-application-view", method = RequestMethod.GET)
    public String view(ModelMap modelMap, String id) {
        if (!StringUtils.isEmpty(id)) {
            GiftApplication giftApplication = this.giftApplicationService.get(id);
            giftApplication.getJsonObject();
            modelMap.addAttribute("giftApplication", giftApplication);

            List<GiftsApplication> giftsApplicationList = giftsApplicationService.getGiftsByApplicationId(id);
            modelMap.addAttribute("giftsApplicationList", giftsApplicationList);
        }
        return "foreignaffairs/gift/gift-application-manage/gift-application-view";
    }

    @ResponseBody
    @RequestMapping(value = "/accept-application.do", method = RequestMethod.POST)
    public Map<String, Object> accept(String id) {
        Map<String, Object> map = new HashMap<>(1);
        if (StringUtils.isNotEmpty(id)) {
            GiftApplication giftApplication = giftApplicationService.get(id);

            DicParam accept = dicParamService.get("22");
            giftApplication.setDicParam(accept);

            try {
                giftApplicationService.save(giftApplication);
                map.put("result", true);
            } catch (Exception e) {
                map.put("result", false);
                logger.debug(e.getMessage(), e);
            }
        }

        return map;
    }

    /**
     * 删除礼品清单一行
     */
    @ResponseBody
    @RequestMapping(value = "/gifts-application-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteGiftsApp(String id) {
        Map<String, Object> map = new HashMap<>(1);

        try {
            if (StringUtils.isNotEmpty(id)) {
                GiftsApplication giftsApplication = giftsApplicationService.get(id);
                giftsApplication.setDelFlag("1");
                giftsApplicationService.save(giftsApplication);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("礼品清单一行");
                sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(giftsApplication.getGiftName());
                sysLogVo.setEntityId(giftsApplication.getId());
                sysLogVo.setResult("true");
            }
        } catch (Exception e) {
            logger.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }
}
