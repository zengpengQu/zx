package com.taiji.frame.controller.pubinfo.supervision;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.model.entity.pubinfo.supervision.SupervisionMatter;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.supervision.SupervisionMatterVo;
import com.taiji.frame.service.pubinfo.supervision.SupervisionMatterService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qzp
 * @date 2018/08/23
 * 督查事项控制器
 */
@Controller
@RequestMapping("/supervision-matter")
public class SupervisionMatterController extends BaseController<SupervisionMatter> {

    private static final Logger LOOGER = LoggerFactory.getLogger(SupervisionMatterController.class);

    @Autowired
    private SupervisionMatterService supervisionMatterService;

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 页面跳转
     * @return
     */
    @RequestMapping(value = "/supervision-matter-list",method = RequestMethod.GET)
    public String jumpPage(ModelMap modelMap){
        //角色
        DicUser dicUser = getCurUser();
        //用户所在部门
        DicDept curDept = dicUser.getDicDept();
        modelMap.put("curDept", curDept.getJsonObject());
        return "pubinfo/supervision/supervision-matter-list";
    }

    /**
     * jqgrid 表格数据
     * @param carrier
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-matter-list.do", produces = "text/html;charset=UTF-8")
    public String load(Carrier<SupervisionMatter> carrier,SupervisionMatterVo supervisionMatterVo){
        Map<String,Object> map = new HashMap<>(8);
        try {
            String cooperativeId = supervisionMatterVo.getCooperativeId();
            if (StringUtils.isNotEmpty(cooperativeId)){
                map.put("cooperativeId",cooperativeId);
            }
            String hostUnitId = supervisionMatterVo.getHostUnitId();
            if (StringUtils.isNotEmpty(hostUnitId)){
                map.put("hostUnitId",hostUnitId);
            }
            String viewOthers = supervisionMatterVo.getViewOthers();
            if (StringUtils.isNotEmpty(viewOthers)){
                map.put("viewOthers", viewOthers);
            }
            String beginTime = supervisionMatterVo.getBeginTime();
            if (StringUtils.isNotEmpty(beginTime)) {
                map.put("beginTime", beginTime);
            }
            String endTime = supervisionMatterVo.getEndTime();
            if (StringUtils.isNotEmpty(endTime)) {
                map.put("endTime", endTime);
            }
            String supMatter = supervisionMatterVo.getSupMatter();
            if (StringUtils.isNotEmpty(supMatter)){
                map.put("supMatter", "%" + supMatter.trim() + "%");
            }
            String serialNumber = supervisionMatterVo.getSerialNumber();
            if (StringUtils.isNotEmpty(serialNumber)){
                map.put("serialNumber","%" + serialNumber.trim() + "%");
            }
            if (StringUtils.isNotEmpty(supervisionMatterVo.getStatus())) {
                List<String> statusList = OtherUtil.strToStringList(supervisionMatterVo.getStatus());
                map.put("statusList", statusList);
            }
            supervisionMatterService.load(carrier,map);
        } catch (Exception e) {
            LOOGER.debug(e.getMessage(),e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑---页面跳转
     * @param id
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/load-matter-edit",method = RequestMethod.GET)
    public String supervisionMatterEdit(String id,ModelMap modelMap){

        //角色
        DicUser dicUser = getCurUser();
        //用户所在部门
        DicDept curDept = dicUser.getDicDept();
        modelMap.put("curDept", curDept.getJsonObject());

        SupervisionMatter supervisionMatter = new SupervisionMatter();
        //主办单位
        DicDept hostUnit = new DicDept();
        //协办单位
        DicDept cooperative = new DicDept();
        if (StringUtils.isNotEmpty(id)){
            supervisionMatter = supervisionMatterService.get(id);
            hostUnit = supervisionMatter.getHostUnit();
            cooperative = supervisionMatter.getCooperative();
        }
        modelMap.addAttribute("hostUnit",hostUnit.getJsonObject());
        modelMap.addAttribute("cooperative",cooperative.getJsonObject());
        modelMap.addAttribute("supervisionMatter", supervisionMatter.getJsonObject());
        modelMap.addAttribute("model", supervisionMatter);
        return "pubinfo/supervision/supervision-matter-edit";
    }

    /**
     * 新增/编辑----保存、下发
     * @param supervisionMatterVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/supervision-matter-save.do", method = RequestMethod.POST)
    public Map<String,Object> saveOrUpdate(SupervisionMatterVo supervisionMatterVo){
        Map<String, Object> map = supervisionMatterService.saveOrUpdate(supervisionMatterVo);

        SysLogVo sysLogVo = getSysLogVo();

        if (StringUtils.isNotEmpty(supervisionMatterVo.getId())){
            sysLogVo.setRecordType(1);
        }else {
            sysLogVo.setRecordType(0);
        }
        if(StringUtils.isNotEmpty(supervisionMatterVo.getStatus())){
            sysLogVo.setTypeName("督查事项下发");
        }else {
            sysLogVo.setTypeName("督查事项保存");
        }
        if (null != map.get("matterLog")){
            SupervisionMatter matterLog = (SupervisionMatter)map.get("matterLog");
            sysLogVo.setEntityId(matterLog.getId());
            sysLogVo.setEntityName(matterLog.getSupMatter());
        }
        sysLogVo.setResult(map.get("result").toString());
        sysLogService.record(sysLogVo);
        return map;
    }

    /**
     * 下发
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/handle-matter.do", method = RequestMethod.POST)
    public Map<String,Object> hairMatter(String id,String type){
        Map<String, Object> map = new HashMap<String, Object>();
        SupervisionMatter supervisionMatter = null;
        try {
            supervisionMatter = supervisionMatterService.get(id);
            //更新状态
            supervisionMatter.setStatus(type);
            //设置更新时间
            supervisionMatter.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(),DateUtil.FORMAT));
            //保存数据
            supervisionMatterService.save(supervisionMatter);
            map.put("result",true);
        }catch (Exception e){
            LOOGER.debug(e.getMessage(),e);
            map.put("result",false);
        }
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("督查事项下发");
        sysLogVo.setRecordType(17);
        if (null != supervisionMatter){
            sysLogVo.setEntityId(supervisionMatter.getId());
            sysLogVo.setEntityName(supervisionMatter.getSupMatter());
        }
        sysLogVo.setResult(map.get("result").toString());
        sysLogService.record(sysLogVo);
        return map;
    }

    /**
     * 删除督查事项信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/matter-delete.do", method = RequestMethod.POST)
    public Map<String,Object> delMatter(String id){
        Map<String, Object> map = new HashMap<String, Object>();
        SupervisionMatter supervisionMatter =null;
        try {
            //根据ID查找督查事项信息
            supervisionMatter = supervisionMatterService.get(id);
            //设置删除标志
            supervisionMatter.setDelFlag("1");
            //删除数据
            supervisionMatterService.save(supervisionMatter);
            map.put("result",true);
        }catch (Exception e){
            LOOGER.debug(e.getMessage(),e);
            map.put("result",false);
        }
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("督查事项");
        sysLogVo.setRecordType(2);
        if (null != supervisionMatter){
            sysLogVo.setEntityId(supervisionMatter.getId());
            sysLogVo.setEntityName(supervisionMatter.getSupMatter());
        }
        sysLogVo.setResult(map.get("result").toString());
        sysLogService.record(sysLogVo);

        return map;
    }

}
