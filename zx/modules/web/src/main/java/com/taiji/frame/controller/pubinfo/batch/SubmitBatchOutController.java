package com.taiji.frame.controller.pubinfo.batch;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.ListSortUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.pubinfo.batch.*;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.batch.*;
import com.taiji.frame.service.pubinfo.batch.*;
import com.taiji.frame.service.systempara.DicDeptService;
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
import java.util.*;

/**
 * @author admin
 * 呈批件报送
 */
@Controller
@RequestMapping(value = "/submit-batch-out")
public class SubmitBatchOutController extends BaseController<DraftBatchOut> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);
    @Autowired
    private SubmitBatchOutService submitBatchOutService;
    @Autowired
    private SubmitBatchService submitBatchService;
    @Autowired
    private DicDeptService dicDeptService;
    @Autowired
    private DraftBatchOutService draftBatchOutService;
    @Autowired
    private DicReasonService dicReasonService;
    @Autowired
    private DataExportService dataExportService;
    @Autowired
    private UtilService utilService;
    @Autowired
    private CountersignUnitService countersignUnitService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 新增页面跳转
     */
    @RequestMapping(value = "/batch-submit-list", method = RequestMethod.GET)
    public String batchDraftEdit(ModelMap modelMap,String id,String indexId,Map<String, Object> map) {

        modelMap.addAttribute("result","wai");
        /*DraftBatch draftBatch  = new DraftBatch();
        DraftBatchOut draftBatchOut = new DraftBatchOut();
        if (StringUtils.isNotEmpty(id)){
           draftBatch = draftBatchService.get(id);
        }
        if (StringUtils.isNotEmpty(id)){
            draftBatchOut = draftBatchOutService.get(id);
        }*/
        if (StringUtils.isNotEmpty(indexId)){
            modelMap.addAttribute("batchDraftEditIndexMainId", indexId);
            modelMap.addAttribute("isWai", 1);

        }

        //系统当前用户
        DicUser dicUser = getCurUser();
        //用户所在当前部门
        DicDept curDept = dicUser.getDicDept();
        map.put("curDept", curDept.getJsonObject());

        Date sysDate = utilService.getSysTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(sysDate);
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        modelMap.addAttribute("year", year);
        modelMap.addAttribute("month", month);
        modelMap.addAttribute("day", day);

        return "pubinfo/batch/submit-batch/batch-submit-list";
    }
    /**
     * 页面集合
     */
    @ResponseBody
    @RequestMapping(value = "/load-batch-submit-wai-list.do", produces = "text/html;charset=UTF-8")
    public String batchSubmitOutList(ModelMap modelMap,Carrier<DraftBatchOut> carrier, DraftBatchOutVo draftBatchOutVo,String batchDraftEditIndexMainIdWai,String statuss) {

        modelMap.addAttribute("result","wai");
        HashMap map = new HashMap(16);
        try {
            String title = draftBatchOutVo.getTitle();
            String orgId = draftBatchOutVo.getOrgId();
            String startDateStr = draftBatchOutVo.getStartDateWai();
            String endDateStr = draftBatchOutVo.getEndDateWai();
            if(!org.apache.commons.lang.StringUtils.isEmpty(title)){
                map.put("title",title);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(orgId)){
                map.put("orgId",orgId);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(startDateStr)){
                map.put("startDateWai", startDateStr);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(endDateStr)){
                map.put("endDateWai", endDateStr);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(statuss)){
                map.put("statuss", statuss);
            }

            //孙毅添加
            if(StringUtils.isNotEmpty(draftBatchOutVo.getStartDateWai())){
                map.put("startDateWai",draftBatchOutVo.getStartDateWai());
            }
            if(StringUtils.isNotEmpty(draftBatchOutVo.getEndDateWai())){
                map.put("endDateWai",draftBatchOutVo.getEndDateWai());
            }
            if(StringUtils.isNotEmpty(draftBatchOutVo.getReporterWai())){
                map.put("reporterWai",draftBatchOutVo.getReporterWai());
            }
            if(StringUtils.isNotEmpty(batchDraftEditIndexMainIdWai)){
                map.put("batchDraftEditIndexMainIdWai",batchDraftEditIndexMainIdWai);
            }

            submitBatchOutService.load(carrier,map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }
    /**
     *  外单位呈批件外单位来文的编辑
     */
    @RequestMapping(value = "/batch-submit-wai-edit", method = RequestMethod.GET)
    public String batchDraftEditWai(String id,ModelMap modelMap) {

        //补录理由
        List<DicReason> dicReasonList = dicReasonService.getAllByStatus(1);
        modelMap.addAttribute("dicReasonList", dicReasonList);
        //编辑数据
        if (StringUtils.isNotEmpty(id)){
            DraftBatchOut draftBatchOut =  submitBatchOutService.get(id);
            modelMap.addAttribute("draftBatchOut", draftBatchOut);
            //如果编辑数据时时补录的，让让补录的div显示出来
            if(null != draftBatchOut.getDicReason()){
                modelMap.addAttribute("showReason",1);
            }
        }
        return "pubinfo/batch/submit-batch/batch-submit-wai-add";
    }



    /**
     *  呈批件外单位补录
     */
    @RequestMapping(value = "/batch-submit-wai-record", method = RequestMethod.GET)
    public String batchDraftRecordWai(String id,ModelMap modelMap) {

        //补录理由
        List<DicReason> dicReasonList = dicReasonService.getAllByStatus(1);
        modelMap.addAttribute("dicReasonList", dicReasonList);
        //补录时让审核人的div显示出来
        modelMap.addAttribute("showStatus",1);
        //核稿人的数据获取封装,获取当前用户，暂时已作废
        DicUser currentUser = getCurUser();
        modelMap.addAttribute("currentUsers",currentUser);

        return "pubinfo/batch/submit-batch/batch-submit-wai-add";
    }

    /**
     *  外行文呈批件核稿
     */
    @RequestMapping(value = "/batch-submit-wai-check", method = RequestMethod.GET)
    public String batchDraftCheckWai(String id,ModelMap modelMap) {

        //补录理由
        List<DicReason> dicReasonList = dicReasonService.getAllByStatus(1);
        modelMap.addAttribute("dicReasonList", dicReasonList);
        //编辑数据
        if (StringUtils.isNotEmpty(id)){
            DraftBatchOut draftBatchOut =  submitBatchOutService.get(id);
            modelMap.addAttribute("draftBatchOut", draftBatchOut);
            //核稿时如果是补录的呈批件让补录理由div显示出来
            if(null != draftBatchOut.getDicReason()){
                modelMap.addAttribute("showReason",1);
            }
        }
        //核稿人的数据获取封装,获取当前用户
        DicUser currentUser = getCurUser();
        modelMap.addAttribute("currentUsers",currentUser);
        //让前台页面的审核人div显示出来
        modelMap.addAttribute("checkStatus",1);

        return "pubinfo/batch/submit-batch/batch-submit-wai-add";
    }

    /**
     * 外行文的编辑、核稿或者补录的保存
     */
    @ResponseBody
    @RequestMapping(value = "/batch-submit-wai-save.do", method = RequestMethod.POST)
    public Map batchDraftWaiSave(DraftBatchOutVo draftBatchOutVo,ModelMap modelMap) {

        modelMap.addAttribute("result","wai");

        Map<String, Object> map = new HashMap<>(16);

        try {
            //判断是补录还是编辑
            DraftBatchOut draftBatchOut;
            if(StringUtils.isEmpty(draftBatchOutVo.getId())){
                draftBatchOut = new DraftBatchOut();
            }else {
                draftBatchOut = draftBatchOutService.get(draftBatchOutVo.getId());
            }

            //标题
            String title = draftBatchOutVo.getTitle();
            //来文单位
            String orgName = draftBatchOutVo.getOrgName();
            //承办单位,暂时作废
            /*List<DicDeptVo> underUnitOutVoList = draftBatchOutVo.getUnderUnitOutVoList();
            if (null != underUnitOutVoList && underUnitOutVoList.size()>0){
                String deptId = underUnitOutVoList.get(0).getDeptId();
                if (StringUtils.isNotEmpty(deptId)){
                    DicDept dicDept =  dicDeptService.get(deptId);
                    draftBatchOut.setDeptName(dicDept.getDeptName());
                    draftBatchOut.setOrgDept(dicDept);
                }
            }*/
            //承办单位，使用存储ID
            String orgId = draftBatchOutVo.getOrgId();
            DicDept orgDept = dicDeptService.get(orgId);
            draftBatchOut.setOrgDept(orgDept);
            //承办人
            String contractor = draftBatchOutVo.getContractor();
            //承办方单位领导
            String depLeader = draftBatchOutVo.getDepLeader();
            //联系电话
            String tel = draftBatchOutVo.getTel();
            //是否会签（0否1是）
            String counterSignFlag = draftBatchOutVo.getCounterSignFlag();
            //会签单位，暂时作废
            /*List<DicDeptVo> dicDeptSignVoList = draftBatchOutVo.getDicDeptOutVoList();
            if (null != dicDeptSignVoList && dicDeptSignVoList.size()>0){
                String deptId = dicDeptSignVoList.get(0).getDeptId();
                if (StringUtils.isNotEmpty(deptId)){
                    DicDept dicDept =  dicDeptService.get(deptId);
                    draftBatchOut.setCounterSignUnit(dicDept.getDeptName());
                    draftBatchOut.setDicDept(dicDept);
                }
            }*/
            //存储会签单位，会签单位可以存储多个
            String counterSignUnit = draftBatchOutVo.getCounterSignUnit();
            draftBatchOut.setCounterSignUnit(counterSignUnit);
            //设值状态status
            draftBatchOut.setStatus("0");

            //审核人
            if(StringUtils.isNotEmpty(draftBatchOutVo.getApprover())){
                String approver = draftBatchOutVo.getApprover();
                draftBatchOut.setApprover(approver);
                draftBatchOut.setStatus("1");
            }

            //补录理由
            List<DicReasonVo> dicReasonVoOutList =draftBatchOutVo.getDicReasonVoOutList();
            if(null != dicReasonVoOutList && dicReasonVoOutList.size()>0){
                String reasonId = dicReasonVoOutList.get(0).getReasonId();
                if(StringUtils.isNotEmpty(reasonId)){
                    DicReason dicReason = dicReasonService.get(reasonId);
                    draftBatchOut.setDicReason(dicReason);
                    //如果是补录直接设置成已查收状态
                    draftBatchOut.setStatus("3");
                    //产生一个上报时间
                    Date sendTime = new Date();
                    String sendTimeStr = DateUtil.dateToString(sendTime,DateUtil.FORMAT_DAYTIME);
                    Date sendTimeSt = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
                    draftBatchOut.setSendTime(sendTimeSt);
                    //设值流水号
                    Integer serNumber = submitBatchService.findNumber();
                    Integer serNumberWai = submitBatchOutService.findNumberWai();
                    Integer maxNumber = serNumber>serNumberWai ? serNumber:serNumberWai;
                    draftBatchOut.setSerNumber(maxNumber+1);
                    //设置一个中介单位，获取到当前单位的办公厅下一级单位名称
                    String strId = orgDept.getAbsCode();
                    String []strs = strId.split("/");
                    if (strs.length>=3){
                        String medId = strs[2];
                        DicDept medDept = dicDeptService.get(medId);
                        draftBatchOut.setMediUnit(medDept.getDeptName());
                    }
                }
            }

            //产生一个创建时间
            Date updateTime = new Date();
            String sendTimeStr = DateUtil.dateToString(updateTime,DateUtil.FORMAT_DAYTIME);
            Date updateTimeStr = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
            draftBatchOut.setUpdateTime(updateTimeStr);

            draftBatchOut.setTitle(title);
            draftBatchOut.setOrgName(orgName);
            draftBatchOut.setContractor(contractor);
            draftBatchOut.setDepLeader(depLeader);
            draftBatchOut.setTel(tel);
            draftBatchOut.setCounterSignFlag(counterSignFlag);
            draftBatchOut.setDelFlag("0");
            draftBatchOut.setUpdateTime(new Date());
            draftBatchOutService.save(draftBatchOut);

            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("呈批件");
            sysLogVo.setRecordType(1);
            sysLogVo.setEntityId(draftBatchOut.getId());
            sysLogVo.setEntityName(draftBatchOut.getTitle());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);

        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     *  呈批件外行文报送删除
     */
    @ResponseBody
    @RequestMapping(value = "/batch-submit-wai-delete.do", method = RequestMethod.POST)
    public Map<String, Object> batchDraftWaidelete(String id,ModelMap modelMap) {
        modelMap.addAttribute("result","wai");

        //删除数据
        Map<String, Object> map = new HashMap<>(1);
        try {
            //根据id查找值班日报信息
            DraftBatchOut draftBatchOut = submitBatchOutService.get(id);
            //删除标志设为1
            draftBatchOut.setDelFlag("1");
            //保存数据
            submitBatchOutService.save(draftBatchOut);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("呈批件");
            sysLogVo.setRecordType(2);
            sysLogVo.setEntityId(draftBatchOut.getId());
            sysLogVo.setEntityName(draftBatchOut.getTitle());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     *  呈批件外行文历史流转记录查看
     */
    @RequestMapping(value = "/batch-submit-register-wai-list", method = RequestMethod.GET)
    public String batchDraftRegisterWai(String id,ModelMap modelMap) {

        HashMap map = new HashMap(16);
        if(StringUtils.isNotEmpty(id)){
            map.put("id",id);
        }
        //查出领导的批示
        List<RegisterBatch> list =  dataExportService.RegisterSearch(map);
        modelMap.addAttribute("registerList",list);
        //查出会签意见
        List<CountersignUnit> list1 = countersignUnitService.CountersignSearch(map);
        modelMap.addAttribute("conutersignUnit",list1);

        if (StringUtils.isNotEmpty(id)){
            DraftBatchOut draftBatchOut =  submitBatchOutService.get(id);
            modelMap.addAttribute("model", draftBatchOut);
            if(null != draftBatchOut.getDicReason()){
                modelMap.addAttribute("dicReason",draftBatchOut.getDicReason());
            }
            if (draftBatchOut != null){
                String sendTimeStr = DateUtil.dateToString(draftBatchOut.getSendTime(),DateUtil.FORMAT_DAYTIME);
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

        return "pubinfo/batch/submit-batch/batch-register-wai-list";
    }

    /**
     *  呈批件外行文上报修改状态
     */
    @ResponseBody
    @RequestMapping(value = "/batch-load-wai-reporter.do", method = RequestMethod.POST)
    public Map<String, Object> batchDraftReporterWai(String id,ModelMap modelMap) {

        modelMap.addAttribute("result","wai");
        Map<String, Object> map = new HashMap<>(1);
        //编辑数据
        try {
            if (StringUtils.isNotEmpty(id)){
                DraftBatchOut draftBatchOut =  submitBatchOutService.get(id);
                draftBatchOut.setStatus("1");
                //产生一个上报时间
                Date updateTime = new Date();
                String sendTimeStr = DateUtil.dateToString(updateTime,DateUtil.FORMAT_DAYTIME);
                Date updateTimeStr = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
                draftBatchOut.setSendTime(updateTimeStr);
                draftBatchOut.setStatus("2");
                //设值流水号
                Integer serNumber = submitBatchService.findNumber();
                Integer serNumberWai = submitBatchOutService.findNumberWai();
                Integer maxNumber = serNumber>serNumberWai ? serNumber:serNumberWai;
                draftBatchOut.setSerNumber(maxNumber+1);
                submitBatchOutService.save(draftBatchOut);

                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("呈批件");
                sysLogVo.setRecordType(8);
                    sysLogVo.setEntityId(draftBatchOut.getId());
                    sysLogVo.setEntityName(draftBatchOut.getTitle());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
                map.put("result", true);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 呈批件外行文的查收
     *
     */
    @ResponseBody
    @RequestMapping(value = "/batch-submit-wai-handle.do",method = RequestMethod.POST)
    public Map<String, Object> handleBatchWai(String id,ModelMap modelMap) {

        modelMap.addAttribute("result","wai");

        Map<String, Object> map = new HashMap<>(16);

        try {
            if(StringUtils.isNotEmpty(id)){
                DraftBatchOut draftBatchOut = submitBatchOutService.get(id);
                draftBatchOut.setStatus("3");
                //产生一个更新时间
                Date sendTime = new Date();
                String sendTimeStr = DateUtil.dateToString(sendTime,DateUtil.FORMAT_DAYTIME);
                Date sendTimeSt = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
                draftBatchOut.setUpdateTime(sendTimeSt);
                submitBatchOutService.save(draftBatchOut);

                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("呈批件外行文");
                sysLogVo.setRecordType(9);
                sysLogVo.setEntityId(draftBatchOut.getId());
                sysLogVo.setEntityName(draftBatchOut.getTitle());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }

            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     *  外行文呈批件打印
     */
    @ResponseBody
    @RequestMapping(value = "/batch-submit-wai-print.do", method = RequestMethod.POST)
    public Map batchPrint(String id,HttpServletRequest request){
        Map<String, Object> map = new HashMap<>(16);

        try {
            if (StringUtils.isNotEmpty(id)){
                DraftBatchOut draftBatchOut = submitBatchOutService.get(id);
                map.put("title",draftBatchOut.getTitle());
                map.put("deptName",draftBatchOut.getOrgDept().getDeptName());
                map.put("orgName",draftBatchOut.getOrgName());
                map.put("contractor",draftBatchOut.getContractor());
                map.put("tel",draftBatchOut.getTel());
                map.put("approver",draftBatchOut.getApprover());
                map.put("Id",draftBatchOut.getId());
                map.put("result",true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("呈批件外行文");
                sysLogVo.setRecordType(10);
                sysLogVo.setEntityId(draftBatchOut.getId());
                sysLogVo.setEntityName(draftBatchOut.getTitle());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }

        }catch (Exception e){
            LOG.debug(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    @RequestMapping(value = "/batch-submit-wai-export.do", method = RequestMethod.GET)
    public String batchPrint(ModelMap modelMap, String id){

        if (StringUtils.isNotEmpty(id)){
            DraftBatchOut draftBatchOut = submitBatchOutService.get(id);
            modelMap.addAttribute("title",draftBatchOut.getTitle());
            modelMap.addAttribute("deptName",draftBatchOut.getDeptName());
            modelMap.addAttribute("orgName",draftBatchOut.getOrgName());
            modelMap.addAttribute("contractor",draftBatchOut.getContractor());
            modelMap.addAttribute("tel",draftBatchOut.getTel());
            modelMap.addAttribute("approver",draftBatchOut.getApprover());
            modelMap.addAttribute("Id",draftBatchOut.getId());
        }

        return "pubinfo/batch/submit-batch/batch-wai-preview";
    }

    /**
     * 呈批件外行文的办结
     *
     */
    @ResponseBody
    @RequestMapping(value = "/batch-submit-wai-over.do",method = RequestMethod.POST)
    public Map<String, Object> overBatchWai(String id,ModelMap modelMap) {
        modelMap.addAttribute("result","wai");

        Map<String, Object> map = new HashMap<>(16);

        try {
            if(StringUtils.isNotEmpty(id)){
                DraftBatchOut draftBatchOut = submitBatchOutService.get(id);
                draftBatchOut.setStatus("4");
                //产生一个更新时间
                Date sendTime = new Date();
                String sendTimeStr = DateUtil.dateToString(sendTime,DateUtil.FORMAT_DAYTIME);
                Date sendTimeSt = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
                draftBatchOut.setUpdateTime(sendTimeSt);
                submitBatchOutService.save(draftBatchOut);

                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("呈批件外行文");
                sysLogVo.setRecordType(11);
                sysLogVo.setEntityId(draftBatchOut.getId());
                sysLogVo.setEntityName(draftBatchOut.getTitle());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }

            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }



}
