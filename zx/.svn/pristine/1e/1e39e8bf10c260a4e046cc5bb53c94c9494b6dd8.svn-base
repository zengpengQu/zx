package com.taiji.frame.controller.foreignaffairs.gift;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.gift.DicGiftType;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftShelves;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.service.foreignaffairs.gift.DicGiftTypeService;
import com.taiji.frame.service.foreignaffairs.gift.GiftShelvesService;
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

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author xialiang
 * @description：礼品架管理
 * @date：2018-7-26
 */
@Controller
@RequestMapping(value = "/gift")
public class GiftManageController extends BaseController<GiftShelves> {

    private static final Logger logger = LoggerFactory.getLogger(GiftManageController.class);

    @Autowired
    private UtilService utilService;

    @Autowired
    private GiftShelvesService giftShelvesService;

    @Autowired
    private DicGiftTypeService dicGiftTypeService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 页面跳转
     */
    @RequestMapping(value = "/gift-manage", method = RequestMethod.GET)
    public String list(Map<String, Object> map) {

        //系统时间
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        map.put("sysDate", sysDate);

        //礼品类型
        List<DicGiftType> dicGiftTypeList = dicGiftTypeService.getGiftTypeByDelFlag("0");
        map.put("dicGiftTypeList", dicGiftTypeList);

        //使用状态
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(7);
        map.put("dicParamList", dicParamList);

        return "foreignaffairs/gift/gift-manage";
    }

    /**
     *
     * @param carrier
     * @param frameType
     * @param frameCode
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-gift-shelves-list.do", produces = "text/html;charset=UTF-8")
    public String giftShelvesListLoad(Carrier<GiftShelves> carrier, String frameType, String frameCode) {

        HashMap map = new HashMap();

        try {
            if (!StringUtils.isEmpty(frameType)) {
                map.put("frameType", "%" + frameType + "%");
            }
            if (!StringUtils.isEmpty(frameCode)) {
                map.put("frameCode", "%" + frameCode + "%");
            }

            giftShelvesService.load(carrier, map);
        } catch (Exception e) {
            logger.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }


    /**
     * 新增/编辑礼品架页面跳转
     */
    @RequestMapping(value = "/load-gift-shelves-edit.do", method = RequestMethod.GET)
    public String giftShelvesEdit(String id, ModelMap modelMap) {
        //使用状态
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(7);
        modelMap.put("dicParamList", dicParamList);

        //货架类型
        List<DicGiftType> dicGiftTypeList = dicGiftTypeService.getDicGiftTypeByTypeNum("");
        modelMap.put("dicGiftTypeList", dicGiftTypeList);

        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        modelMap.addAttribute("sysDate", sysDate);

        if (!StringUtils.isEmpty(id)) {
            //根据ID查找礼品架信息
            GiftShelves giftShelves = giftShelvesService.get(id);
            modelMap.addAttribute("giftShelves", giftShelves);
        }
        return "foreignaffairs/gift/gift-shelves/gift-shelves-edit";
    }

    /**
     * 保存
     */
    @ResponseBody
    @RequestMapping(value = "/load-gift-shelves-save.do", method = RequestMethod.POST)
    public Map<String, Object> giftShelvesSave(@RequestBody GiftShelves giftShelves) {
        DicParam dicParam = null;
        DicGiftType dicGiftType = null;
        Map<String, Object> map = new HashMap<>(16);
        String id = giftShelves.getId();
        try {
            dicParam = this.dicParamService.get(giftShelves.dicParam.getId());
            dicGiftType = this.dicGiftTypeService.get(giftShelves.dicGiftType.getId());
            if(StringUtils.isNotEmpty(id)){//编辑
//               GiftShelves giftShelves = this.giftShelvesService.get(id);

            }else{//新增
                giftShelves.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
            }
            giftShelves.setDelFlag("0");
            giftShelves.setDicParam(dicParam);
            giftShelves.setDicGiftType(dicGiftType);
            //设置更新时间,当前系统时间
            giftShelves.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
            giftShelvesService.save(giftShelves);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品架");
            if(org.apache.commons.lang.StringUtils.isEmpty(id)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(giftShelves.getFrameName());
            sysLogVo.setEntityId(giftShelves.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            logger.info(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


    /**
     * 删除礼品货架
     */
    @ResponseBody
    @RequestMapping(value = "/load-gift-shelves-delete.do", method = RequestMethod.POST)
    public Map<String, Object> giftShelvesDelete(String id) {

        Map<String, Object> map = new HashMap<>(1);
        try {
            GiftShelves giftShelves = giftShelvesService.get(id);
            //删除标志设为1
            giftShelves.setDelFlag("1");
            giftShelves.setUpdateTime(new Date());
            //保存数据
            giftShelvesService.save(giftShelves);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品架");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(giftShelves.getFrameName());
            sysLogVo.setEntityId(giftShelves.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);

        } catch (Exception e) {
            logger.info(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }
}
