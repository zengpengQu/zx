package com.taiji.frame.controller.pubinfo.batch;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.StringUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.pubinfo.batch.DicDuty;
import com.taiji.frame.model.entity.pubinfo.batch.DicReason;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatch;
import com.taiji.frame.model.entity.pubinfo.batch.LeaderManage;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.batch.*;
import com.taiji.frame.service.pubinfo.batch.*;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
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

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author wsh
 * @date 2018-09-06
 * 呈批件的领导管理
 */
@Controller
@RequestMapping(value = "/manage-batch")
public class LeaderManageBatchController extends BaseController{
    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private LeaderManageService leaderManageService;
    @Autowired
    private DraftDutyService draftDutyService;
    @Autowired
    private SysLogService sysLogService;
    /**
     * 页面跳转
     */
    @RequestMapping(value = "/batch-leader-manage-list", method = RequestMethod.GET)
    public String batchManage(ModelMap modelMap, String id) {
        return "pubinfo/batch/manage-batch/batch-leader-manage-list";
    }

    /**
     * 新增领导页面跳转
     */
    @RequestMapping(value = "/batch-leader-add", method = RequestMethod.GET)
    public String batchAddLeader(ModelMap modelMap, String id) {
        List<DicDuty> dutyList = draftDutyService.getAllDuty();
        modelMap.addAttribute("dutyList",dutyList);

        return "pubinfo/batch/manage-batch/batch-leader-add";
    }

