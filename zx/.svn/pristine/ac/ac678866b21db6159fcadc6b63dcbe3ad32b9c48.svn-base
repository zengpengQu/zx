package com.taiji.frame.controller.pubinfo.supervision;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.model.entity.pubinfo.supervision.SupervisionFeedBack;
import com.taiji.frame.model.entity.pubinfo.supervision.SupervisionFeedBackFile;
import com.taiji.frame.model.entity.pubinfo.supervision.SupervisionMatter;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.supervision.SupervisionFeedBackVo;
import com.taiji.frame.service.pubinfo.supervision.SupervisionFeedBackFileService;
import com.taiji.frame.service.pubinfo.supervision.SupervisionFeedBackService;
import com.taiji.frame.service.pubinfo.supervision.SupervisionMatterService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.net.URLDecoder;
import java.util.*;

/**
 * @author qzp
 * @date 2018/08/23
 * 督查事项反馈控制器
 */
@Controller
@RequestMapping("/supervision-feedback")
public class SupervisionFeedBackController extends BaseController<SupervisionFeedBack> {

    private static final Logger LOGGER = LoggerFactory.getLogger(SupervisionFeedBackController.class);

    @Autowired
    private SupervisionFeedBackService supervisionFeedBackService;

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private SupervisionMatterService supervisionMatterService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private SupervisionFeedBackFileService supervisionFeedBackFileService;
    @Autowired
    private SysLogService sysLogService;
    /**
     * 跳转到反馈页面
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-feedback-list.do",method = RequestMethod.GET)
    public String ToFeedbackList(Map<String, Object> map, String id,String hostUnitId){

        if (StringUtils.isNotEmpty(id)) {
            SupervisionMatter supervisionMatter = supervisionMatterService.get(id);
            //根据督查事项ID和承办单位ID查找反馈信息
            SupervisionFeedBack feedBack = supervisionFeedBackService.findByHostUnitIdAndMatterId(id,hostUnitId);
            if (null == feedBack){
                feedBack = new SupervisionFeedBack();
                feedBack.setSupervisionMatter(supervisionMatter);
                feedBack.setUnit(dicDeptService.get(hostUnitId));
                feedBack.setStatus("0");
                feedBack.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(),DateUtil.FORMAT));
                feedBack.setDelFlag("0");
                supervisionFeedBackService.save(feedBack);
            }
            map.put("feedBackId", feedBack.getId());
        }
        DicDept dicDept = getCurUser().getDicDept();
        map.put("curDeptId", dicDept.getId());
        map.put("matterId", id);
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        map.put("sysDate", sysDate);


        return "pubinfo/supervision/supervision-feedback-list";
    }


    /**
     * 跳转到反馈更新页面
     * @param id
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/feedBack",method = RequestMethod.GET)
    public String feedBack(String id,String unitId,ModelMap modelMap){
        SupervisionMatter supervisionMatter = supervisionMatterService.get(id);
        SupervisionFeedBack supervisionFeedBack = supervisionFeedBackService.getByMatter(id,unitId);
        if (null != supervisionFeedBack){
            String feedBackId = supervisionFeedBack.getId();
            if (org.apache.commons.lang3.StringUtils.isNotEmpty(feedBackId)){
                SupervisionFeedBackFile supervisionFeedBackFile = supervisionFeedBackFileService.getFeedBackFile(feedBackId);
                if (null != supervisionFeedBackFile){
                    DicUploadFile dicUploadFile = supervisionFeedBackFile.getDicUploadFile();
                    if (null != dicUploadFile){
                        JSONObject jsonFileObject = new JSONObject();
                        String dicUploadFileId = dicUploadFile.getId();
                        String fileName = dicUploadFile.getFileName();
                        jsonFileObject.put("fileName", fileName);
                        jsonFileObject.put("id", dicUploadFileId);
                        modelMap.addAttribute("jsonFileObject", jsonFileObject);
                    }else {
                        modelMap.addAttribute("jsonFileObject", null);
                    }
                }
            }
        }
        modelMap.put("supervisionFeedBack",supervisionFeedBack);
        modelMap.put("supervisionMatter",supervisionMatter);
        modelMap.put("unitId",unitId);
        return "pubinfo/supervision/supervision-matter-feedback";
    }

    /**
     * 跳转到反馈更新页面
     * @param id
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/feedBack-lock.do",method = RequestMethod.GET)
    public String feedBackLock(String id,String unitId,ModelMap modelMap){
        SupervisionMatter supervisionMatter = supervisionMatterService.get(id);
        SupervisionFeedBack supervisionFeedBack = supervisionFeedBackService.getByMatter(id,unitId);
        if (null != supervisionFeedBack){
            String feedBackId = supervisionFeedBack.getId();
            if (org.apache.commons.lang3.StringUtils.isNotEmpty(feedBackId)){
                SupervisionFeedBackFile supervisionFeedBackFile = supervisionFeedBackFileService.getFeedBackFile(feedBackId);
                if (null != supervisionFeedBackFile){
                    DicUploadFile dicUploadFile = supervisionFeedBackFile.getDicUploadFile();
                    if (null != dicUploadFile){
                        JSONObject jsonFileObject = new JSONObject();
                        String dicUploadFileId = dicUploadFile.getId();
                        String fileName = dicUploadFile.getFileName();
                        jsonFileObject.put("fileName", fileName);
                        jsonFileObject.put("id", dicUploadFileId);
                        modelMap.addAttribute("jsonFileObject", jsonFileObject);
                    }else {
                        modelMap.addAttribute("jsonFileObject", null);
                    }
                }
            }
        }
        modelMap.addAttribute("supervisionFeedBack",supervisionFeedBack);
        modelMap.addAttribute("supervisionMatter",supervisionMatter);
        modelMap.addAttribute("unitId",unitId);
        return "pubinfo/supervision/supervision-matter-feedback-lock";
    }


    /**
     * 反馈的数据---表格
     * @param carrier
     * @param status
     * @param unitId
     * @param matterId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/work-feedback-list.do", produces = "text/html;charset=UTF-8")
    public String loadData(Carrier<SupervisionFeedBack>carrier,
                            String status,String unitId,String matterId){
        Map map = new HashMap(3);
        if (!StringUtils.isEmpty(matterId)) {
            map.put("matterId",matterId);
        }

        if (!StringUtils.isEmpty(unitId)) {
            map.put("unitId",unitId);
        }
        if (!StringUtils.isEmpty(status)) {
            List<String> statusList = OtherUtil.strToStringList(status);
            map.put("statusList", statusList);
        }
        try {
            supervisionFeedBackService.load(carrier,map);
        }catch (Exception e){
            LOGGER.debug(e.getMessage(),e);
        }
        String s = gridResult(carrier);
        System.out.println(s);
        return gridResult(carrier);
    }


    /**
     *
     * 保存&反馈
     * @param supervisionFeedBackVo
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/supervision-feedback-save.do",method = RequestMethod.POST)
    public Map<String,Object> feedbacked(String id, String status, SupervisionFeedBackVo supervisionFeedBackVo, HttpServletRequest request){
        String basePath = UploadConstant.uploadBaseDir;
        Map<String,Object> map = supervisionFeedBackService .saveData(id,status,supervisionFeedBackVo,basePath,getSysLogVo());
        return map;
    }



    /**
     * 删除反馈信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/work-feedback-delete.do",method = RequestMethod.POST)
    public Map<String,Object> delFeedBackInfo(String id){
        Map<String, Object> map = new HashMap<>(2);
        try {
            SupervisionFeedBack supervisionFeedBack = supervisionFeedBackService.get(id);
            supervisionFeedBack.setDelFlag("1");
            supervisionFeedBackService.save(supervisionFeedBack);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("督查事项反馈");
                sysLogVo.setRecordType(2);
                sysLogVo.setEntityId(supervisionFeedBack.getId());
                sysLogVo.setEntityName(supervisionFeedBack.getName());
            sysLogVo.setResult(map.get("result").toString());
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            LOGGER.debug(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }




    /**上报反馈信息*/
    @ResponseBody
    @RequestMapping(value = "/report-feedback.do",method = RequestMethod.POST)
    public Map<String,Object> report(String id) {

        Map<String,Object> map = new HashMap<>(1);
        //根据ID查找一周工作情况反馈信息
        try {
            SupervisionFeedBack supervisionFeedBack = supervisionFeedBackService.get(id);
            supervisionFeedBack.setStatus("1");
            supervisionFeedBackService.save(supervisionFeedBack);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("督查事项反馈上报");
            sysLogVo.setRecordType(8);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(supervisionFeedBack.getId());
            sysLogVo.setEntityName(supervisionFeedBack.getName());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result",false);
        }
        return map;
    }


