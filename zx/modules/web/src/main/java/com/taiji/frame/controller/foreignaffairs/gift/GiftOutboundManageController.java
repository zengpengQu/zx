package com.taiji.frame.controller.foreignaffairs.gift;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.BeanCopyUtil;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.entity.foreignaffairs.gift.*;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.gift.GiftOutOrInVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.foreignaffairs.come.ComeInfoService;
import com.taiji.frame.service.foreignaffairs.gift.*;
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
 * @author xialiang
 * @description：礼品库出库单管理
 * @date：2018-7-31
 */
@Controller
@RequestMapping(value = "/giftOutbound")
public class GiftOutboundManageController extends BaseController<GiftOutOrIn> {
    private static final Logger logger = LoggerFactory.getLogger(GiftOutboundManageController.class);


    @Autowired
    private UtilService utilService;

    @Autowired
    private GiftOutboundService giftOutboundService;

    @Autowired
    private DicGiftTypeService dicGiftTypeService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private SynchronousGiftStoreService synchronousGiftStoreService;

    @Autowired
    private GiftApplicationService giftApplicationService;

    @Autowired
    private GiftsApplicationService giftsApplicationService;

    @Autowired
    private GiftOutOrInRecordsService giftOutOrInRecordsService;

    @Autowired
    private GiftInfoService giftInfoService;

    @Autowired
    private GiftOutOrInService giftOutOrInService;

    @Autowired
    private ComeInfoService comeInfoService;

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private SysLogService sysLogService;
    /**
     * 页面跳转
     */
    @RequestMapping(value = "/gift-outbound-manage", method = RequestMethod.GET)
    public String list(Map<String, Object> map) {
        //系统时间
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        map.put("sysDate", sysDate);

        //礼品类型
        List<DicGiftType> dicGiftTypeList = dicGiftTypeService.getGiftTypeByDelFlag("0");
        map.put("dicGiftTypeList", dicGiftTypeList);

        //库存状态
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(18);
        map.put("dicParamList", dicParamList);

        return "foreignaffairs/gift/gift-outbound-manage/gift-outbound-manage-list";
    }


