package com.taiji.frame.controller.foreignaffairs.come;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.BeanCopyUtil;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.entity.foreignaffairs.gift.DicGiftType;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftApplication;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftsApplication;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeGiftVo;
import com.taiji.frame.service.foreignaffairs.come.ComeGiftRecvService;
import com.taiji.frame.service.foreignaffairs.come.ComeInfoService;
import com.taiji.frame.service.foreignaffairs.gift.DicGiftTypeService;
import com.taiji.frame.service.foreignaffairs.gift.GiftApplicationService;
import com.taiji.frame.service.foreignaffairs.gift.GiftsApplicationService;
import com.taiji.frame.service.systempara.DicParamService;
import com.taiji.frame.service.systempara.SysLogService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.InvocationTargetException;
import java.text.DecimalFormat;
import java.util.*;


@Controller
@RequestMapping(value = "/come/come-gift")
public class ComeGiftController extends BaseController<GiftApplication> {
    private static final Logger LOG = LoggerFactory.getLogger(ComeGiftController.class);

    @Autowired
    ComeInfoService comeInfoService;

    @Autowired
    GiftApplicationService giftApplicationService;

    @Autowired
    GiftsApplicationService giftsApplicationService;

    @Autowired
    DicParamService dicParamService;

    @Autowired
    DicGiftTypeService dicGiftTypeService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 加载来访礼品页面
     *
     * @param modelMap
     * @param comeInfoId
     * @return
     */
    @RequestMapping(value = "/load-come-gift", method = RequestMethod.GET)
    public String loadGift(ModelMap modelMap, String comeInfoId) {

        modelMap.addAttribute("comeInfoId", comeInfoId);
        return "foreignaffairs/come/come-gift-list";
    }


    /**
     * load grid 礼品申请单列表
     *
     * @param carrier
     * @param comeInfoId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-application-list.do", produces = "text/html;charset=UTF-8")
    public String giftApplicationListLoad(Carrier<GiftApplication> carrier, String comeInfoId) {

        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(comeInfoId)) {
            map.put("comeInfoId", comeInfoId);

            try {
                giftApplicationService.load(carrier, map);
            } catch (Exception e) {
                LOG.debug(e.getMessage(), e);
            }
        }
        return gridResult(carrier);
    }

    /**
     * 页面跳转至来访礼品申请 Tab
     */
    @RequestMapping(value = "/gift-application-list", method = RequestMethod.GET)
    public String list(String comeInfoId, ModelMap modelMap) {
        modelMap.addAttribute("comeInfoId", comeInfoId);

        return "foreignaffairs/come/gift-application-list";
    }

    /**
     * 新增来访礼品申请
     */
    @RequestMapping(value = "/gift-application-edit", method = RequestMethod.GET)
    public String edit(String id, ModelMap modelMap) {
        if (StringUtils.isNotEmpty(id)) {
            //根据ID查找礼品架信息
            GiftApplication giftApplication = giftApplicationService.get(id);
            modelMap.addAttribute("giftApplication", giftApplication);

            List<GiftsApplication> giftsApplicationList = giftsApplicationService.getGiftsByApplicationId(id);
            modelMap.addAttribute("giftsApplicationList", giftsApplicationList);
        }
        return "foreignaffairs/come/gift-application-edit";
    }

    /**
     * 查看礼品申请
     */
    @RequestMapping(value = "/gift-application-view", method = RequestMethod.GET)
    public String view(String id, ModelMap modelMap) {
        if (StringUtils.isNotEmpty(id)) {
            //根据ID查找礼品架信息
            GiftApplication giftApplication = giftApplicationService.get(id);
            modelMap.addAttribute("giftApplication", giftApplication);

            List<GiftsApplication> giftsApplicationList = giftsApplicationService.getGiftsByApplicationId(id);
            modelMap.addAttribute("giftsApplicationList", giftsApplicationList);
        }
        return "foreignaffairs/come/gift-application-view";
    }

    /**
     * 保存礼品申请
     */
    @ResponseBody
    @RequestMapping(value = "/application-save.do", method = RequestMethod.POST)
    public Map<String, Object> giftApplicationSave(@RequestBody ComeGiftVo comeGiftVo) {
        Map<String, Object> map = new HashMap<>(1);
        GiftApplication giftApplication;
        String id = comeGiftVo.getId();
        if (id != null) {
            giftApplication = giftApplicationService.get(id);
        } else {
            giftApplication = new GiftApplication();
            giftApplication.setCreateTime(getCurDate());
            giftApplication.setActivityType("来访");
            ComeInfo comeInfo = comeInfoService.get(comeGiftVo.getComeInfoId());
            giftApplication.setActivityName(comeInfo.getGroupName());
            giftApplication.setApplicationCode(getApplicationCode());
            DicParam dicParam = dicParamService.get("2201");
            giftApplication.setDicParam(dicParam);
        }

        try {
            new BeanCopyUtil().copyNotNullProperties(comeGiftVo, giftApplication, true);

            giftApplication.setApplicationTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT_DAY));
            giftApplication.setApplicationPerson(getCurUser().getEmpName());
            giftApplication.setContactWay(StringUtils.isNotEmpty(getCurUser().getMobile()) ? getCurUser().getMobile() : getCurUser().getPhone());
            giftApplication.setUnitName(getCurUser().getDicDept().getDeptName());

            //设置更新时间,当前系统时间
            giftApplication.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
            giftApplication.setDelFlag("0");
            giftApplicationService.save(giftApplication);


            // 礼品清单
            List<GiftsApplication> giftsApplicationList = comeGiftVo.getGiftsApplicationList();
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
            sysLogVo.setTypeName("保存礼品申请");
                sysLogVo.setRecordType(0);
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
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
                sysLogVo.setTypeName("删除礼品清单");
                sysLogVo.setRecordType(0);
                sysLogVo.setEntityName(giftsApplication.getGiftName());
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
        return "LF" + DateUtil.dateToString(today, DateUtil.FORMAT_YYYYMMDD)
                + format.format(Double.valueOf(hour)) + String.valueOf(minute);
    }

}
