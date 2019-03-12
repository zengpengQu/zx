package com.taiji.frame.controller.foreignaffairs.gift;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.gift.*;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.gift.GiftOutOrInRecordsVO;
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

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author xialiang
 * @description：礼品出入库礼品明细记录管理控制器
 * @date：2018-8-13
 *
 */
@Controller
@RequestMapping(value = "/giftOutOrInRecords")
public class GiftOutOrInRecordsController extends BaseController<GiftOutOrInRecords> {
    private static final Logger logger = LoggerFactory.getLogger(GiftOutOrInRecordsController.class);

    @Autowired
    private UtilService utilService;

    @Autowired
    private GiftOutOrInRecordsService giftOutOrInRecordsService;

    @Autowired
    private GiftOutOrInService giftOutOrInService;

    @Autowired
    private GiftShelvesService giftShelvesService;

    @Autowired
    private DicGiftTypeService dicGiftTypeService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private GiftStoreService giftStoreService;

    @Autowired
    private SysLogService sysLogService;

    @ResponseBody
    @RequestMapping(value = "/load-giftOutOrInRecords-list.do", produces = "text/html;charset=UTF-8")
    public String giftOutOrInRecordsLoad(Carrier<GiftOutOrInRecords> carrier, String giftOutOrInId) {
        HashMap map = new HashMap();
        try {
//            if (!StringUtils.isEmpty(giftOutOrInId)) {
                map.put("giftOutOrInId", giftOutOrInId);
//            }

            giftOutOrInRecordsService.load(carrier, map);
        } catch (Exception e) {
            logger.debug(e.getMessage(), e);
        }

        return gridResult(carrier);
    }


    /**
     * 新增/编辑礼品记录页面跳转
     */
    @RequestMapping(value = "/load-giftOutOrInRecords-edit.do", method = RequestMethod.GET)
    public String giftOutOrInRecordsEdit(String id, ModelMap modelMap) {
        //使用状态
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(18);
        modelMap.put("dicParamList", dicParamList);

        //礼品类型
        List<DicGiftType> dicGiftTypeList = dicGiftTypeService.getDicGiftTypeByTypeNum("");
        modelMap.put("dicGiftTypeList", dicGiftTypeList);

        //礼品架
        List<GiftShelves> giftShelvesList = giftShelvesService.getGiftShelvesByCode("");
        modelMap.addAttribute("giftShelvesList", giftShelvesList);

        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        modelMap.addAttribute("sysDate", sysDate);

        if (!StringUtils.isEmpty(id)) {
            GiftOutOrInRecords giftOutOrInRecords = giftOutOrInRecordsService.get(id);

            GiftInfo giftInfo = giftStoreService.get(id);
            if(null != giftInfo){
                if( null == giftOutOrInRecords){
                    try {
                        giftOutOrInRecords =  GiftOutOrInRecords.class.newInstance();
                    } catch (InstantiationException e) {
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    }
                }
                String giftCode      = giftInfo.getGiftCode();
                String giftName      = giftInfo.getGiftName();
                String giftType      = giftInfo.getDicGiftType().getId();
                Integer giftCount    = giftInfo.getGiftCount();
                BigDecimal giftPrice = giftInfo.getGiftPrice();
                String giftShelves = giftInfo.getGiftShelves().getId();

                giftOutOrInRecords.setGiftCode(giftCode);
                giftOutOrInRecords.setGiftName(giftName);
                giftOutOrInRecords.setDicGiftType(dicGiftTypeService.get(giftType));
                giftOutOrInRecords.setGiftCount(giftCount);
                giftOutOrInRecords.setGiftPrice(giftPrice);
                giftOutOrInRecords.setGiftShelves(giftShelvesService.get(giftShelves));
            }


            modelMap.addAttribute("giftOutOrInRecords", giftOutOrInRecords);
        }
        return "foreignaffairs/gift/gift-purchase-manage/gift-outorin-edit";
    }

    /**
     * 保存
     */
    @ResponseBody
    @RequestMapping(value = "/load-giftOutOrInRecords-save.do", method = RequestMethod.POST)
    public Map<String, Object> giftOutOrInRecordsSave(@RequestBody GiftOutOrInRecordsVO giftOutOrInRecordsVO) {
        DicGiftType dicGiftType = null;
        Map<String, Object> map = new HashMap<>(16);
        if(null != giftOutOrInRecordsVO){
            GiftOutOrInRecords giftOutOrInRecords = new GiftOutOrInRecords();
                String id = giftOutOrInRecordsVO.getId();
                try {
                    dicGiftType = this.dicGiftTypeService.get(giftOutOrInRecordsVO.getGiftType());
                    if(StringUtils.isNotEmpty(id)){//编辑
                        giftOutOrInRecords.setId(id);
                    }else{//新增
                        giftOutOrInRecords.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    }
                    giftOutOrInRecords.setGiftCode(giftOutOrInRecordsVO.giftCode);
                    giftOutOrInRecords.setGiftName(giftOutOrInRecordsVO.giftName);
                    giftOutOrInRecords.setGiftCount(Integer.valueOf(giftOutOrInRecordsVO.getGiftCount()));
                    giftOutOrInRecords.setGiftPrice(giftOutOrInRecordsVO.getGiftPrice());
                    GiftShelves giftShelves = this.giftShelvesService.get(giftOutOrInRecordsVO.getGiftFrame());
                    giftOutOrInRecords.setGiftShelves(giftShelves);
                    String giftOutOrInId = giftOutOrInRecordsVO.getGiftOutOrInId();
                    GiftOutOrIn giftOutOrIn = this.giftOutOrInService.get(giftOutOrInId);
                    giftOutOrInRecords.setGiftOutOrIn(giftOutOrIn);

                    giftOutOrInRecords.setDelFlag("0");
                    giftOutOrInRecords.setDicGiftType(dicGiftType);
                    giftOutOrInRecords.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    giftOutOrInRecordsService.save(giftOutOrInRecords);
                    map.put("result", true);

                    SysLogVo sysLogVo = getSysLogVo();
                    sysLogVo.setTypeName("礼品明细记录");
                    if(org.apache.commons.lang.StringUtils.isEmpty(id)){
                        sysLogVo.setRecordType(0);
                    }else {
                        sysLogVo.setRecordType(1);
                    }
                    sysLogVo.setEntityName(dicGiftType.getTypeName());
                    sysLogVo.setEntityId(dicGiftType.getId());
                    sysLogVo.setResult("true");
                    sysLogService.record(sysLogVo);
                } catch (BeansException e) {
                    logger.info(e.getMessage(), e);
                    map.put("result", false);
                }
        }
        return map;
    }

    /**
     * 删除礼品
     */
    @ResponseBody
    @RequestMapping(value = "/load-giftOutOrInRecords-delete.do", method = RequestMethod.POST)
    public Map<String, Object> giftOutOrInRecordsDelete(String id) {

        Map<String, Object> map = new HashMap<>(1);
        try {
            GiftOutOrInRecords giftOutOrInRecords = this.giftOutOrInRecordsService.get(id);
            //删除标志设为1
            giftOutOrInRecords.setDelFlag("1");
            giftOutOrInRecords.setUpdateTime(new Date());
            //保存数据
            giftOutOrInRecordsService.save(giftOutOrInRecords);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(giftOutOrInRecords.getGiftName());
            sysLogVo.setEntityId(giftOutOrInRecords.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            logger.info(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

}
