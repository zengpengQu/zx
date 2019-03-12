package com.taiji.frame.controller.foreignaffairs.gift;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.entity.foreignaffairs.gift.DicGiftType;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftOutOrIn;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.foreignaffairs.come.ComeInfoService;
import com.taiji.frame.service.foreignaffairs.gift.DicGiftTypeService;
import com.taiji.frame.service.foreignaffairs.gift.GiftOutboundService;
import com.taiji.frame.service.foreignaffairs.gift.SynchronousGiftStoreService;
import com.taiji.frame.service.systempara.DicParamService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSONObject;
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
 * @description：礼品库入库单管理
 * @date：2018-8-2
 *
 */
@Controller
@RequestMapping(value = "/giftPurchase")
public class GiftPurchaseManageController extends BaseController<GiftOutOrIn> {
    private static final Logger logger = LoggerFactory.getLogger(GiftOutboundManageController.class);

    @Autowired
    private UtilService utilService;

    @Autowired
    private GiftOutboundService giftPurchaseService;

    @Autowired
    private DicGiftTypeService dicGiftTypeService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private SynchronousGiftStoreService synchronousGiftStoreService;

    @Autowired
    private ComeInfoService comeInfoService;

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private SysLogService sysLogService;
    /**
     * 页面跳转
     */
    @RequestMapping(value = "/gift-purchase-manage" ,method = RequestMethod.GET)
    public String list(Map<String, Object> map){
        //系统时间
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        map.put("sysDate", sysDate);

        //礼品类型
        List<DicGiftType> dicGiftTypeList = dicGiftTypeService.getGiftTypeByDelFlag("0");
        map.put("dicGiftTypeList", dicGiftTypeList);

        //库存状态
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(18);
        map.put("dicParamList", dicParamList);

        return "foreignaffairs/gift/gift-purchase-manage/gift-purchase-manage-list";
    }



    @ResponseBody
    @RequestMapping(value = "/load-purchase-list.do", produces = "text/html;charset=UTF-8")
    public String giftPurchaseListLoad(Carrier<GiftOutOrIn> carrier,String activityName, String applicationPerson, String startTime, String endTime) {

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

            map.put("outOrInFlag", "0");

            giftPurchaseService.load(carrier, map);
        } catch (Exception e) {
            logger.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }


    /**
     * 新增/编辑礼品库存页面跳转
     */
    @RequestMapping(value = "/load-purchase-edit.do", method = RequestMethod.GET)
    public String giftPurchaseEdit(String id, ModelMap modelMap) {

        GiftOutOrIn giftOutOrIn = null;
        //使用状态
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(20);
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
            giftOutOrIn = giftPurchaseService.get(id);
        }
        modelMap.addAttribute("giftOutOrIn", giftOutOrIn);
        return "foreignaffairs/gift/gift-purchase-manage/gift-purchase-edit";
    }

    /**
     * 保存
     */
    @ResponseBody
    @RequestMapping(value = "/load-purchase-save.do", method = RequestMethod.POST)
    public Map<String, Object> giftPurchaseSave(@RequestBody GiftOutOrIn giftOutOrIn) {
        DicParam dicParam = null;
        Map<String, Object> map = new HashMap<>(16);
        String id = giftOutOrIn.getId();
        try {
            dicParam = this.dicParamService.get(giftOutOrIn.dicParam.getId());
            if(StringUtils.isNotEmpty(id)){//编辑

            }else{//新增
                giftOutOrIn.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
            }
            giftOutOrIn.setOutOrInFlag("0");
            giftOutOrIn.setDelFlag("0");
            giftOutOrIn.setDicParam(dicParam);
            //设置更新时间,当前系统时间
            giftOutOrIn.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
            giftPurchaseService.save(giftOutOrIn);

            /**
             * 当入库单入库状态为已入库，且不可删除、不可修改，点击保存时，
             * 将入库单的礼品清单信息同步（新增、更新）到礼品库存管理中。
             * 已入库：2001，未入库:20
             */
            if(null != giftOutOrIn && "2001".equals(giftOutOrIn.getDicParam().getId())){
                synchronousGiftStoreService.giftPurchaseToStore(giftOutOrIn.getId());
            }
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品管理");
            if(org.apache.commons.lang.StringUtils.isEmpty(id)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(giftOutOrIn.getApplicationPerson());
            sysLogVo.setEntityId(giftOutOrIn.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            map.put("result", true);
            map.put("giftOutOrInId", giftOutOrIn.getId());
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
    @RequestMapping(value = "/load-purchase-delete.do", method = RequestMethod.POST)
    public Map<String, Object> giftPurchaseDelete(String id) {

        Map<String, Object> map = new HashMap<>(1);
        try {
            GiftOutOrIn giftOutOrIn = this.giftPurchaseService.get(id);
            //删除标志设为1
            giftOutOrIn.setDelFlag("1");
            giftOutOrIn.setUpdateTime(new Date());
            //保存数据
            giftPurchaseService.save(giftOutOrIn);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品管理");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(giftOutOrIn.getApplicationPerson());
            sysLogVo.setEntityId(giftOutOrIn.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            map.put("result", true);
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
    @RequestMapping(value = "/load-purchase-view", method = RequestMethod.GET)
    public String view(ModelMap modelMap, String id) {
        if (!StringUtils.isEmpty(id)) {
            GiftOutOrIn giftOutOrIn = this.giftPurchaseService.get(id);
            giftOutOrIn.getJsonObject();
            modelMap.addAttribute("giftOutOrIn", giftOutOrIn);

        }
        return "foreignaffairs/gift/gift-purchase-manage/gift-purchase-view";
    }
}
