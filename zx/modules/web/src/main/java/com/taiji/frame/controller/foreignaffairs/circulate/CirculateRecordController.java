package com.taiji.frame.controller.foreignaffairs.circulate;

import com.taiji.frame.BaseController;
import com.taiji.frame.model.entity.foreignaffairs.circulate.CirculateRecord;
import com.taiji.frame.model.entity.foreignaffairs.file.FileManage;
import com.taiji.frame.model.entity.foreignaffairs.telegraph.TelegraphManage;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.circulate.CirculateRecordVo;
import com.taiji.frame.service.foreignaffairs.circulate.CirculateRecordService;
import com.taiji.frame.service.foreignaffairs.file.FileManageService;
import com.taiji.frame.service.foreignaffairs.telegraph.TelegraphManageService;
import com.taiji.frame.service.systempara.SysLogService;
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
 * @date 2018/07/25
 * 传阅记录
 */
@Controller
@RequestMapping("/circulate-record")
public class CirculateRecordController extends BaseController<CirculateRecord> {
    private static final Logger log = LoggerFactory.getLogger(CirculateRecordController.class);

    @Autowired
    private CirculateRecordService circulateRecordService;

    @Autowired
    private TelegraphManageService telegraphManageService;

    @Autowired
    private FileManageService fileManageService;

    /**
     * 跳转到电报传阅新增页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-circulate-record-insert",method = RequestMethod.GET)
    public String jumpSaveTelegraphPage(ModelMap modelMap,String id){
        TelegraphManage telegraphManage = null;
        if (!StringUtils.isEmpty(id)){
            telegraphManage = telegraphManageService.get(id);
            modelMap.addAttribute("telegraphManage",telegraphManage);
        }else {
            modelMap.addAttribute("telegraphManage",null);
        }
        return "foreignaffairs/telegraphManage/circulate-telegraph-add";
    }

    /**
     * 跳转到文件传阅新增页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-circulate-record-add",method = RequestMethod.GET)
    public String jumpSaveFile(ModelMap modelMap,String id){
        FileManage fileManage = null;
        if(!StringUtils.isEmpty(id)){
            fileManage = fileManageService.get(id);
            modelMap.addAttribute("fileManage",fileManage);
        }else {
            modelMap.addAttribute("fileManage",null);
        }
        return "foreignaffairs/telegraphManage/circulate-file-add";
    }

    /**
     * 新增电报传阅保存数据
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-circulate-telegraph-save.do",method = RequestMethod.POST)
    public Map<String,Object> saveTelegraphCirculate(CirculateRecordVo circulateRecordVo){
        HashMap map = new HashMap(1);
        try {
            SysLogVo sysLogVo = getSysLogVo();
            circulateRecordService.saveTelegraphCirculate(circulateRecordVo,sysLogVo);
        }catch (Exception e){
            e.printStackTrace();
            map.put("result",false);
            return map;
        }
        map.put("result",true);
        return map;
    }

    /**
     * 新增文件传阅保存数据
     * @param circulateRecordVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-circulate-file-save.do",method = RequestMethod.POST)
    public Map<String,Object> saveFileCirculate(CirculateRecordVo circulateRecordVo){
        HashMap map = new HashMap(1);
        try {
            SysLogVo sysLogVo = getSysLogVo();
            circulateRecordService.saveFileCirculate(circulateRecordVo,sysLogVo);
        }catch (Exception e){
            e.printStackTrace();
            map.put("result",false);
            return map;
        }
        map.put("result",true);
        return map;
    }

    /**
     * 电报传阅详情
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-circulate-file-show",method = RequestMethod.GET)
    public String viewTelegraph(ModelMap modelMap,String id){
        Map<String,List<CirculateRecord>> recordMap = circulateRecordService.findByTelegraphId(id);
        if (recordMap.size() > 0) {
            modelMap.addAttribute("recordMap", recordMap);
        }else {
            modelMap.addAttribute("recordMap", null);
        }
        return "foreignaffairs/telegraphManage/circulate-telegraph-view";
    }

    /**
     * 文件传阅详情
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-circulate-record-view",method = RequestMethod.GET)
    public String viewFile(ModelMap modelMap,String id){
        Map<String,List<CirculateRecord>> recordMap = circulateRecordService.findByFileId(id);
        if (recordMap.size() > 0) {
            modelMap.addAttribute("recordMap", recordMap);
        }else {
            modelMap.addAttribute("recordMap", null);
        }
        return "foreignaffairs/telegraphManage/circulate-file-view";
    }
}
