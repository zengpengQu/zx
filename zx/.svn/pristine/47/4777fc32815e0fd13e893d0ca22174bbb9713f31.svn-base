package com.taiji.frame.controller.foreignaffairs.come;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.BeanCopyUtil;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeGiftRecv;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.service.foreignaffairs.come.ComeGiftRecvService;
import com.taiji.frame.service.foreignaffairs.come.ComeInfoService;
import com.taiji.frame.service.systempara.SysLogService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 来访礼品受赠 Controller
 * @author yx
 * @date 2018/8/17
 */
@Controller
@RequestMapping(value = "/come/come-gift-recv")
public class ComeGiftRecvController extends BaseController<ComeGiftRecv> {
    private static final Logger LOG = LoggerFactory.getLogger(ComeGiftRecvController.class);

    @Autowired
    ComeGiftRecvService comeGiftRecvService;

    @Autowired
    ComeInfoService comeInfoService;
    @Autowired
    private SysLogService sysLogService;
    /**
     * 页面跳转至来访礼品受赠 Tab
     */
    @RequestMapping(value = "/gift-receive", method = RequestMethod.GET)
    public String receive(String comeInfoId, ModelMap modelMap) {
        modelMap.addAttribute("comeInfoId", comeInfoId);

        return "foreignaffairs/come/gift-receive";
    }

    /**
     * load grid 礼品受赠列表
     *
     * @param carrier
     * @param comeInfoId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-giftRecv-list.do", produces = "text/html;charset=UTF-8")
    public String giftRecvListLoad(Carrier<ComeGiftRecv> carrier, String comeInfoId) {

        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(comeInfoId)) {
            map.put("comeInfoId", comeInfoId);

            try {
                comeGiftRecvService.load(carrier, map);
            } catch (Exception e) {
                LOG.debug(e.getMessage(), e);
            }
        }
        return gridResult(carrier);
    }


    /**
     * 新增/编辑一条礼品受赠信息
     */
    @ResponseBody
    @RequestMapping(value = "/add-gift-recv-row.do", method = RequestMethod.POST)
    public Map<String, Object> addGiftRecvRow(ComeGiftRecv comeGiftRecv) {
        Map<String, Object> map = new HashMap<>(2);

        try {
            String id = comeGiftRecv.getId();
            comeGiftRecv.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT_DAY_HOUR_MIN));

            if (StringUtils.isEmpty(id)) {
                comeGiftRecv.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT_DAY_HOUR_MIN));
                comeGiftRecv.setDelFlag("0");
                comeGiftRecvService.save(comeGiftRecv);
            } else {
                ComeGiftRecv temp = comeGiftRecvService.get(id);
                new BeanCopyUtil().copyNotNullProperties(comeGiftRecv, temp, true);
                comeGiftRecvService.save(temp);
            }
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("礼品受赠");
            if(org.apache.commons.lang.StringUtils.isEmpty(comeGiftRecv.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(comeGiftRecv.getGiver());
            sysLogVo.setEntityId(comeGiftRecv.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 删除一条礼品受赠信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/giftRecv-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDelete(String id) {
        Map<String, Object> map = new HashMap<>(1);
        try {
            if (StringUtils.isNotEmpty(id)) {
                ComeGiftRecv comeGiftRecv = comeGiftRecvService.get(id);
                comeGiftRecv.setDelFlag("1");
                comeGiftRecvService.save(comeGiftRecv);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("礼品受赠");
                    sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(comeGiftRecv.getGiver());
                sysLogVo.setEntityId(comeGiftRecv.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

}
