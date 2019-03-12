package com.taiji.frame.controller.foreignaffairs.telegraph;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.telegraph.TelegraphManage;
import com.taiji.frame.model.entity.foreignaffairs.telegraph.TelegraphManageFile;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.telegraph.TelegraphManageVo;
import com.taiji.frame.service.foreignaffairs.telegraph.TelegraphManageFileService;
import com.taiji.frame.service.foreignaffairs.telegraph.TelegraphManageService;
import com.taiji.frame.service.systempara.DicParamService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.SysLogService;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qzp
 * @date 2018/07/25
 * 电报管理
 */
@Controller
@RequestMapping("/telegraph-manage")
public class TelegraphManageController extends BaseController<TelegraphManage> {

    private static final Logger log = LoggerFactory.getLogger(TelegraphManageController.class);

    @Autowired
    private TelegraphManageService telegraphManageService;

    @Autowired
    private TelegraphManageFileService telegraphManageFileService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private SysLogService sysLogService;
    /**
     * 跳转到电报管理页面
     * @return
     */
    @RequestMapping(value = "/jump-to-telegraph-manage-list",method = RequestMethod.GET)
    public String loadToTelegraphPage(ModelMap modelMap,HttpServletRequest request){
        String flag = request.getParameter("flag");

        List<DicParam> secClassList = dicParamService.getParamByGroupId(23);
        modelMap.addAttribute("secClassList", secClassList);

        if (StringUtils.isEmpty(flag)){
            modelMap.addAttribute("result","telegraph");
        }else if (flag.equals("1")){
            modelMap.addAttribute("result","file");
        }
        return "foreignaffairs/telegraphManage/telegraph-manage-list";
    }

    /**
     * 电报管理列表展示
     * @param carrier
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-telegraph-manage-list.do",produces = "text/html;charset=UTF-8")
    public String loadTelegraphPage(Carrier<TelegraphManage> carrier
            ,String secClass,String telegramType
            ,String receiveTime,String recoder){
        HashMap map = new HashMap(16);
        try {
            if (!StringUtils.isEmpty(secClass)){
                map.put("secClass","%"+secClass+"%");
            }
            if (!StringUtils.isEmpty(telegramType)){
                map.put("telegramType","%"+telegramType+"%");
            }
            if (!StringUtils.isEmpty(receiveTime)){
                map.put("receiveTime",receiveTime);
            }
            if (!StringUtils.isEmpty(recoder)){
                map.put("recoder","%"+recoder+"%");
            }
            telegraphManageService.load(carrier,map);
        }catch (Exception e){
            log.debug(e.getMessage(),e);
        }
        return gridResult(carrier);
    }

    /**
     * 跳转到电报的新增或编辑页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-telegraph-manage-edit",method = RequestMethod.GET)
    public String jumpEditOrSavePage (ModelMap modelMap,String id){
        TelegraphManage telegraphManage = null;
        String receiveTime = getCurDateStr(DateUtil.FORMAT_DAY);
        if (!StringUtils.isEmpty(id)){
            telegraphManage = telegraphManageService.get(id);
            List<TelegraphManageFile> telegraphManageFiles = new ArrayList<>();
            if (telegraphManage != null) {
                receiveTime = DateUtil.dateToString(telegraphManage.getReceiveTime(),DateUtil.FORMAT_DAY);
                List<TelegraphManageFile> files = telegraphManageFileService.findByTelegraphId(telegraphManage.getId());
                telegraphManageFiles.addAll(files);
            }
            List<JSONObject> jsonFileObject = getFileData(telegraphManageFiles);
            modelMap.addAttribute("jsonFileObject",jsonFileObject);
        }
        List<DicParam> secClassList = dicParamService.getParamByGroupId(23);
        modelMap.addAttribute("secClassList", secClassList);
        modelMap.addAttribute("telegraphManage",telegraphManage);
        modelMap.addAttribute("receiveTime",receiveTime);
        return "foreignaffairs/telegraphManage/telegraph-manage-edit";
    }

    /**
     * 新增或编辑保存数据
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-telegraph-manage-save.do",method = RequestMethod.POST)
    public Map<String,Object> saveOrUpdateTelegraph(TelegraphManageVo telegraphManageVo,HttpServletRequest request){
        HashMap map1 = new HashMap(1);
        String basePath = UploadConstant.uploadBaseDir;
        DicUser curUser = getCurUser();
        Map<String,Object> map = telegraphManageService.saveData(telegraphManageVo,basePath,curUser,getSysLogVo());
        return map;
    }

    /**
     * 删除电报的某条信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-telegraph-manage-delete.do",method = RequestMethod.POST)
    public Map<String,Object> delTelegraph(String id){
        HashMap map = new HashMap(3);
        try {
            TelegraphManage telegraphManage = telegraphManageService.get(id);
            telegraphManage.setDelFlag("1");
            telegraphManageService.save(telegraphManage);
            map.put("result",true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("电报信息");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(telegraphManage.getTelegramTitle());
            sysLogVo.setEntityId(telegraphManage.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            log.debug(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }


    /**
     * 获取电报的文件列表
     *
     * @param modelMap
     * @param id
     */
    @ResponseBody
    @RequestMapping(value = "/get-telegraph-file-list.do", method = RequestMethod.POST)
    public Map<String, Object> getReceptionFileList(ModelMap modelMap, String id) {
        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {
            TelegraphManage telegraphManage = telegraphManageService.get(id);
            List<TelegraphManageFile> telegraphManageFiles = new ArrayList<>();
            if (null != telegraphManage) {
                List<TelegraphManageFile> files = telegraphManageFileService.findByTelegraphId(telegraphManage.getId());
                telegraphManageFiles.addAll(files);
            }

            List<JSONObject> fileList = getFileData(telegraphManageFiles);
            map.put("fileList", fileList);
        }

        return map;
    }

    /**
     * 获电报文件信息
     * @param fileList
     * @return
     */
    private List<JSONObject> getFileData(List<TelegraphManageFile> fileList) {

        if (null == fileList || fileList.size() == 0) {
            return null;
        }
        List<JSONObject> jsonObjectList = new ArrayList<>();
        for (TelegraphManageFile file : fileList) {

            JSONObject jsonFileObject = new JSONObject();
            DicUploadFile dicUploadFile = file.getDicUploadFile();

            // 只显示状态为 1 的有效文件
            if (null != dicUploadFile && dicUploadFile.getStatus() == 1) {
                String fileId = dicUploadFile.getId();
                String fileName = dicUploadFile.getFileName();
                jsonFileObject.put("fileName", fileName);
                jsonFileObject.put("id", fileId);
                jsonObjectList.add(jsonFileObject);
            }
        }

        return jsonObjectList;
    }
}
