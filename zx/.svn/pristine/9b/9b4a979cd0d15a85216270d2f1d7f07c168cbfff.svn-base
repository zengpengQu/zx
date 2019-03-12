package com.taiji.frame.controller.pubinfo.batch;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.ListSortUtil;
import com.taiji.frame.common.util.StringUtil;
import com.taiji.frame.controller.inspection.place.PlaceController;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.pubinfo.batch.*;
import com.taiji.frame.model.entity.pubinfo.schedule.DutyDaily;
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
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.util.*;

/**
 * @author admin
 * 呈批件报送
 */
@Controller
@RequestMapping(value = "/submit-batch")
public class SubmitBatchController extends BaseController<DraftBatch> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private SubmitBatchService submitBatchService;
    @Autowired
    private SubmitBatchOutService submitBatchOutService;
    @Autowired
    private DicDeptService dicDeptService;
    @Autowired
    private DraftBatchService draftBatchService;
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
     * id 孙毅添加 前台页面传入的数据
     */
    @RequestMapping(value = "/batch-submit-list", method = RequestMethod.GET)
    public String batchDraftAdd(ModelMap modelMap,String id,Map<String, Object> map) {

        modelMap.addAttribute("result","nei");
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

        //孙毅添加
        modelMap.addAttribute("indexMainBachId",id);
        return "pubinfo/batch/submit-batch/batch-submit-list";
    }

    /**
     * 呈批件报送页面集合
     * indexMainBachIdNei：孙毅添加，主页内行文 点击时的ID
     */
    @ResponseBody
    @RequestMapping(value = "/load-batch-submit-list.do", produces = "text/html;charset=UTF-8")
    public String batchSubmitList(ModelMap modelMap,Carrier<DraftBatch> carrier, DraftBatchVo draftBatchVo,String indexMainBachIdNei,String statuss) {

        modelMap.addAttribute("result","nei");

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
            if(!org.apache.commons.lang.StringUtils.isEmpty(draftBatchVo.getDeptId())){
                map.put("deptId", draftBatchVo.getDeptId());
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(statuss)){
                map.put("statuss", statuss);
            }
            //暂时已作废
            if(!org.apache.commons.lang.StringUtils.isEmpty(draftBatchVo.getReporter())){
                map.put("reporter", draftBatchVo.getReporter());
            }
            //孙毅添加
            if(StringUtils.isNotEmpty(indexMainBachIdNei)){
                map.put("indexMainBachIdNei", indexMainBachIdNei);
            }
            submitBatchService.load(carrier,map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }



    /**
     *  内行文呈批件报送编辑
     */
    @RequestMapping(value = "/batch-submit-edit", method = RequestMethod.GET)
    public String batchDraftEdit(String id,ModelMap modelMap) {

        //补录理由
        List<DicReason> dicReasonList = dicReasonService.getAllByStatus(1);
        modelMap.addAttribute("dicReasonList", dicReasonList);
        //编辑数据
        if (StringUtils.isNotEmpty(id)){
            DraftBatch draftBatch =  submitBatchService.get(id);
            modelMap.addAttribute("model", draftBatch);

            //编辑数据时如果是补录的让补录的div显示出来
            if(null != draftBatch.getDicReason()){
                modelMap.addAttribute("showReason",1);
            }
        }

        return "pubinfo/batch/submit-batch/batch-submit-add";
    }

    /**
     *  内行文呈批件报送补录
     */
    @RequestMapping(value = "/batch-submit-record", method = RequestMethod.GET)
    public String batchDraftRecord(String id,ModelMap modelMap) {
        //补录理由
        List<DicReason> dicReasonList = dicReasonService.getAllByStatus(1);
        modelMap.addAttribute("dicReasonList", dicReasonList);
        //让前台页面的补录理由div显示出来
        modelMap.addAttribute("showStatus",1);
        //核稿人的数据获取封装,获取当前用户,暂时作废
        DicUser currentUser = getCurUser();
        modelMap.addAttribute("currentUsers",currentUser);
        //获取当前登录用户的部门
        DicDept curDept = currentUser.getDicDept();
        modelMap.addAttribute("curDept", curDept);
        //让前台页面的核稿人div显示出来
        modelMap.addAttribute("checkStatus",1);
        //向model中添加拟稿人和部门的信息
        DraftBatch draftBatch = new DraftBatch();
        draftBatch.setOrgName(currentUser.getDicDept().getDeptName());
        draftBatch.setReporter(currentUser.getEmpName());
        //DicDept dicDept = draftBatch.getDicDept();
        //modelMap.addAttribute("dicDept",dicDept.getDeptName());
        modelMap.addAttribute("model",draftBatch);

        return "pubinfo/batch/submit-batch/batch-submit-add";
    }

    /**
     *  内行文呈批件核稿
     */
    @RequestMapping(value = "/batch-submit-check", method = RequestMethod.GET)
    public String batchDraftCheck(String id,ModelMap modelMap) {

        //补录理由
        List<DicReason> dicReasonList = dicReasonService.getAllByStatus(1);
        modelMap.addAttribute("dicReasonList", dicReasonList);
        //编辑数据
        if (StringUtils.isNotEmpty(id)){
            DraftBatch draftBatch =  submitBatchService.get(id);
            modelMap.addAttribute("model", draftBatch);

            //核稿时如果是补录的呈批件让补录理由div显示出来
            if(null != draftBatch.getDicReason()){
                modelMap.addAttribute("showReason",1);
            }
        }
        //核稿人的数据获取封装,获取当前用户,暂时作废
        /*DicUser currentUser = getCurUser();
        modelMap.addAttribute("currentUsers",currentUser);*/
        //让前台页面的核稿人div显示出来
        modelMap.addAttribute("checkStatus",1);

        return "pubinfo/batch/submit-batch/batch-submit-add";
    }

    /**
     * 呈批件的内行文的编辑,核稿，和补录信息的保存
     */
    @ResponseBody
    @RequestMapping(value = "/batch-submit-save.do", method = RequestMethod.POST)
    public Map batchDraftSave(ModelMap modelMap,DraftBatchVo draftBatchVo) {
        modelMap.addAttribute("result","nei");
        Map<String, Object> map = new HashMap<>(16);

        try {
            //判断是新增还是编辑
            DraftBatch draftBatch;
            if(StringUtils.isEmpty(draftBatchVo.getId())){
                draftBatch  = new DraftBatch();
            }else {
                draftBatch = draftBatchService.get(draftBatchVo.getId());
            }

            //标题
            String title = draftBatchVo.getTitle();
            //部门，暂时作废
            //String orgName = draftBatchVo.getOrgName();
            //存储部门Id
            String deptId = draftBatchVo.getDeptId();
            DicDept dicDept = dicDeptService.get(deptId);
            draftBatch.setDicDept(dicDept);
            //部门领导
            String depLeader = draftBatchVo.getDepLeader();
            //拟稿人
            String reporter = draftBatchVo.getReporter();
            //联系电话
            String tel = draftBatchVo.getTel();
            //是否会签（0否1是）s
            String counterSignFlag = draftBatchVo.getCounterSignFlag();
            //会签单位
            /*List<DicDeptVo> dicDeptVoList = draftBatchVo.getDicDeptVoList();
            if (null != dicDeptVoList && dicDeptVoList.size()>0){
                String deptId = dicDeptVoList.get(0).getDeptId();
                if (StringUtils.isNotEmpty(deptId)){
                    DicDept dicDept =  dicDeptService.get(deptId);
                    draftBatch.setCounterSignUnit(dicDept.getDeptName());
                    draftBatch.setDicDept(dicDept);
                }
            }*/
            //存储会签单位，会签单位可以存储多个
            String counterSignUnit = draftBatchVo.getCounterSignUnit();
            draftBatch.setCounterSignUnit(counterSignUnit);

            //如果时编辑时status设值成0，补录或者核稿时status设值成1
            draftBatch.setStatus("0");

            //核稿人
            if(StringUtils.isNotEmpty(draftBatchVo.getChecker())){
                String checker = draftBatchVo.getChecker();
                draftBatch.setChecker(checker);
                draftBatch.setStatus("1");
            }

            //补录理由
            List<DicReasonVo> dicReasonVoList =draftBatchVo.getDicReasonVoList();
            if(null != dicReasonVoList && dicReasonVoList.size()>0){
                String reasonId = dicReasonVoList.get(0).getReasonId();
                if(StringUtils.isNotEmpty(reasonId)){
                    DicReason dicReason = dicReasonService.get(reasonId);
                    draftBatch.setDicReason(dicReason);
                    draftBatch.setStatus("3");
                    //产生一个时间
                    Date sendTime = new Date();
                    String sendTimeStr = DateUtil.dateToString(sendTime,DateUtil.FORMAT_DAYTIME);
                    Date sendTimeSt = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
                    draftBatch.setSendTime(sendTimeSt);
                    //设值流水号
                    Integer serNumber = submitBatchService.findNumber();
                    Integer serNumberWai = submitBatchOutService.findNumberWai();
                    Integer maxNumber = serNumber>serNumberWai ? serNumber:serNumberWai;
                    draftBatch.setSerNumber(maxNumber+1);
                    //设置一个中介单位，获取到当前单位的办公厅下一级单位名称
                    String strId = dicDept.getAbsCode();
                    String []strs = strId.split("/");
                    if (strs.length>=3){
                        String medId = strs[2];
                        DicDept medDept = dicDeptService.get(medId);
                        draftBatch.setMediUnit(medDept.getDeptName());
                    }
                }
            }

            //产生一个创建时间
            Date updateTime = new Date();
            String sendTimeStr = DateUtil.dateToString(updateTime,DateUtil.FORMAT_DAYTIME);
            Date updateTimeStr = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
            draftBatch.setUpdateTime(updateTimeStr);

            draftBatch.setTitle(title);
            //draftBatch.setOrgName(orgName);
            draftBatch.setDepLeader(depLeader);
            draftBatch.setReporter(reporter);
            draftBatch.setTel(tel);
            draftBatch.setCounterSignFlag(counterSignFlag);
            draftBatch.setDelFlag("0");
            //draftBatch.setStatus("0");
            draftBatchService.save(draftBatch);
            map.put("result", true);


            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("呈批件");
            if (StringUtils.isNotEmpty(draftBatchVo.getId())){
                sysLogVo.setRecordType(1);
            }else {
                sysLogVo.setRecordType(0);
            }
            if (null != draftBatch){
                sysLogVo.setEntityId(draftBatch.getId());
                sysLogVo.setEntityName(draftBatch.getTitle());
            }
            sysLogVo.setResult(map.get("result").toString());
            sysLogService.record(sysLogVo);

        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     *  呈批件文报送没行文删除
     */
    @ResponseBody
    @RequestMapping(value = "/batch-submit-delete.do", method = RequestMethod.POST)
    public Map<String, Object> batchDraftdelete(ModelMap modelMap,String id) {

        modelMap.addAttribute("result","nei");

        //删除数据
        Map<String, Object> map = new HashMap<>(1);
        try {
            //根据id查找呈批件信息
            DraftBatch draftBatch = submitBatchService.get(id);
            //删除标志设为1
            draftBatch.setDelFlag("1");
            //保存数据
            submitBatchService.save(draftBatch);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("呈批件");
            sysLogVo.setRecordType(2);
                sysLogVo.setEntityId(draftBatch.getId());
                sysLogVo.setEntityName(draftBatch.getTitle());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


    /**
     *  呈批件历史流转记录查看
     */
    @RequestMapping(value = "/batch-submit-register-list", method = RequestMethod.GET)
    public String batchDraftRegister(String id,ModelMap modelMap) {
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
       if(StringUtils.isNotEmpty(id)){
           DraftBatch draftBatch = submitBatchService.get(id);
           modelMap.addAttribute("model",draftBatch);
           if(null != draftBatch.getDicReason()){
               modelMap.addAttribute("dicReason" , draftBatch.getDicReason());
           }
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

        return "pubinfo/batch/submit-batch/batch-register-list";
    }

    /**
     *  呈批件上报以及修改状态
     */
    @ResponseBody
    @RequestMapping(value = "/batch-load-reporter.do", method = RequestMethod.POST)
    public Map<String, Object> batchDraftReporter(ModelMap modelMap,String id) {

        modelMap.addAttribute("result","nei");
        Map<String, Object> map = new HashMap<>(1);
        //编辑数据
        try {
            if (StringUtils.isNotEmpty(id)){
               DraftBatch draftBatch =  submitBatchService.get(id);
                //draftBatch.setStatus("1");
                //产生一个上报时间
                Date updateTime = new Date();
                String sendTimeStr = DateUtil.dateToString(updateTime,DateUtil.FORMAT_DAYTIME);
                Date updateTimeStr = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
                draftBatch.setSendTime(updateTimeStr);
                draftBatch.setStatus("2");
                //设值流水号
                Integer serNumber = submitBatchService.findNumber();
                Integer serNumberWai = submitBatchOutService.findNumberWai();
                Integer maxNumber = serNumber>serNumberWai ? serNumber:serNumberWai;
                draftBatch.setSerNumber(maxNumber+1);
                submitBatchService.save(draftBatch);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("呈批件");
            sysLogVo.setRecordType(8);
                sysLogVo.setEntityId(draftBatch.getId());
                sysLogVo.setEntityName(draftBatch.getTitle());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);

            }

        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 呈批件内行文的查收
     *
     */
    @ResponseBody
    @RequestMapping(value = "/batch-submit-handle.do",method = RequestMethod.POST)
    public Map<String, Object> handleBatch(ModelMap modelMap,String id) {

        modelMap.addAttribute("result","nei");

        Map<String, Object> map = new HashMap<>(16);

        try {
            if(StringUtils.isNotEmpty(id)){
                DraftBatch draftBatch = submitBatchService.get(id);
                draftBatch.setStatus("3");
                //产生一个更新时间
                Date sendTime = new Date();
                String sendTimeStr = DateUtil.dateToString(sendTime,DateUtil.FORMAT_DAYTIME);
                Date sendTimeSt = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
                draftBatch.setUpdateTime(sendTimeSt);
                submitBatchService.save(draftBatch);
                map.put("result", true);

                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("呈批件");
                sysLogVo.setRecordType(9);
                    sysLogVo.setEntityId(draftBatch.getId());
                    sysLogVo.setEntityName(draftBatch.getTitle());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }

        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     *  内行文呈批件打印
     */
    @ResponseBody
    @RequestMapping(value = "/batch-submit-print.do", method = RequestMethod.POST)
    public Map batchPrint(String id,HttpServletRequest request){
        Map<String, Object> map = new HashMap<>(16);

        try {
            if (StringUtils.isNotEmpty(id)){
                DraftBatch draftBatch = submitBatchService.get(id);
                map.put("title",draftBatch.getTitle());
                map.put("orgName",draftBatch.getDicDept().getDeptName());
                map.put("reporter",draftBatch.getReporter());
                map.put("tel",draftBatch.getTel());
                map.put("checker",draftBatch.getChecker());
                map.put("Id",draftBatch.getId());
                map.put("result",true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("呈批件");
                sysLogVo.setRecordType(10);
                    sysLogVo.setEntityId(draftBatch.getId());
                    sysLogVo.setEntityName(draftBatch.getTitle());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }

        }catch (Exception e){
            LOG.debug(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 导出内行文
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/batch-submit-export.do", method = RequestMethod.GET)
    public String batchPrint(ModelMap modelMap, String id){

        if (StringUtils.isNotEmpty(id)){
            DraftBatch draftBatch = submitBatchService.get(id);
            modelMap.addAttribute("title",draftBatch.getTitle());
            modelMap.addAttribute("orgName",
                    null == draftBatch.getDicDept() ? "" : draftBatch.getDicDept().getDeptName());
            modelMap.addAttribute("reporter",draftBatch.getReporter());
            modelMap.addAttribute("tel",draftBatch.getTel());
            modelMap.addAttribute("checker",draftBatch.getChecker());
            modelMap.addAttribute("Id",draftBatch.getId());
        }

        return "pubinfo/batch/submit-batch/batch-nei-preview";
    }

    /**
     * 呈批件内行文的办结
     *
     */
    @ResponseBody
    @RequestMapping(value = "/batch-submit-over.do",method = RequestMethod.POST)
    public Map<String, Object> overBatch(ModelMap modelMap,String id) {

        modelMap.addAttribute("result","nei");

        Map<String, Object> map = new HashMap<>(16);

        try {
            if(StringUtils.isNotEmpty(id)){
                DraftBatch draftBatch = submitBatchService.get(id);
                draftBatch.setStatus("4");
                //产生一个更新时间
                Date sendTime = new Date();
                String sendTimeStr = DateUtil.dateToString(sendTime,DateUtil.FORMAT_DAYTIME);
                Date sendTimeSt = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
                draftBatch.setUpdateTime(sendTimeSt);
                submitBatchService.save(draftBatch);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("呈批件");
                sysLogVo.setRecordType(11);
                    sysLogVo.setEntityId(draftBatch.getId());
                    sysLogVo.setEntityName(draftBatch.getTitle());
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