    /**
     * 领导信息列表页面集合
     */
    @ResponseBody
    @RequestMapping(value = "/load-batch-manage-list.do", produces = "text/html;charset=UTF-8")
    public String batchLeaderList(Carrier<LeaderManage> carrier, LeaderManageVo leaderManageVo) {

        HashMap map = new HashMap(16);
        try {
            String leaName = leaderManageVo.getLeaName();
            String tel = leaderManageVo.getTel();
            if(!org.apache.commons.lang.StringUtils.isEmpty(leaName)){
                map.put("leaName",leaName);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(tel)){
                map.put("tel",tel);
            }

            leaderManageService.load(carrier,map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     *  领导信息新增或者编辑的保存功能
     */
    @ResponseBody
    @RequestMapping(value = "/batch-leader-save.do", method = RequestMethod.POST)
    public Map batchDraftSave(LeaderManageVo leaderManageVo) {
        Map<String, Object> map = new HashMap<>(16);

        try {
            //判断是新增还是编辑
            LeaderManage leaderManage;
            if(StringUtils.isEmpty(leaderManageVo.getId())){
                leaderManage  = new LeaderManage();
                //设置一个排序字段
                Integer seq = leaderManageService.findSeq();
                leaderManage.setSeq(seq+1);
            }else {
                leaderManage = leaderManageService.get(leaderManageVo.getId());
            }
            //领导姓名
            String leaName = leaderManageVo.getLeaName();
            //领导职务
            List<DicDutyVo> dicDutyVoList = leaderManageVo.getDicDutyVoList();
            if (null != dicDutyVoList && dicDutyVoList.size()>0){
                String dutyId = dicDutyVoList.get(0).getDutyId();
                if (StringUtils.isNotEmpty(dutyId)){
                    //设值职务编号名称
                    DicDuty dicDuty =  draftDutyService.get(dutyId);
                    leaderManage.setDuName(dicDuty.getDutyName());
                    leaderManage.setDicDuty(dicDuty);
                    //设值排序字段,暂时废除
                    //leaderManage.setSort(dicDuty.getSeq());
                }
            }
            //性别
            String sex = leaderManageVo.getSex();
            //出生日期
            String birth = leaderManageVo.getBirth();
            Date birthday = DateUtil.stringToDate(birth,DateUtil.FORMAT_DAY);
            //秘书
            String secretart = leaderManageVo.getSecretart();
            //手机号码
            String phone = leaderManageVo.getPhone();
            //办公电话
            String tel = leaderManageVo.getTel();

            leaderManage.setLeaName(leaName);
            leaderManage.setSex(sex);
            leaderManage.setBirthday(birthday);
            leaderManage.setSecretart(secretart);
            leaderManage.setPhone(phone);
            leaderManage.setTel(tel);
            leaderManage.setDelFlag("0");

            leaderManageService.save(leaderManage);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("领导信息");
            if(StringUtils.isNotEmpty(leaderManageVo.getId())){
                sysLogVo.setRecordType(1);
            }else {
                sysLogVo.setRecordType(0);
            }
            sysLogVo.setEntityId(leaderManage.getId());
            sysLogVo.setEntityName(leaderManage.getLeaName());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;


    }

    /**
     *  领导信息的编辑
     */
    @RequestMapping(value = "/batch-leader-edit.do", method = RequestMethod.GET)
    public String batchDraftEdit(String id,ModelMap modelMap) {
        //职务的数据
        List<DicDuty>dutyList = draftDutyService.getAllDuty();
        modelMap.addAttribute("dutyList" ,dutyList);
        //编辑数据
        if(StringUtils.isNotEmpty(id)){
            LeaderManage leaderManage = leaderManageService.get(id);
            modelMap.addAttribute("model",leaderManage);
        }

        return "pubinfo/batch/manage-batch/batch-leader-add";
    }

    @ResponseBody
    @RequestMapping(value = "/moveUp.do",method = RequestMethod.POST)
    public Map moveUp(String id){
        Map<String,Object> map = new HashMap<String, Object>();
        try{
            if(!org.apache.commons.lang.StringUtils.isEmpty(id)){
                LeaderManage leaderManage = leaderManageService.get(id);
                Integer seq = leaderManage.getSeq();
                if (seq != 1){
                    LeaderManage leaderManage1 = leaderManageService.getBySeq(seq-1);
                    leaderManage.setSeq(leaderManage.getSeq()-1);
                    leaderManage1.setSeq(leaderManage1.getSeq()+1);
                    leaderManageService.save(leaderManage);
                    leaderManageService.save(leaderManage1);
                    map.put("result", true);
                    SysLogVo sysLogVo = getSysLogVo();
                    sysLogVo.setTypeName("领导信息上移");
                    sysLogVo.setRecordType(13);
                    sysLogVo.setEntityId(leaderManage.getId());
                    sysLogVo.setEntityName(leaderManage.getLeaName());
                    sysLogVo.setResult("true");
                    sysLogService.record(sysLogVo);

                }
            }
        }catch (Exception e){
            map.put("result", false);
        }
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/moveDown.do",method = RequestMethod.POST)
    public Map moveDown(String id){
        Map<String,Object> map = new HashMap<String, Object>();
        try{
            if(!org.apache.commons.lang.StringUtils.isEmpty(id)){
                LeaderManage leaderManage = leaderManageService.get(id);
                Integer seq = leaderManage.getSeq();
                LeaderManage leaderManage1 = leaderManageService.getBySeq(seq+1);
                if (null != leaderManage1){
                    leaderManage.setSeq(leaderManage.getSeq()+1);
                    leaderManage1.setSeq(leaderManage1.getSeq()-1);
                    leaderManageService.save(leaderManage);
                    leaderManageService.save(leaderManage1);
                    map.put("result", true);
                    SysLogVo sysLogVo = getSysLogVo();
                    sysLogVo.setTypeName("领导信息下移");
                    sysLogVo.setRecordType(13);
                    sysLogVo.setEntityId(leaderManage.getId());
                    sysLogVo.setEntityName(leaderManage.getLeaName());
                    sysLogVo.setResult("true");
                    sysLogService.record(sysLogVo);
                }
            }
        }catch (Exception e){
            map.put("result", false);
        }
        return map;
    }

    /**
     *  领导信息删除
     */
    @ResponseBody
    @RequestMapping(value = "/batch-leader-delete.do", method = RequestMethod.POST)
    public Map<String, Object> batchLeaderDelete(String id) {

        //删除数据
        Map<String, Object> map = new HashMap<>(1);
        try {
            //根据id查找领导信息
            LeaderManage leaderManage = leaderManageService.get(id);
            //删除标志设为1
            leaderManage.setDelFlag("1");
            //保存数据
            leaderManageService.save(leaderManage);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("领导信息");
            sysLogVo.setRecordType(2);
            sysLogVo.setEntityId(leaderManage.getId());
            sysLogVo.setEntityName(leaderManage.getLeaName());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }
}
