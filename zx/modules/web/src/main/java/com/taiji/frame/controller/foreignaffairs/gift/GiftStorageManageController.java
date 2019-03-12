package com.taiji.frame.controller.foreignaffairs.gift;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.gift.DicGiftType;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftInfo;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftShelves;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.service.foreignaffairs.gift.DicGiftTypeService;
import com.taiji.frame.service.foreignaffairs.gift.GiftShelvesService;
import com.taiji.frame.service.foreignaffairs.gift.GiftStoreService;
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
 * @description：礼品库存管理
 * @date：2018-7-30
 *
 */
@Controller
@RequestMapping(value = "/giftStore")
public class GiftStorageManageController extends BaseController<GiftInfo> {
    private static final Logger logger = LoggerFactory.getLogger(GiftStorageManageController.class);

    @Autowired
    private UtilService utilService;

    @Autowired
    private GiftStoreService giftStoreService;

    @Autowired
    private DicGiftTypeService dicGiftTypeService;

    @Autowired
    private GiftShelvesService giftShelvesService;

    @Autowired
    private DicParamService dicParamService;
    @Autowired
    private SysLogService sysLogService;
    /**
     * 页面跳转
     */
    @RequestMapping(value = "/gift-storage-manage" ,method = RequestMethod.GET)
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

        return "foreignaffairs/gift/gift-storage-manage/gift-storage-manage-list";
    }



    @ResponseBody
    @RequestMapping(value = "/load-giftStoreInfo-list.do", produces = "text/html;charset=UTF-8")
    public String giftShelvesListLoad(Carrier<GiftInfo> carrier,String giftName, String giftCode, String giftType, String gift) {

        HashMap map = new HashMap();

        try {
            if (!StringUtils.isEmpty(giftName)) {
                map.put("giftName", "%" + giftName + "%");
            }
            if (!StringUtils.isEmpty(giftCode)) {
                map.put("giftCode", "%" + giftCode + "%");
            }
            if (!StringUtils.isEmpty(giftType)) {
                map.put("giftType", giftType);
            }

            giftStoreService.load(carrier, map);
        } catch (Exception e) {
            logger.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }


    /**
     * 新增/编辑礼品库存页面跳转
     */
    @RequestMapping(value = "/load-giftStoreInfo-edit.do", method = RequestMethod.GET)
    public String giftStoreInfoEdit(String id, ModelMap modelMap) {
        //使用状态
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(18);
        modelMap.put("dicParamList", dicParamList);

        //货架类型
        List<DicGiftType> dicGiftTypeList = dicGiftTypeService.getDicGiftTypeByTypeNum("");
        modelMap.put("dicGiftTypeList", dicGiftTypeList);

        //礼品架
        List<GiftShelves> giftShelvesList = giftShelvesService.getGiftShelvesByCode("");
        modelMap.addAttribute("giftShelvesList", giftShelvesList);

        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        modelMap.addAttribute("sysDate", sysDate);

        if (!StringUtils.isEmpty(id)) {
            //根据ID查找礼品架信息
            GiftInfo giftInfo = giftStoreService.get(id);
            modelMap.addAttribute("giftInfo", giftInfo);
        }
        return "foreignaffairs/gift/gift-storage-manage/gift-storage-edit";
    }

    /**
     * 检查礼品编码是否重复
     * @param giftCode 礼品编码
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/check-giftCode.do", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String checkGiftCode(String id, String giftCode) {
        String flag;

        List<GiftInfo> list = giftStoreService.findByGiftCode(giftCode);
        if (null != list && list.size() != 0) {
            flag = "false";
        } else {
            flag = "true";
        }

        if (StringUtils.isNotEmpty(id)) {
            GiftInfo giftInfo = giftStoreService.get(id);

            String originalCode = giftInfo.getGiftCode();
            if (giftCode.equals(originalCode)) {
                flag = "true";
            }
        }
        return flag;
    }


    /**
     * 保存
     */
    @ResponseBody
    @RequestMapping(value = "/load-giftStoreInfo-save.do", method = RequestMethod.POST)
    public Map<String, Object> giftStoreInfoSave(@RequestBody GiftInfo giftInfo) {
        DicParam dicParam = null;
        DicGiftType dicGiftType = null;
        GiftShelves giftShelves;
        Map<String, Object> map = new HashMap<>(16);
        String id = giftInfo.getId();
        try {
            dicParam = this.dicParamService.get(giftInfo.dicParam.getId());
            dicGiftType = this.dicGiftTypeService.get(giftInfo.dicGiftType.getId());
            giftShelves = giftShelvesService.get(giftInfo.getGiftShelves().getId());
            if(StringUtils.isNotEmpty(id)){//编辑
//               GiftShelves giftShelves = this.giftShelvesService.get(id);

            }else{//新增
                giftInfo.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
            }
            giftInfo.setGiftShelves(giftShelves);
            giftInfo.setDelFlag("0");
            giftInfo.setDicParam(dicParam);
            giftInfo.setDicGiftType(dicGiftType);
            //设置更新时间,当前系统时间
            giftInfo.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
            giftStoreService.save(giftInfo);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品管理");
            if(org.apache.commons.lang.StringUtils.isEmpty(id)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(giftInfo.getGiftName());
            sysLogVo.setEntityId(giftInfo.getId());
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
    @RequestMapping(value = "/load-giftStoreInfo-delete.do", method = RequestMethod.POST)
    public Map<String, Object> giftStoreInfoDelete(String id) {

        Map<String, Object> map = new HashMap<>(1);
        try {
            GiftInfo giftInfo = this.giftStoreService.get(id);
            //删除标志设为1
            giftInfo.setDelFlag("1");
            giftInfo.setUpdateTime(new Date());
            //保存数据
            giftStoreService.save(giftInfo);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品管理");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(giftInfo.getGiftName());
            sysLogVo.setEntityId(giftInfo.getId());
            sysLogVo.setResult("true");
        } catch (Exception e) {
            logger.info(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }
}
