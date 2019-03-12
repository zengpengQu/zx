package com.taiji.frame.controller.pubinfo.batch;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.ImportExcelEnum;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.pubinfo.batch.DicReason;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatch;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatchOut;
import com.taiji.frame.model.entity.pubinfo.schedule.DutyDaily;
import com.taiji.frame.model.entity.pubinfo.schedule.Section;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.batch.DicDeptVo;
import com.taiji.frame.model.vo.pubinfo.batch.DicReasonVo;
import com.taiji.frame.model.vo.pubinfo.batch.DraftBatchOutVo;
import com.taiji.frame.model.vo.pubinfo.batch.DraftBatchVo;
import com.taiji.frame.model.vo.pubinfo.schedule.DutyDailyVo;
import com.taiji.frame.model.vo.pubinfo.schedule.SectionVo;
import com.taiji.frame.service.pubinfo.batch.DicReasonService;
import com.taiji.frame.service.pubinfo.batch.DraftBatchOutService;
import com.taiji.frame.service.pubinfo.batch.DraftBatchService;
import com.taiji.frame.service.pubinfo.schedule.DutyDailyService;
import com.taiji.frame.service.pubinfo.schedule.SectionService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * @author admin
 * 呈批件起草
 */
@Controller
@RequestMapping(value = "/draft-batch")
public class DraftBatchController extends BaseController<DraftBatch> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private DraftBatchService draftBatchService;
    @Autowired
    private DicDeptService dicDeptService;
    @Autowired
    private DraftBatchOutService draftBatchOutService;
    @Autowired
    private DicReasonService dicReasonService;
    @Autowired
    private UtilService utilService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 新增页面跳转
     */
    @RequestMapping(value = "/batch-drafting-edit", method = RequestMethod.GET)
    public String batchDraftEdit(ModelMap modelMap,String id) {

        //当前用户所在部门
        DicUser user = getCurUser();
        DicDept curDept = user.getDicDept();
        modelMap.addAttribute("curDept", curDept);

        DraftBatch draftBatch  = null;
        DraftBatchOut draftBatchOut = null;
        if (StringUtils.isNotEmpty(id)){
            draftBatch = draftBatchService.get(id);
        }
        if (StringUtils.isNotEmpty(id)){
            draftBatchOut = draftBatchOutService.get(id);
        }

        //补录理由
        List<DicReason> dicReasonList = dicReasonService.getAllByStatus(1);
//        modelMap.addAttribute("deptList", deptList);
        modelMap.addAttribute("dicReasonList", dicReasonList);
        modelMap.addAttribute("model",draftBatch);
        modelMap.addAttribute("draftBatchOut",draftBatchOut);
        return "pubinfo/batch/draft-batch/batch-drafting-edit";
    }

    /**
     * 内行文起草保存
     */
    @ResponseBody
    @RequestMapping(value = "/batch-drafting-save.do", method = RequestMethod.POST)
    public Map<String,Object> batchDraftSave(DraftBatchVo draftBatchVo,ModelMap modelMap) {

        modelMap.addAttribute("result","nei");

        Map<String, Object> map = new HashMap<>(16);

        try {
            DraftBatch draftBatch  = new DraftBatch();
            //标题
            String title = draftBatchVo.getTitle();
            //部门，暂时作废，改用部门的Id
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
            //会签单位,改为存储部门的单位Id
           /* List<DicDeptVo> dicDeptVoList = draftBatchVo.getDicDeptVoList();
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

            //产生一个创建时间
            Date updateTime = new Date();
            String sendTimeStr = DateUtil.dateToString(updateTime,DateUtil.FORMAT_DAYTIME);
            Date updateTimeStr = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
            draftBatch.setUpdateTime(updateTimeStr);

            //设置一个中介单位，获取到当前单位的办公厅下一级单位名称
            String strId = dicDept.getAbsCode();
            String []strs = strId.split("/");
            if (strs.length>=3){
                String medId = strs[2];
                DicDept medDept = dicDeptService.get(medId);
                draftBatch.setMediUnit(medDept.getDeptName());
            }

            draftBatch.setTitle(title);
            //draftBatch.setOrgName(orgName);
            draftBatch.setDepLeader(depLeader);
            draftBatch.setReporter(reporter);
            draftBatch.setTel(tel);
            draftBatch.setCounterSignFlag(counterSignFlag);
            draftBatch.setDelFlag("0");
            draftBatch.setStatus("0");
            draftBatchService.save(draftBatch);
            map.put("result", true);


            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("呈批件内行文起草");
            if (StringUtils.isNotEmpty(draftBatchVo.getId())){
                sysLogVo.setRecordType(1);
            }else {
                sysLogVo.setRecordType(0);
            }
                sysLogVo.setEntityId(draftBatch.getId());
                sysLogVo.setEntityName(draftBatch.getTitle());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 新增页面word模板跳转
     */
    @RequestMapping(value = "/batch-drafting-words", method = RequestMethod.GET)
    public String batchDraftWord(ModelMap modelMap) {
        Date sysDate = utilService.getSysTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(sysDate);
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);

        modelMap.addAttribute("year", year);
        modelMap.addAttribute("month", month);
        modelMap.addAttribute("day", day);
        modelMap.addAttribute("sysDate", sysDate);

        return "pubinfo/batch/draft-batch/batch-drafting-word";
    }

    /**
     * 外行文起草保存功能
     */
    @ResponseBody
    @RequestMapping(value = "/batch-drafting-wai-save.do", method = RequestMethod.POST)
    public Map batchDraftWaiSave(DraftBatchOutVo draftBatchOutVo,ModelMap modelMap) {

        modelMap.addAttribute("result","wai");

        Map<String, Object> map = new HashMap<>(16);

        try {
            DraftBatchOut draftBatchOut = new DraftBatchOut();

            //标题
            String title = draftBatchOutVo.getTitle();
            //来文单位
            String orgName = draftBatchOutVo.getOrgName();
            //承办单位,暂时废除使用ID存储
            /*List<DicDeptVo> underUnitOutVoList = draftBatchOutVo.getUnderUnitOutVoList();
            if (null != underUnitOutVoList && underUnitOutVoList.size()>0){
                String deptId = underUnitOutVoList.get(0).getDeptId();
                if (StringUtils.isNotEmpty(deptId)){
                    DicDept dicDept =  dicDeptService.get(deptId);
                    draftBatchOut.setDeptName(dicDept.getDeptName());
                    draftBatchOut.setOrgDept(dicDept);
                }
            }*/
            //存储承办方单位
            String orgId = draftBatchOutVo.getOrgId();
            DicDept orgDept = dicDeptService.get(orgId);
            draftBatchOut.setOrgDept(orgDept);
            //承办人
            String contractor = draftBatchOutVo.getContractor();
            //承办部门领导
            String depLeader = draftBatchOutVo.getDepLeader();
            //联系电话
            String tel = draftBatchOutVo.getTel();
            //是否会签（0否1是）
            String counterSignFlag = draftBatchOutVo.getCounterSignFlag();
            //会签单位，改为input框
            /*List<DicDeptVo> dicDeptSignVoList = draftBatchOutVo.getDicDeptOutVoList();
            if (null != dicDeptSignVoList && dicDeptSignVoList.size()>0){
                String deptId = dicDeptSignVoList.get(0).getDeptId();
                if (StringUtils.isNotEmpty(deptId)){
                    DicDept dicDept =  dicDeptService.get(deptId);
                    draftBatchOut.setCounterSignUnit(dicDept.getDeptName());
                    draftBatchOut.setDicDept(dicDept);
                }
            }*/
            //会签单位的存储
            String counterSignUnit = draftBatchOutVo.getCounterSignUnit();
            draftBatchOut.setCounterSignUnit(counterSignUnit);
            //补录理由
            List<DicReasonVo> reason =  draftBatchOutVo.getDicReasonVoOutList();
            if(null != reason && reason.size() > 0){
                String re = reason.get(0).getReasonId();
                DicReason dicReason = dicReasonService.get(re);
                draftBatchOut.setDicReason(dicReason);
            }

            //收文时间
            //String receivDateStr = draftBatchOutVo.getReceivDateStr();
            //Date receivDate = DateUtil.stringToDate(receivDateStr, DateUtil.FORMAT_DAY);

            //产生一个创建时间
            Date updateTime = new Date();
            String sendTimeStr = DateUtil.dateToString(updateTime,DateUtil.FORMAT_DAYTIME);
            Date updateTimeStr = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT_DAYTIME);
            draftBatchOut.setUpdateTime(updateTimeStr);

            //设置一个中介单位，获取到当前单位的办公厅下一级单位名称
            String strId = orgDept.getAbsCode();
            String []strs = strId.split("/");
            if (strs.length>=3){
                String medId = strs[2];
                DicDept medDept = dicDeptService.get(medId);
                draftBatchOut.setMediUnit(medDept.getDeptName());
            }

            draftBatchOut.setTitle(title);
            draftBatchOut.setOrgName(orgName);
            draftBatchOut.setContractor(contractor);
            draftBatchOut.setDepLeader(depLeader);
            draftBatchOut.setTel(tel);
            draftBatchOut.setCounterSignFlag(counterSignFlag);
            draftBatchOut.setStatus("0");
            draftBatchOut.setDelFlag("0");
            draftBatchOut.setUpdateTime(new Date());
            draftBatchOutService.save(draftBatchOut);

            draftBatchOut.setTel(tel);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("呈批件外行文起草");
            if (StringUtils.isNotEmpty(draftBatchOutVo.getId())){
                sysLogVo.setRecordType(1);
            }else {
                sysLogVo.setRecordType(0);
            }
                sysLogVo.setEntityId(draftBatchOut.getId());
                sysLogVo.setEntityName(draftBatchOut.getTitle());
            sysLogVo.setResult(map.get("result").toString());
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }
}
