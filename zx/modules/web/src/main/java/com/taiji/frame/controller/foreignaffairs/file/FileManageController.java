package com.taiji.frame.controller.foreignaffairs.file;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.file.FileManage;
import com.taiji.frame.model.entity.foreignaffairs.file.FileManageFile;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.file.FileManageVo;
import com.taiji.frame.service.foreignaffairs.file.FileManageFileService;
import com.taiji.frame.service.foreignaffairs.file.FileManageService;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qzp
 * @date 2018/07/25
 * 文件管理
 */
@Controller
@RequestMapping("/file-manage")
public class FileManageController extends BaseController<FileManage> {
    private static final Logger log = LoggerFactory.getLogger(FileManageController.class);

    @Autowired
    private FileManageService fileManageService;

    @Autowired
    private FileManageFileService fileManageFileService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 文件管理列表展示
     * @param carrier
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-file-manage-list.do",produces = "text/html;charset=UTF-8")
    public String loadFileManage(Carrier<FileManage> carrier
                    ,String secClassStr,String fileType
                    ,String receiveTime,String senderOrg){
        HashMap map = new HashMap(16);
        try {
            if (!StringUtils.isEmpty(secClassStr)){
                map.put("secClassStr",secClassStr);
            }
            if (!StringUtils.isEmpty(fileType)){
                map.put("fileType",fileType);
            }
            if (!StringUtils.isEmpty(receiveTime)){
                map.put("receiveTime",receiveTime);
            }
            if (!StringUtils.isEmpty(senderOrg)){
                map.put("senderOrg",senderOrg);
            }
            fileManageService.load(carrier,map);
        }catch (Exception e){
            log.debug(e.getMessage(),e);
        }
        System.out.println("数据1: " + gridResult(carrier));
        return gridResult(carrier);
    }

    /**
     * 跳转到文件管理的新增或编辑页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-file-manage-edit",method = RequestMethod.GET)
    public String jump(ModelMap modelMap,String id){
        FileManage fileManage = null;
        String receiveTimeSt = getCurDateStr(DateUtil.FORMAT_DAY);
        if (!StringUtils.isEmpty(id)){
            fileManage = fileManageService.get(id);
            List<FileManageFile> fileManageFiles = new ArrayList<>();
            if (fileManage != null) {
                receiveTimeSt = DateUtil.dateToString(fileManage.getReceiveTime(),DateUtil.FORMAT_DAY);
                List<FileManageFile> files = fileManageFileService.findByFileId(fileManage.getId());
                fileManageFiles.addAll(files);
            }
            List<JSONObject> jsonFileObject = getFileData(fileManageFiles);
            modelMap.addAttribute("jsonFileObject",jsonFileObject);
        }
        List<DicParam> secClassList = dicParamService.getParamByGroupId(23);
        modelMap.addAttribute("secClassList", secClassList);
        modelMap.addAttribute("fileManage",fileManage);
        modelMap.addAttribute("receiveTimeSt",receiveTimeSt);
        return "foreignaffairs/telegraphManage/file-manage-edit";
    }

    /**
     * 新增或编辑保存数据
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-file-manage-save.do",method = RequestMethod.POST)
    public Map<String,Object> saveOrUpdateFile(FileManageVo fileManageVo, HttpServletRequest request){
        String basePath = UploadConstant.uploadBaseDir;
        Map<String,Object> map = fileManageService.saveData(fileManageVo,basePath,getSysLogVo());
        return map;
    }

    /**
     * 删除文件的某条信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-file-manage-delete.do",method = RequestMethod.POST)
    public Map<String,Object> delFile(String id){
        HashMap map = new HashMap(3);
        try {
            FileManage fileManage = fileManageService.get(id);
            fileManage.setDelFlag("1");
            fileManageService.save(fileManage);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("文件管理");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(fileManage.getFileTitle());
            sysLogVo.setEntityId(fileManage.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            log.debug(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 获取文件管理的文件列表
     *
     * @param modelMap
     * @param id
     */
    @ResponseBody
    @RequestMapping(value = "/get-filemanage-file-list.do", method = RequestMethod.POST)
    public Map<String, Object> getReceptionFileList(ModelMap modelMap, String id) {
        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {
            FileManage fileManage = fileManageService.get(id);
            List<FileManageFile> fileManageFiles = new ArrayList<>();
            if (null != fileManage) {
                List<FileManageFile> files = fileManageFileService.findByFileId(fileManage.getId());
                fileManageFiles.addAll(files);
            }

            List<JSONObject> fileList = getFileData(fileManageFiles);
            map.put("fileList", fileList);
        }

        return map;
    }

    /**
     * 获电报文件信息
     * @param fileList
     * @return
     */
    private List<JSONObject> getFileData(List<FileManageFile> fileList) {

        if (null == fileList || fileList.size() == 0) {
            return null;
        }
        List<JSONObject> jsonObjectList = new ArrayList<>();
        for (FileManageFile file : fileList) {

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
