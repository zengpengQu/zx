package com.taiji.frame.controller.foreignaffairs.abroad;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.entity.foreignaffairs.gift.DicGiftType;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftApplication;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftsApplication;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.abroad.AbroadGiftAppVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadGiftAppService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.foreignaffairs.gift.DicGiftTypeService;
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

import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Calendar;

@Controller
@RequestMapping(value = "/abroad-gift-app")
public class AbroadGiftAppController extends BaseController<GiftApplication> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private AbroadGiftAppService abroadGiftAppService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private GiftsApplicationService giftsApplicationService;

    @Autowired
    private DicGiftTypeService dicGiftTypeService;

    @Autowired
    private DicParamService dicParamService;
    @Autowired
    private SysLogService sysLogService;


    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-gift-app-list.do", produces = "text/html;charset=UTF-8")
    public String appListLoad(Carrier<GiftApplication> carrier, AbroadGiftAppVo abroadGiftAppVo) {
        HashMap map = new HashMap(8);
        try {
            if (!StringUtils.isEmpty(abroadGiftAppVo.getAbroadInfoId())) {
                map.put("abroadInfoId", abroadGiftAppVo.getAbroadInfoId());
            }
            abroadGiftAppService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑弹窗
     */
    @RequestMapping(value = "/load-gift-app-edit.do", method = RequestMethod.GET)
    public String giftAppEdit(ModelMap modelMap, String id) {
        GiftApplication giftApplication = null;
        if (!StringUtils.isEmpty(id)) {
            giftApplication = abroadGiftAppService.get(id);

            List<GiftsApplication> giftsApplicationList = giftsApplicationService.getGiftsByApplicationId(id);
            modelMap.addAttribute("giftsApplicationList", giftsApplicationList);
        }
        modelMap.addAttribute("giftApplication", giftApplication);
        return "foreignaffairs/abroad/abroad-gift-app-edit";
    }

    /**
     * 新增/编辑保存
     */
    @ResponseBody
    @RequestMapping(value = "/gift-app-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveGiftApp(@RequestBody AbroadGiftAppVo abroadGiftAppVo) {
        Map<String, Object> map = new HashMap<>(2);

        GiftApplication giftApplication;
        String id = abroadGiftAppVo.getId();
        if (id != null) {
            giftApplication = abroadGiftAppService.get(id);
        } else {
            giftApplication = new GiftApplication();
            AbroadInfo abroadInfo = abroadInfoService.get(abroadGiftAppVo.getAbroadInfoId());
            giftApplication.setAbroadinfoId(abroadInfo.getId());
            giftApplication.setApplicationCode(getApplicationCode());
            giftApplication.setActivityName(abroadInfo.getGroupName());
            giftApplication.setActivityType("出访");
            giftApplication.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
            DicParam dicParam = dicParamService.get("2201");
            giftApplication.setDicParam(dicParam);
        }

        try {
            giftApplication.setApplicationPerson(getCurUser().getEmpName());
            giftApplication.setApplicationTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY));
            giftApplication.setApplicationCause(abroadGiftAppVo.getApplicationCause());
            giftApplication.setContactWay(StringUtils.isNotEmpty(getCurUser().getMobile()) ? getCurUser().getMobile() : getCurUser().getPhone());
            giftApplication.setUnitName(getCurUser().getDicDept().getDeptName());
            giftApplication.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
            giftApplication.setDelFlag("0");
            abroadGiftAppService.save(giftApplication);

            // 礼品清单
            List<GiftsApplication> giftsApplicationList = abroadGiftAppVo.getGiftsApplicationList();
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
            sysLogVo.setTypeName("礼品申请单表");
            if(org.apache.commons.lang.StringUtils.isEmpty(abroadGiftAppVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(giftApplication.getActivityName());
            sysLogVo.setEntityId(giftApplication.getId());
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
    @RequestMapping(value = "/gift-app-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteGiftApp(String id) {
        Map<String, Object> map = new HashMap<>(2);
        try {
            GiftApplication giftApplication = abroadGiftAppService.get(id);
            giftApplication.setDelFlag("1");
            giftApplication.setUpdateTime(new Date());
            abroadGiftAppService.save(giftApplication);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品申请单表");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(giftApplication.getActivityName());
            sysLogVo.setEntityId(giftApplication.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 查看
     */
    @RequestMapping(value = "/gift-app-view.do", method = RequestMethod.GET)
    public String viewGiftApp(ModelMap modelMap, String id) {
        if (StringUtils.isNotEmpty(id)) {
            GiftApplication giftApplication = abroadGiftAppService.get(id);
            modelMap.addAttribute("giftApp", giftApplication);
            List<GiftsApplication> giftsApplicationList = giftsApplicationService.getGiftsByApplicationId(id);
            modelMap.addAttribute("giftsApps", giftsApplicationList);
        }
        return "foreignaffairs/abroad/abroad-gift-app-view";
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
                sysLogVo.setTypeName("礼品申请单表一行");
                    sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(giftsApplication.getGiftApplication().getActivityName());
                sysLogVo.setEntityId(giftsApplication.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 生成礼品申请单编码
     * @return
     */
    private String getApplicationCode() {
        Date today = getCurDate();

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(today);

        int hour = calendar.get(Calendar.HOUR_OF_DAY);
        int minute = calendar.get(Calendar.MINUTE);

        DecimalFormat format = new DecimalFormat("00");
        return "CF" + DateUtil.dateToString(today, DateUtil.FORMAT_YYYYMMDD)
                + format.format(Double.valueOf(hour)) + String.valueOf(minute);
    }
}