    @ResponseBody
    @RequestMapping(value = "/load-outbound-list.do", produces = "text/html;charset=UTF-8")
    public String giftOutboundListLoad(Carrier<GiftOutOrIn> carrier, String activityName, String applicationPerson, String startTime, String endTime) {

        HashMap map = new HashMap();

        try {
            if (!StringUtils.isEmpty(activityName)) {
                map.put("activityName", "%" + activityName + "%");
            }
            if (!StringUtils.isEmpty(applicationPerson)) {
                map.put("applicationPerson", "%" + applicationPerson + "%");
            }
            if (!StringUtils.isEmpty(startTime)) {
                map.put("startTime", startTime);
            }
            if (!StringUtils.isEmpty(endTime)) {
                map.put("endTime", endTime);
            }
            map.put("outOrInFlag", "1");
            giftOutboundService.load(carrier, map);
        } catch (Exception e) {
            logger.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }


    /**
     * 新增/编辑礼品库存页面跳转
     */
    @RequestMapping(value = "/load-outbound-edit.do", method = RequestMethod.GET)
    public String giftOutboundEdit(String id, ModelMap modelMap) {
        //使用状态
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(21);
        modelMap.put("dicParamList", dicParamList);

        List<ComeInfo> comeInfoList = comeInfoService.findWithGiftApp();
        List<AbroadInfo> abroadInfoList = abroadInfoService.findWithGiftApp();

        List<String> activityList = new ArrayList<>();

        for (ComeInfo comeInfo : comeInfoList) {
            activityList.add(comeInfo.getGroupName());
        }

        for(AbroadInfo abroadInfo : abroadInfoList) {
            activityList.add(abroadInfo.getGroupName());
        }

        activityList.add("其他");
        modelMap.addAttribute("activityList", activityList);

        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        modelMap.addAttribute("sysDate", sysDate);

        if (!StringUtils.isEmpty(id)) {
            //根据ID查找礼品架信息
            GiftOutOrIn giftOutOrIn = giftOutboundService.get(id);
            giftOutOrIn.setDelFlag("0");
            giftOutboundService.save(giftOutOrIn);
            modelMap.addAttribute("giftOutOrIn", giftOutOrIn);
        }
        return "foreignaffairs/gift/gift-outbound-manage/gift-outbound-edit";
    }

    /**
     * 保存
     */
    @ResponseBody
    @RequestMapping(value = "/load-outbound-save.do", method = RequestMethod.POST)
    public Map<String, Object> giftOutboundSave(@RequestBody GiftOutOrInVo giftOutOrInVo) {
        DicParam dicParam;
        Map<String, Object> map = new HashMap<>(16);
        String id = giftOutOrInVo.getId();
        GiftOutOrIn giftOutOrIn;
        try {
            dicParam = dicParamService.get(giftOutOrInVo.dicParam.getId());
            //编辑
            if (StringUtils.isNotEmpty(id)) {
                giftOutOrIn = giftOutOrInService.get(id);
            } else {
                //新增
                giftOutOrIn = new GiftOutOrIn();
                giftOutOrIn.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
            }
            new BeanCopyUtil().copyNotNullProperties(giftOutOrInVo, giftOutOrIn, true);

            giftOutOrIn.setOutOrInFlag("1");
            giftOutOrIn.setDelFlag("0");
            giftOutOrIn.setDicParam(dicParam);
            //设置更新时间,当前系统时间
            giftOutOrIn.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));

            if ("21".equals(giftOutOrIn.getDicParam().getId())) {
                giftOutboundService.save(giftOutOrIn);
                map.put("giftOutOrInId", giftOutOrIn.getId());
                map.put("result", true);
            }

            /**
             * 当出库单出库状态为已出库，且不可删除、不可修改，点击保存时，
             * 将出库单的礼品清单信息同步（新增、更新）到礼品库存管理中。
             * 已出库：2101，未出库:21
             */
            if ("2101".equals(giftOutOrIn.getDicParam().getId())) {
                if (null == giftOutOrIn.getId()) {
                    dicParam = dicParamService.get("21");
                    giftOutOrIn.setDicParam(dicParam);
                    giftOutboundService.save(giftOutOrIn);
                    map.put("result", "empty");
                    map.put("giftOutOrInId", giftOutOrIn.getId());
                } else {
                    Map mapMsg = synchronousGiftStoreService.giftOutboundToStore(giftOutOrIn.getId());
                    Boolean synchronousFlag = (Boolean) mapMsg.get("synchronousFlag");
                    String buffer = (String) mapMsg.get("buffer");
                    if (synchronousFlag) {
                        List<GiftOutOrInRecords> giftOutOrInRecords = giftOutOrInRecordsService.searchGiftOutOrInRecords(id);
                        synchronousGiftStoreService.outboundGiftSave(giftOutOrInRecords);
                        giftOutboundService.save(giftOutOrIn);

                        // 设置礼品申请出库状态
                        GiftApplication giftApplication = giftApplicationService.findByOutboundId(id);
                        if (giftApplication != null) {
                            giftApplication.setIsOutbound(giftOutOrIn.getDicParam().getName());
                            giftApplicationService.save(giftApplication);
                        }

                        map.put("result", true);
                    } else {
                        dicParam = dicParamService.get("21");
                        giftOutOrIn.setDicParam(dicParam);
                        giftOutboundService.save(giftOutOrIn);
                        if (buffer.contains("empty")) {
                            map.put("result", "empty");
                        } else {
                            map.put("result", false);
                        }
                    }
                    map.put("msg", buffer);
                }
            }
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品库存");
            if(org.apache.commons.lang.StringUtils.isEmpty(id)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            logger.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


    @ResponseBody
    @RequestMapping(value = "/add-outbound-from-app.do", method = RequestMethod.POST)
    public Map<String, Object> addOutbound(String appId) {
        Map<String, Object> map = new HashMap<>(2);

        if (StringUtils.isNotEmpty(appId)) {
            GiftOutOrIn giftOutOrIn = new GiftOutOrIn();
            giftOutOrIn.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
            // 类型为出库
            giftOutOrIn.setOutOrInFlag("1");
            //设置状态为 未出库
            DicParam dicParam = dicParamService.get("21");
            giftOutOrIn.setDicParam(dicParam);

            GiftApplication giftApplication = giftApplicationService.get(appId);

            giftOutOrIn.setActivityName(giftApplication.getActivityName());
            giftOutOrIn.setActivityType(giftApplication.getActivityType());
            giftOutOrIn.setApplicationTime(giftApplication.getApplicationTime());
            giftOutOrIn.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
            giftOutOrIn.setApplicationPerson(giftApplication.getApplicationPerson());

            giftOutOrIn.setDelFlag("0");

            try {
                giftOutboundService.save(giftOutOrIn);

                // 在礼品申请中设置出库单 id， 出库状态
                giftApplication.setOutboundId(giftOutOrIn.getId());
                giftApplication.setIsOutbound(giftOutOrIn.getDicParam().getName());
                giftApplicationService.save(giftApplication);

                List<GiftsApplication> giftsApplicationList = giftsApplicationService.getGiftsByApplicationId(appId);
                // 礼品清单
                for (GiftsApplication giftsApplication : giftsApplicationList) {
                    String giftInfoId = giftsApplication.getGiftInfoId();
                    GiftInfo giftInfo = giftInfoService.get(giftInfoId);
                    GiftOutOrInRecords giftOutOrInRecords = new GiftOutOrInRecords();
                    giftOutOrInRecords.setGiftOutOrIn(giftOutOrIn);

                    giftOutOrInRecords.setGiftName(giftInfo.getGiftName());
                    giftOutOrInRecords.setGiftPrice(giftInfo.getGiftPrice());
                    giftOutOrInRecords.setGiftCode(giftInfo.getGiftCode());
                    giftOutOrInRecords.setDicGiftType(giftInfo.getDicGiftType());
                    giftOutOrInRecords.setGiftShelves(giftInfo.getGiftShelves());
                    giftOutOrInRecords.setGiftInstruction(giftInfo.getGiftInstruction());
                    giftOutOrInRecords.setDicParam(giftInfo.getDicParam());

                    giftOutOrInRecords.setGiftCount(giftsApplication.getGiftCount());
                    giftOutOrInRecords.setDelFlag("0");
                    giftOutOrInRecordsService.save(giftOutOrInRecords);
                }

                map.put("result", true);
                map.put("outboundId", giftOutOrIn.getId());
            } catch (Exception e) {
                logger.debug(e.getMessage(), e);
                map.put("result", false);
            }
        }

        return map;
    }


    /**
     * 删除礼品
     */
    @ResponseBody
    @RequestMapping(value = "/load-outbound-delete.do", method = RequestMethod.POST)
    public Map<String, Object> giftOutboundDelete(String id) {

        Map<String, Object> map = new HashMap<>(1);
        try {
            GiftOutOrIn giftOutOrIn = this.giftOutboundService.get(id);
            //删除标志设为1
            giftOutOrIn.setDelFlag("1");
            giftOutOrIn.setUpdateTime(new Date());
            //保存数据
            giftOutboundService.save(giftOutOrIn);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品库");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(giftOutOrIn.getApplicationPerson());
            sysLogVo.setEntityId(giftOutOrIn.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            logger.info(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


    /**
     * 礼品查看
     *
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-outbound-view", method = RequestMethod.GET)
    public String view(ModelMap modelMap, String id) {
        if (!StringUtils.isEmpty(id)) {
            GiftOutOrIn giftOutOrIn = this.giftOutboundService.get(id);
            giftOutOrIn.getJsonObject();
            modelMap.addAttribute("giftOutOrIn", giftOutOrIn);

        }
        return "foreignaffairs/gift/gift-outbound-manage/gift-outbound-view";
    }
}