    /**
     * 撤回督查事项反馈
     * */
    @ResponseBody
    @RequestMapping(value = "/back-feedback.do",method = RequestMethod.POST)
    public Map<String,Object> back(String id) {

        Map<String,Object> map = new HashMap<>(1);

        try {
            SupervisionFeedBack workFeedback = supervisionFeedBackService.get(id);
            workFeedback.setStatus("0");
            supervisionFeedBackService.save(workFeedback);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("督查事项反馈");
            sysLogVo.setRecordType(16);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(workFeedback.getId());
            sysLogVo.setEntityName(workFeedback.getName());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result",false);
        }
        return map;
    }

    /**
     * 查收督查事项反馈信息
     * @param id
     * */
    @ResponseBody
    @RequestMapping(value = "/check-work-feedback.do",method = RequestMethod.POST)
    public Map<String,Object> checkFeedback(String id) {

        Map<String,Object> map = new HashMap<>(1);

        if (!StringUtils.isEmpty(id)) {
            //根据Id查找反馈信息
            try {
                SupervisionFeedBack workFeedback = supervisionFeedBackService.get(id);
                workFeedback.setStatus("2");
                supervisionFeedBackService.save(workFeedback);
                map.put("result",true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("督查事项反馈信息");
                sysLogVo.setRecordType(9);
                sysLogVo.setResult("true");
                sysLogVo.setEntityId(workFeedback.getId());
                sysLogVo.setEntityName(workFeedback.getName());
                sysLogService.record(sysLogVo);
            } catch (Exception e) {
                e.printStackTrace();
                map.put("result",false);
            }
        }
        return map;
    }




    /**
     * 导出督查事项反馈信息汇总
     */
    @RequestMapping(value = "/export-excel.do",method = RequestMethod.GET)
    public String exportExcel(ModelMap modelMap, String matterId,String feedBackId){
        try {
            if (StringUtils.isNotEmpty(matterId)){
                SupervisionMatter supervisionMatter = supervisionMatterService.get(matterId);

                SupervisionFeedBack supervisionFeedBack = supervisionFeedBackService.get(feedBackId);
                Date feedBackDate = supervisionFeedBack.getFeedBackDate();
                String date = DateUtil.dateToString(feedBackDate, DateUtil.FORMAT_DAY_CN);
                modelMap.addAttribute("feedBackDate",date);
                modelMap.addAttribute("supervisionFeedBack",supervisionFeedBack);
                modelMap.addAttribute("supervisionMatter",supervisionMatter);
            }
        } catch (Exception e) {
            LOGGER.debug(e.getMessage(),e);
        }
        return "pubinfo/supervision/supervision-feedback-preview";
    }
    /**
     * 导出督查事项交办单
     */
    @RequestMapping(value = "/export-excel-com.do",method = RequestMethod.GET)
    public String exportExcelCom(ModelMap modelMap,String deptName,String hostDeptName,
                                 String supMatter,String serialNumber,String requirements){
        try {
            modelMap.put("deptName", URLDecoder.decode(deptName, "UTF-8"));
            modelMap.put("hostDeptName",URLDecoder.decode(hostDeptName, "UTF-8"));
            modelMap.put("supMatter",URLDecoder.decode(supMatter, "UTF-8"));
            modelMap.put("serialNumber",URLDecoder.decode(serialNumber, "UTF-8"));
            modelMap.put("requirements",URLDecoder.decode(requirements, "UTF-8"));
            String date = DateUtil.dateToString(getCurDate(), DateUtil.FORMAT_DAY_CN);
            modelMap.addAttribute("dateCom",date);
        } catch (Exception e) {
            LOGGER.debug(e.getMessage(),e);
        }
        return "pubinfo/supervision/supervision-assignment-preview";
    }

}
