package com.taiji.frame.controller.foreignaffairs.gift;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.BeanCopyUtil;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.gift.DicGiftType;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftInfo;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.gift.DicGiftTypeVo;
import com.taiji.frame.service.foreignaffairs.gift.DicGiftTypeService;
import com.taiji.frame.service.systempara.SysLogService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author yx
 * @date 2018/11/29
 */
@Controller
@RequestMapping(value = "/gift-type")
public class GiftTypeManageController extends BaseController<DicGiftType> {
    private static final Logger LOG = LoggerFactory.getLogger(GiftTypeManageController.class);

    @Autowired
    private DicGiftTypeService dicGiftTypeService;

    @Autowired
    private SysLogService sysLogService;

    @RequestMapping(value = "/gift-type-manage-list", method = RequestMethod.GET)
    public String list(ModelMap modelMap){

        return "foreignaffairs/gift/gift-type-manage/gift-type-manage-list";
    }

    @ResponseBody
    @RequestMapping(value = "/load-gift-type-list.do", produces = "text/html;charset=UTF-8")
    public String giftShelvesListLoad(Carrier<DicGiftType> carrier, String typeName, String typeNumber) {

        Map<String, Object> map = new HashMap<>(2);

        try {
            if (!StringUtils.isEmpty(typeName)) {
                map.put("typeName", "%" + typeName + "%");
            }
            if (!StringUtils.isEmpty(typeNumber)) {
                map.put("typeNumber", "%" + typeNumber + "%");
            }

            dicGiftTypeService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑礼品类型页面跳转
     */
    @RequestMapping(value = "/load-gift-type-edit.do", method = RequestMethod.GET)
    public String giftTypeEdit(String id, ModelMap modelMap) {

        DicUser dicUser = getCurUser();
        modelMap.addAttribute("dicUser", dicUser);

        if (StringUtils.isNotEmpty(id)) {
            DicGiftType dicGiftType = dicGiftTypeService.get(id);

            modelMap.addAttribute("dicGiftType", dicGiftType);
        }

        return "foreignaffairs/gift/gift-type-manage/gift-type-edit";
    }

    /**
     * 检查类型编码是否重复
     *
     * @param id
     * @param typeNumber 类型编码
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/check-typeNumber.do", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String checkGiftCode(String id, String typeNumber) {
        String flag;

        List<DicGiftType> list = dicGiftTypeService.getDicGiftTypeByTypeNum(typeNumber);
        if (null != list && list.size() != 0) {
            flag = "false";
        } else {
            flag = "true";
        }

        if (StringUtils.isNotEmpty(id)) {
            DicGiftType giftType = dicGiftTypeService.get(id);

            String originalNumber = giftType.getTypeNumber();
            if (typeNumber.equals(originalNumber)) {
                flag = "true";
            }
        }
        return flag;
    }
    /**
     * 保存
     */
    @ResponseBody
    @RequestMapping(value = "/load-gift-type-save.do", method = RequestMethod.POST)
    public Map<String, Object> giftTypeSave(DicGiftType dicGiftTypeVo) {
        Map<String, Object> map = new HashMap<>(1);

        String id = dicGiftTypeVo.getId();

        DicGiftType dicGiftType;
        if (StringUtils.isNotEmpty(id)) {
            dicGiftType = dicGiftTypeService.get(id);
        }else {
            dicGiftType = new DicGiftType();
            dicGiftType.setDelFlag("0");
            dicGiftType.setCreateTime(getCurDate());
            dicGiftType.setCreateName(getCurUser().getEmpName());
        }
        try {
            new BeanCopyUtil().copyNotNullProperties(dicGiftTypeVo, dicGiftType, true);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        dicGiftType.setUpdateTime(getCurDate());

        try {
            dicGiftTypeService.save(dicGiftType);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品管理");
            if(org.apache.commons.lang.StringUtils.isEmpty(id)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(dicGiftType.getTypeName());
            sysLogVo.setEntityId(dicGiftType.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;

    }

    /**
     * 删除礼品类型
     */
    @ResponseBody
    @RequestMapping(value = "/load-gift-type-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteType(String id) {

        Map<String, Object> map = new HashMap<>(1);
        try {
            DicGiftType dicGiftType = dicGiftTypeService.get(id);
            //删除标志设为1
            dicGiftType.setDelFlag("1");
            dicGiftType.setUpdateTime(getCurDate());
            //保存数据
            dicGiftTypeService.save(dicGiftType);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品管理");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(dicGiftType.getTypeName());
            sysLogVo.setEntityId(dicGiftType.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.info(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }
}
