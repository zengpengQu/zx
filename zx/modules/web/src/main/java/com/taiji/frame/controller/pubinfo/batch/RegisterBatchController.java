package com.taiji.frame.controller.pubinfo.batch;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.ListSortUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.pubinfo.batch.*;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.batch.*;
import com.taiji.frame.service.pubinfo.batch.*;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 呈批件内行文流转登记的记录
 * @author wsh
 * @date 2018/9/21
 */
@Controller
@RequestMapping(value = "/register-batch-nei")
public class RegisterBatchController extends BaseController<DraftBatch>{
    private static final Logger log = LoggerFactory.getLogger(TransferRegisterBatchController.class);

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);
    @Autowired
    private DicDeptService dicDeptService;
    @Autowired
    private DraftBatchService draftBatchService;
    @Autowired
    private DicReasonService dicReasonService;
    @Autowired
    private RegisterBatchService registerBatchService;
    @Autowired
    private SubmitBatchService submitBatchService;
    @Autowired
    private DraftDutyService draftDutyService;
    @Autowired
    private DataExportService dataExportService;
    @Autowired
    private LeaderManageService leaderManageService;
    @Autowired
    private CountersignUnitService countersignUnitService;
    @Autowired
    private SysLogService sysLogService;
    /**
     * 流转登记页面跳转,暂时不用
     */
    @RequestMapping(value = "/batch-transfer-reg", method = RequestMethod.GET)
    public String batchTransfer(ModelMap modelMap,String id) {
        HashMap map = new HashMap(16);
        if(StringUtils.isNotEmpty(id)){
            map.put("id",id);
        }

        //查出领导的批示,用于历史流转记录
        List<RegisterBatch> list =  dataExportService.RegisterSearch(map);
        modelMap.addAttribute("registerList",list);
        //查出领导姓名列表
        List<LeaderManage> leaderManageList = leaderManageService.getAllByStatus("0");
        modelMap.addAttribute("leaderManageList",leaderManageList);
        //领导职务
        List<DicDuty> dutyList = draftDutyService.getAllDuty();
        modelMap.addAttribute("dutyList",dutyList);
        //补录理由
        List<DicReason> dicReasonList = dicReasonService.getAllByStatus(1);
        modelMap.addAttribute("dicReasonList", dicReasonList);
        //编辑数据
        if (StringUtils.isNotEmpty(id)){
            DraftBatch draftBatch =  submitBatchService.get(id);
            modelMap.addAttribute("model", draftBatch);
        }
        return "pubinfo/batch/register-batch/batch-transfer-register";
    }
    /**
     *  呈批件扫描跳转页面，暂时不用
     */
    @RequestMapping(value = "/batch-register-qcode",method = RequestMethod.GET)
    public String batchLoadView(ModelMap modelMap, String id) {
        return "pubinfo/batch/register-batch/batch-transfer-qcode";
    }

    /**
     * 内行文呈批件领导批示流转登记保存
     */
    @ResponseBody
    @RequestMapping(value = "/transfer-register-batch-save.do", method = RequestMethod.POST)
    public Map batchTransferRegisterSave(RegisterBatchVo registerBatchVo,ModelMap modelMap) {

        modelMap.addAttribute("result","nei");

        Map<String, Object> map = new HashMap<>(16);

        try {
            RegisterBatch registerBatch = new RegisterBatch();
            //获取到呈批件的id
            String batchDraftDetId = registerBatchVo.getBatchDraftDetId();
            DraftBatch draftBatch = draftBatchService.get(batchDraftDetId);
            //领导姓名
            List<LeaderManageVo> leaderManageVoList = registerBatchVo.getLeaderManageList();
            if (null != leaderManageVoList && leaderManageVoList.size()>0){
                String leaId = leaderManageVoList.get(0).getLea_Id();
                LeaderManage leaderManage = leaderManageService.get(leaId);
                //保存领导姓名Id
                registerBatch.setLeaderManage(leaderManage);
                //保存领导姓名
                registerBatch.setReportLeader(leaderManage.getLeaName());
                //设置一个根据领导姓名的排序字段
                registerBatch.setSeq(leaderManage.getSeq());
            }
            //领导批示
            String conmentsLeader = registerBatchVo.getConmentsLeader();
            //领导职务
           List<DicDutyVo> dicDutyVoList = registerBatchVo.getDicDutyVoList();
            if (null != dicDutyVoList && dicDutyVoList.size()>0){
                String dutyId = dicDutyVoList.get(0).getDutyId();
                if (StringUtils.isNotEmpty(dutyId)){
                    //设值职务编号名称
                    DicDuty dicDuty =  draftDutyService.get(dutyId);
                    registerBatch.setDutyName(dicDuty.getDutyName());
                    registerBatch.setDicDuty(dicDuty);
                }
            }
            //产生一个更新时间
            Date updateTime = new Date();
            String sendTimeStr = DateUtil.dateToString(updateTime,DateUtil.FORMAT_DAYTIME);
            Date updateTimeStr = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
            registerBatch.setUpdateTime(updateTimeStr);

            registerBatch.setDraftBatch(draftBatch);
            registerBatch.setConmentsLeader(conmentsLeader);
            registerBatch.setDelFlag("0");
            registerBatchService.save(registerBatch);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("呈批件领导批示流转登记");
            sysLogVo.setRecordType(0);
            sysLogVo.setEntityId(registerBatch.getId());
            sysLogVo.setEntityName(registerBatch.getReportLeader());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 内行文呈批件会签流转登记保存
     */
    @ResponseBody
    @RequestMapping(value = "/transfer-unit-batch-save.do", method = RequestMethod.POST)
    public Map batchTransferUnitSave(ModelMap modelMap,CountersignUnit countersignUnit,RegisterBatchVo registerBatchVo,CountersignUnitVo countersignUnitVo) {

        modelMap.addAttribute("result","nei");
        Map<String, Object> map = new HashMap<>(16);

        try {
            RegisterBatch registerBatch = new RegisterBatch();
            //获取到呈批件的id
            String batchDraftDetId = registerBatchVo.getBatchDraftDetId();
            DraftBatch draftBatch = draftBatchService.get(batchDraftDetId);
            countersignUnit.setDraftBatch(draftBatch);
            //会签人姓名
            String countersignName = countersignUnit.getCountersignName();
            countersignUnit.setCountersignName(countersignName);
            //会签单位
            String unitId = countersignUnitVo.getUnitId();
            DicDept dept = dicDeptService.get(unitId);
            countersignUnit.setCountersignUnit(dept);
            //会签意见
            String countersignOpinion = countersignUnit.getCountersignOpinion();
            countersignUnit.setCountersignOpinion(countersignOpinion);

            //产生一个更新时间
            Date updateTime = new Date();
            String sendTimeStr = DateUtil.dateToString(updateTime,DateUtil.FORMAT_DAYTIME);
            Date updateTimeStr = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
            countersignUnit.setUpdateTime(updateTimeStr);

            countersignUnitService.save(countersignUnit);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("呈批件会签流转登记");
            sysLogVo.setRecordType(0);
            sysLogVo.setEntityId(registerBatch.getId());
            sysLogVo.setEntityName(registerBatch.getReportLeader());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 内行文领导批示二维码扫描后的登记
     */
    @RequestMapping(value = "/batch-transfer-code", method = RequestMethod.GET)
    public String batchTransferCode(ModelMap modelMap, HttpServletRequest request) {
        HashMap map = new HashMap(16);
        String batchDraftId = request.getParameter("batchDraftId");
        if(StringUtils.isNotEmpty(batchDraftId)){
            map.put("id",batchDraftId);
        }

        //查出领导批示用于历史流转记录跟踪
        List<RegisterBatch> list =  dataExportService.RegisterSearch(map);
        modelMap.addAttribute("registerList",list);
        //查出会签意见
        List<CountersignUnit> list1 = countersignUnitService.CountersignSearch(map);

        modelMap.addAttribute("conutersignUnit",list1);
        //查出领导姓名列表
        List<LeaderManage> leaderManageList = leaderManageService.getAllByStatus("0");
        modelMap.addAttribute("leaderManageList",leaderManageList);
        //领导职务
        List<DicDuty> dutyList = draftDutyService.getAllDuty();
        modelMap.addAttribute("dutyList",dutyList);
        //补录理由
        List<DicReason> dicReasonList = dicReasonService.getAllByStatus(1);
        modelMap.addAttribute("dicReasonList", dicReasonList);
        //编辑数据
        if (StringUtils.isNotEmpty(batchDraftId)){
            DraftBatch draftBatch =  submitBatchService.get(batchDraftId);
            modelMap.addAttribute("model", draftBatch);
            if (draftBatch != null){
                String sendTimeStr = DateUtil.dateToString(draftBatch.getSendTime(),DateUtil.FORMAT_DAYTIME);
                if (!"".equals(sendTimeStr)){
                    String[] str = sendTimeStr.split(" ");
                    modelMap.addAttribute("hour",str[1]);
                    modelMap.addAttribute("day",str[0]);
                }
            }
        }

        //用于排序使用
        List <ConmentsVo>listSeq = new ArrayList<>();
        for (int i=0;i<list.size();i++){
            RegisterBatch registerBatch = list.get(i);
            ConmentsVo conmentsVo = new ConmentsVo();
            conmentsVo.setUpdateTime(registerBatch.getUpdateTime());
            conmentsVo.setDutyName(registerBatch.getDutyName());
            conmentsVo.setReportLeader(registerBatch.getReportLeader());
            conmentsVo.setConmentsLeaer(registerBatch.getConmentsLeader());
            listSeq.add(conmentsVo);
        }
        for (int j=0;j<list1.size();j++){
            CountersignUnit countersignUnit = list1.get(j);
            ConmentsVo conmentsVo = new ConmentsVo();
            conmentsVo.setUpdateTime(countersignUnit.getUpdateTime());
            conmentsVo.setCountersignUnitName(countersignUnit.getCountersignUnit().getAbsName());
            conmentsVo.setReportLeader(countersignUnit.getCountersignName());
            conmentsVo.setConmentsLeaer(countersignUnit.getCountersignOpinion());
            listSeq.add(conmentsVo);
        }

        //使用工具类进行排序
        new ListSortUtil<ConmentsVo>().mySort(listSeq,"updateTime","asc");
        Map<String,List<ConmentsVo>>mapSeq = new HashMap<>();
        for (int m=0;m<listSeq.size();m++){
            List<ConmentsVo> listVo = new ArrayList<>();
            ConmentsVo conmentsVo = listSeq.get(m);
            if (conmentsVo != null){
                String dayTimeStr = DateUtil.dateToString(conmentsVo.getUpdateTime(), DateUtil.FORMAT_DAYTIME);
                String[] str = dayTimeStr.split(" ");
                String hourTime = str[1];
                String dayTime = str[0];
                for (int n=0;n<listSeq.size();n++){
                    ConmentsVo conmentsVo1 = listSeq.get(n);
                    if (conmentsVo1 != null){
                        String dayTimeStr1 = DateUtil.dateToString(conmentsVo1.getUpdateTime(), DateUtil.FORMAT_DAYTIME);
                        String[] str1 = dayTimeStr1.split(" ");
                        String hourTime1 = str1[1];
                        String dayTime1 = str1[0];
                        if (dayTime.equals(dayTime1)){
                            conmentsVo1.setHourTime(hourTime1);
                            listVo.add(conmentsVo1);
                            listSeq.set(n,null);
                        }
                    }
                }
                new ListSortUtil<ConmentsVo>().mySort(listVo,"hourTime","desc");
                mapSeq.put(dayTime,listVo);
            }
        }
        modelMap.addAttribute("mapSeq",mapSeq);

        return "pubinfo/batch/register-batch/batch-transfer-register";
    }

    /**
     * 内行文会签二维码扫描后的登记
     */
    @RequestMapping(value = "/batch-transfer-codeunit", method = RequestMethod.GET)
    public String batchTransferCodeUnit(ModelMap modelMap, HttpServletRequest request) {
        HashMap map = new HashMap(16);
        String batchDraftId = request.getParameter("batchDraftId");
        if(StringUtils.isNotEmpty(batchDraftId)){
            map.put("id",batchDraftId);
        }

        //查出领导的批示用于历史记录跟踪
        List<RegisterBatch> list =  dataExportService.RegisterSearch(map);
        modelMap.addAttribute("registerList",list);
        //查出会签意见
        List<CountersignUnit> list1 = countersignUnitService.CountersignSearch(map);
        modelMap.addAttribute("conutersignUnit",list1);
        //查出领导姓名列表
        List<LeaderManage> leaderManageList = leaderManageService.getAllByStatus("0");
        modelMap.addAttribute("leaderManageList",leaderManageList);
        //领导职务
        List<DicDuty> dutyList = draftDutyService.getAllDuty();
        modelMap.addAttribute("dutyList",dutyList);
        //补录理由
        List<DicReason> dicReasonList = dicReasonService.getAllByStatus(1);
        modelMap.addAttribute("dicReasonList", dicReasonList);
        //编辑数据
        if (StringUtils.isNotEmpty(batchDraftId)){
            DraftBatch draftBatch =  submitBatchService.get(batchDraftId);
            modelMap.addAttribute("model", draftBatch);
            if (draftBatch != null){
                String sendTimeStr = DateUtil.dateToString(draftBatch.getSendTime(),DateUtil.FORMAT_DAYTIME);
                if (!"".equals(sendTimeStr)){
                    String[] str = sendTimeStr.split(" ");
                    modelMap.addAttribute("hour",str[1]);
                    modelMap.addAttribute("day",str[0]);
                }
            }
        }

        //用于排序使用
        List <ConmentsVo>listSeq = new ArrayList<>();
        for (int i=0;i<list.size();i++){
            RegisterBatch registerBatch = list.get(i);
            ConmentsVo conmentsVo = new ConmentsVo();
            conmentsVo.setUpdateTime(registerBatch.getUpdateTime());
            conmentsVo.setDutyName(registerBatch.getDutyName());
            conmentsVo.setReportLeader(registerBatch.getReportLeader());
            conmentsVo.setConmentsLeaer(registerBatch.getConmentsLeader());
            listSeq.add(conmentsVo);
        }
        for (int j=0;j<list1.size();j++){
            CountersignUnit countersignUnit = list1.get(j);
            ConmentsVo conmentsVo = new ConmentsVo();
            conmentsVo.setUpdateTime(countersignUnit.getUpdateTime());
            conmentsVo.setCountersignUnitName(countersignUnit.getCountersignUnit().getAbsName());
            conmentsVo.setReportLeader(countersignUnit.getCountersignName());
            conmentsVo.setConmentsLeaer(countersignUnit.getCountersignOpinion());
            listSeq.add(conmentsVo);
        }

        //使用工具类进行排序
        new ListSortUtil<ConmentsVo>().mySort(listSeq,"updateTime","asc");
        Map<String,List<ConmentsVo>>mapSeq = new HashMap<>();
        for (int m=0;m<listSeq.size();m++){
            List<ConmentsVo> listVo = new ArrayList<>();
            ConmentsVo conmentsVo = listSeq.get(m);
            if (conmentsVo != null){
                String dayTimeStr = DateUtil.dateToString(conmentsVo.getUpdateTime(), DateUtil.FORMAT_DAYTIME);
                String[] str = dayTimeStr.split(" ");
                String hourTime = str[1];
                String dayTime = str[0];
                for (int n=0;n<listSeq.size();n++){
                    ConmentsVo conmentsVo1 = listSeq.get(n);
                    if (conmentsVo1 != null){
                        String dayTimeStr1 = DateUtil.dateToString(conmentsVo1.getUpdateTime(), DateUtil.FORMAT_DAYTIME);
                        String[] str1 = dayTimeStr1.split(" ");
                        String hourTime1 = str1[1];
                        String dayTime1 = str1[0];
                        if (dayTime.equals(dayTime1)){
                            conmentsVo1.setHourTime(hourTime1);
                            listVo.add(conmentsVo1);
                            listSeq.set(n,null);
                        }
                    }
                }
                new ListSortUtil<ConmentsVo>().mySort(listVo,"hourTime","desc");
                mapSeq.put(dayTime,listVo);
            }
        }
        modelMap.addAttribute("mapSeq",mapSeq);

        return "pubinfo/batch/register-batch/batch-transfer-registerunit";
    }

    /**
     * 流转登记内行文列表的展示,暂时不用
     */
    @ResponseBody
    @RequestMapping(value = "/load-batch-register-list.do", produces = "text/html;charset=UTF-8")
    public String batchRegisterList(Carrier<DraftBatch> carrier, DraftBatchVo draftBatchVo) {

        HashMap map = new HashMap(16);
        try {

            String startDateStr = draftBatchVo.getSendTimeStr();
            String endDateStr = draftBatchVo.getEndTime();
            String title = draftBatchVo.getTitle();
            if(!org.apache.commons.lang.StringUtils.isEmpty(startDateStr)){
                map.put("startDate", startDateStr);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(endDateStr)){
                map.put("endDate", endDateStr);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(title)){
                map.put("title", title);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(draftBatchVo.getOrgName())){
                map.put("orgName", draftBatchVo.getOrgName());
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(draftBatchVo.getReporter())){
                map.put("reporter", draftBatchVo.getReporter());
            }

            registerBatchService.load(carrier,map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }



}
