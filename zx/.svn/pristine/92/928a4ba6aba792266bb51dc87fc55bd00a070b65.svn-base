package com.taiji.frame.controller.foreignaffairs.abroad;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadGiftPre;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.abroad.AbroadGiftPreVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadGiftPreService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "/abroad-gift-pre")
public class AbroadGiftPreController extends BaseController<AbroadGiftPre> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private AbroadGiftPreService abroadGiftPreService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private SysLogService sysLogService;


    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-gift-pre-list.do", produces = "text/html;charset=UTF-8")
    public String preListLoad(Carrier<AbroadGiftPre> carrier, AbroadGiftPreVo abroadGiftPreVo) {
        HashMap map = new HashMap(16);
        try {
            if (!StringUtils.isEmpty(abroadGiftPreVo.getAbroadInfoId())) {
                map.put("abroadInfoId", abroadGiftPreVo.getAbroadInfoId());
            }
            abroadGiftPreService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑弹窗
     */
    @RequestMapping(value = "/load-gift-pre-edit.do", method = RequestMethod.GET)
    public String giftPreEdit(ModelMap modelMap, String id) {
        AbroadGiftPre abroadGiftPre = null;
        if (!StringUtils.isEmpty(id)) {
            abroadGiftPre = abroadGiftPreService.get(id);
        }
        modelMap.addAttribute("abroadGiftPre", abroadGiftPre);
        return "foreignaffairs/abroad/abroad-gift-pre-edit";
    }

    /**
     * 新增/编辑保存
     */
    @ResponseBody
    @RequestMapping(value = "/gift-pre-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveGiftPre(HttpServletRequest request, AbroadGiftPreVo abroadGiftPreVo) {
        Map<String, Object> map = new HashMap<>(2);

        AbroadGiftPre abroadGiftPre;
        String id = abroadGiftPreVo.getId();
        if (id != null) {
            abroadGiftPre = abroadGiftPreService.get(id);
        } else {
            abroadGiftPre = new AbroadGiftPre();
            abroadGiftPre.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
        }

        try {
            AbroadInfo abroadInfo = abroadInfoService.get(abroadGiftPreVo.getAbroadInfoId());
            abroadGiftPre.setAbroadInfo(abroadInfo);

            abroadGiftPre.setNation(abroadGiftPreVo.getNation());
            abroadGiftPre.setGiver(abroadGiftPreVo.getGiver());
            abroadGiftPre.setDonee(abroadGiftPreVo.getDonee());
            abroadGiftPre.setGifts(abroadGiftPreVo.getGifts());
            abroadGiftPre.setGiftsReturn(abroadGiftPreVo.getGiftsReturn());
            abroadGiftPre.setGiftsRemain(abroadGiftPreVo.getGiftsRemain());
            abroadGiftPre.setNotes(abroadGiftPreVo.getNotes());

            abroadGiftPre.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
            abroadGiftPre.setDelFlag("0");

            abroadGiftPreService.save(abroadGiftPre);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品管理");
            if(org.apache.commons.lang.StringUtils.isEmpty(abroadGiftPreVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(abroadGiftPre.getGifts());
            sysLogVo.setEntityId(abroadGiftPre.getId());
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
    @RequestMapping(value = "/gift-pre-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteGiftdPre(String id) {
        Map<String, Object> map = new HashMap<>(2);
        try {
            AbroadGiftPre abroadGiftPre = abroadGiftPreService.get(id);
            abroadGiftPreService.delete(abroadGiftPre);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品管理");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(abroadGiftPre.getGifts());
            sysLogVo.setEntityId(abroadGiftPre.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }



}
