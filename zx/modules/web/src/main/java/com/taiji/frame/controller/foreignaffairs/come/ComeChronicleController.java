package com.taiji.frame.controller.foreignaffairs.come;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.BeanCopyUtil;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.Chronicle;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeChronicleVo;
import com.taiji.frame.service.foreignaffairs.come.ComeInfoService;
import com.taiji.frame.service.foreignaffairs.tempForeignAffairs.ChronicleService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
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
 * 来访大事记
 *
 * @author yx
 */
@Controller
@RequestMapping(value = "/come/come-chronicle")
public class ComeChronicleController extends BaseController<Chronicle> {
    private static final Logger LOG = LoggerFactory.getLogger(ComeChronicleController.class);

    @Autowired
    ChronicleService chronicleService;

    @Autowired
    ComeInfoService comeInfoService;

    @Autowired
    UtilService utilService;

    @Autowired
    private SysLogService sysLogService;


    /**
     * 加载来访大事记页面
     * @param modelMap
     * @param comeInfoId
     * @return
     */
    @RequestMapping(value = "/load-come-chronicle", method = RequestMethod.GET)
    public String loadChronicle(ModelMap modelMap, String comeInfoId) {

        if (StringUtils.isNotEmpty(comeInfoId)) {

            ComeInfo comeInfo = comeInfoService.get(comeInfoId);

            modelMap.addAttribute("startDate", DateUtil.dateToString(comeInfo.getStartDate(), DateUtil.FORMAT_DAY));
            modelMap.addAttribute("endDate", DateUtil.dateToString(comeInfo.getEndDate(), DateUtil.FORMAT_DAY));
            modelMap.put("comeInfoId", comeInfoId);


        }

        return "foreignaffairs/come/come-chronicle-list";
    }

    /**
     * load grid 来访简报表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-chronicle-list.do", produces = "text/html;charset=UTF-8")
    public String loadAccompanyList(Carrier<Chronicle> carrier, String comeInfoId) {
        HashMap map = new HashMap(1);
        try {
            if (!StringUtils.isEmpty(comeInfoId)) {
                map.put("comeInfoId", comeInfoId);
            }
            chronicleService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑
     */
    @ResponseBody
    @RequestMapping(value = "/chronicle-edit.do", method = RequestMethod.POST)
    public Map<String, Object> saveChronicle(String chronicleList, String comeInfoId) {
        Map<String, Object> map = new HashMap<>(1);

        JSONArray jsonArray = JSONArray.fromObject(chronicleList);

        try {
            ComeInfo comeInfo = comeInfoService.get(comeInfoId);
            if (jsonArray.size() > 0) {
                for (int i = 0; i < jsonArray.size(); i++) {
                    JSONObject jsonObject = jsonArray.getJSONObject(i);
                    ComeChronicleVo comeChronicleVo = new ComeChronicleVo();
                    new BeanCopyUtil().copyNotNullProperties(jsonObject, comeChronicleVo, true);
                    String chronicleId = comeChronicleVo.getId();
                    Chronicle chronicle = null;
                    // 已存在的大事记
                    if (StringUtils.isNotEmpty(chronicleId)) {
                        chronicle = chronicleService.get(chronicleId);
                    } else {
                        chronicle = new Chronicle();
                        new BeanCopyUtil().copyNotNullProperties(comeChronicleVo, chronicle, true);
                        // 新增的大事记
                        chronicle.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN));
                        chronicle.setComeInfo(comeInfo);
                        chronicle.setBeginTime(DateUtil.stringToDate(comeChronicleVo.getBeginTimeStr(), DateUtil.FORMAT_DAY));
                        chronicle.setEndTime(DateUtil.stringToDate(comeChronicleVo.getEndTimeStr(), DateUtil.FORMAT_DAY));
                        chronicle.setGroupName(comeInfo.getGroupName());
                        chronicle.setDicParam(comeInfo.getGroupLevel());
                        chronicle.setDelFlag("0");
                    }
                    chronicle.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN));

                    chronicleService.save(chronicle);
                }
            }

        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        map.put("result", true);
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("来访大事记");
            sysLogVo.setRecordType(-1);
        sysLogVo.setEntityName("");
        sysLogVo.setEntityId("");
        sysLogVo.setResult("true");
        sysLogService.record(sysLogVo);
        return map;
    }


    /**
     * 新增/编辑一条来访大事记
     */
    @ResponseBody
    @RequestMapping(value = "/add-chronicle-row.do", method = RequestMethod.POST)
    public Map<String, Object> addVisitorRow(ComeChronicleVo comeChronicleVo) {
        Map<String, Object> map = new HashMap<>(2);

        try {
            ComeInfo comeInfo = comeInfoService.get(comeChronicleVo.getComeInfoId());
            Chronicle chronicle = new Chronicle();

            BeanUtils.copyProperties(comeChronicleVo, chronicle);

            chronicle.setComeInfo(comeInfo);
            chronicle.setGroupName(comeInfo.getGroupName());
            chronicle.setDicParam(comeInfo.getGroupLevel());

            String beginTimeStr = comeChronicleVo.getBeginTimeStr();
            Date beginTime = DateUtil.stringToDate(beginTimeStr, DateUtil.FORMAT_DAY);
            chronicle.setBeginTime(beginTime);

            String endTimeStr = comeChronicleVo.getEndTimeStr();
            Date endTime = DateUtil.stringToDate(endTimeStr, DateUtil.FORMAT_DAY);
            chronicle.setEndTime(endTime);


            chronicle.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT_DAY_HOUR_MIN));
            chronicle.setDelFlag("0");

            chronicleService.save(chronicle);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("来访大事记");
            if(org.apache.commons.lang.StringUtils.isEmpty(comeChronicleVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(chronicle.getNotes());
            sysLogVo.setEntityId(chronicle.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 获取一条来访大事记
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/get-one-chronicle.do", method = RequestMethod.POST)
    public Map<String, Object> getOneChronicle(String id) {

        Map<String, Object> map = new HashMap<>(2);

        if (StringUtils.isNotEmpty(id)) {
            try {
                Chronicle chronicle = chronicleService.get(id);

                map.put("chronicle", chronicle.getJsonObject());
                map.put("result", true);
            } catch (Exception e) {
                map.put("result", false);
                LOG.debug(e.getMessage(), e);
            }
        }
        return map;
    }

    /**
     * 删除一条来访大事记记录
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/chronicle-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteAccompany(String id) {
        Map<String, Object> map = new HashMap<>(1);

        try {
            Chronicle chronicle = chronicleService.get(id);
            chronicle.setDelFlag("1");
            chronicleService.save(chronicle);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("来访大事记");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(chronicle.getNotes());
            sysLogVo.setEntityId(chronicle.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
        }

        return map;
    }
}
