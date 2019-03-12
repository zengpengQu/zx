package com.taiji.frame.controller.pubinfo.schedule;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.FileUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.pubinfo.schedule.DutyFile;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.schedule.DutyFileVo;
import com.taiji.frame.service.pubinfo.schedule.DutyFileService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author yx
 * 值班日报文件
 */
@Controller
@RequestMapping(value = "/duty-daily-file")
public class DutyFileController extends BaseController<DutyFile> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private DutyFileService dutyFileService;

    @Autowired
    private UtilService utilService;
    @Autowired
    private SysLogService sysLogService;


    /**
     * 值班日报上传页面跳转
     */
    @RequestMapping(value = "/duty-daily-upload-list", method = RequestMethod.GET)
    public String uploadList(Map<String, Object> map) {

        //系统时间
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        map.put("sysDate", sysDate);

        return "pubinfo/schedule/duty-daily/duty-daily-upload";
    }

    /**
     * 值班日报文件列表页面
     */
    @ResponseBody
    @RequestMapping(value = "/load-duty-file-list.do", produces = "text/html;charset=UTF-8")
    public String loadDutyFileList(Carrier<DutyFile> carrier, String startTime, String endTime,
                                   String dutyNum, String keyword) {

        HashMap map = new HashMap(5);

        try {
            if (!StringUtils.isEmpty(startTime)) {
                map.put("startTime", startTime);
            }
            if (!StringUtils.isEmpty(endTime)) {
                map.put("endTime", endTime);
            }
            if (!StringUtils.isEmpty(dutyNum)) {
                map.put("dutyNum", dutyNum);
            }
            if (!StringUtils.isEmpty(keyword)) {
                map.put("keyword", "%" + keyword + "%");
            }
            dutyFileService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 上传值班日报文件
     */
    @ResponseBody
    @RequestMapping(value = "/duty-file-upload.do", method = RequestMethod.POST)
    public Map<String, Object> uploadDutyFile(@RequestParam("uploadDuty") MultipartFile file,
                                              HttpServletRequest request) throws Exception {
        String basePath = UploadConstant.uploadBaseDir;
        String path = basePath + File.separator + UploadConstant.dutyFile + File.separator;

        Map<String, Object> map = new HashMap<>(4);
        if (!file.isEmpty()) {
            Map param = FileUtil.uploadFile(file, path);
            String realName = String.valueOf(param.get("realName"));
            String fileDir = String.valueOf(param.get("fileDir"));
            String uuidName = fileDir.substring(fileDir.lastIndexOf(File.separator) + 1);
            map.put("realName", realName);
            map.put("uuidName", uuidName);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("值班日报");
                sysLogVo.setRecordType(6);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId("");
            sysLogVo.setEntityName("");
            sysLogService.record(sysLogVo);

        } else {
            map.put("result", false);
            return map;
        }
        map.put("result", true);


        return map;
    }

    /**
     * 下载值班日报文件
     */
    @RequestMapping(value = "/duty-file-download.do", method = RequestMethod.POST)
    public void downloadDutyFile(@RequestParam(value = "uuidName") String uuidName,
                                   @RequestParam(value = "realName") String realName,
                                   HttpServletRequest request, HttpServletResponse response) {
        String path = UploadConstant.uploadBaseDir + File.separator + UploadConstant.dutyFile + File.separator;
        String filePath = path + uuidName;
        try {
            FileUtil.downOrPreview(realName, filePath, response, request, "0");

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("值班日报");
            sysLogVo.setRecordType(7);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId("");
            sysLogVo.setEntityName("");
            sysLogService.record(sysLogVo);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 查看日报文件弹窗
     */
    @RequestMapping(value = "/duty-file-view.do", method = RequestMethod.GET)
    public String dutyFileView(ModelMap modelMap, String id) {

        DutyFile dutyFile = dutyFileService.get(id);

        modelMap.addAttribute("model", dutyFile);

        return "pubinfo/schedule/duty-daily/duty-file-view";

    }

    /**
     * 新增/编辑日报文件弹窗
     */
    @RequestMapping(value = "/duty-file-edit.do", method = RequestMethod.GET)
    public String dutyFileEdit(ModelMap modelMap, String id) {

        DutyFile dutyFile = null;
        if (StringUtils.isNotEmpty(id)) {
            dutyFile = dutyFileService.get(id);
        }

        modelMap.addAttribute("model", dutyFile);

        return "pubinfo/schedule/duty-daily/duty-file-edit";
    }

    /**
     * 新增/编辑值班日报保存
     */
    @ResponseBody
    @RequestMapping(value = "/duty-file-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveDutyFile(HttpServletRequest request, DutyFileVo dutyFileVo) {

        String path = UploadConstant.uploadBaseDir + File.separator + UploadConstant.dutyFile + File.separator;

        Map<String, Object> map = new HashMap<>(2);

        DutyFile dutyFile;
        // 编辑时删除旧文件
        String id = dutyFileVo.getId();
        if (StringUtils.isNotEmpty(id)) {
            dutyFile = dutyFileService.get(id);
            if (dutyFile != null) {
                String filePath = dutyFile.getFileDir();
                deleteFile(filePath);
            }
        } else {
            dutyFile = new DutyFile();
        }

        try {
            // 设置期数
            String dutyNum = dutyFileVo.getDutyNum();
            dutyFile.setDutyNum(dutyNum);
            // 设置日报日期
            String dutyTimeStr = dutyFileVo.getDutyTimeStr();
            Date dutyTime = DateUtil.stringToDate(dutyTimeStr, DateUtil.FORMAT_DAY);
            dutyFile.setDutyTime(dutyTime);
            // 设置上传者
            String uploader = dutyFileVo.getUploader().trim();
            dutyFile.setUploader(uploader);
            //设置操作人
            DicUser dicUser = getCurUser();
            dutyFile.setDicUser(dicUser);
            //设置更新时间,当前系统时间
            dutyFile.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN));
            //设置删除标志,未删除
            dutyFile.setDelFlag("0");
            // 设置发布状态
            dutyFile.setPublishStatus("0");
            // 设置日报文件的原始名称
            String realName = dutyFileVo.getRealName().trim();
            dutyFile.setRealName(realName);
            // 设置日报文件存储路径
            String fileDir = path + dutyFileVo.getUuidName();
            dutyFile.setFileDir(fileDir);
            // 设置日报文本内容
//            String content = getWordText(fileDir);
//            dutyFile.setContent(content);

            dutyFileService.save(dutyFile);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("值班日报文件");
            if(StringUtils.isNotEmpty(dutyFileVo.getId())){
                sysLogVo.setRecordType(1);
            }else {
                sysLogVo.setRecordType(0);
            }

            sysLogVo.setEntityId(dutyFile.getId());
            sysLogVo.setEntityName(dutyFile.getContent());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            map.put("result", true);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    private void deleteFile(String path) {
        if (StringUtils.isNotEmpty(path)) {
            File file = new File(path);
            try {
                file.delete();
                LOG.debug("Delete old duty files");
            } catch (Exception e) {
                LOG.debug("ERROR On Delete old duty files");
            }
        }
    }

    /**
     * 获取 word 文本内容
     */
//    private String getWordText(String fileDir) throws IOException {
//        String DOC_TYPE = "doc";
//        String DOCX_TYPE  = "docx";
//        StringBuilder text = new StringBuilder("");
//
//        String textType = fileDir.substring(fileDir.lastIndexOf(".") + 1);
//        InputStream is = new FileInputStream(new File(fileDir));
//
//        if (textType.equals(DOC_TYPE)) {
//            HWPFDocument doc = new HWPFDocument(is);
//            WordExtractor extractor = new WordExtractor(doc);
//            text.append(extractor.getText());
//        } else if (textType.equals(DOCX_TYPE)) {
//            XWPFDocument docx = new XWPFDocument(is);
//            XWPFWordExtractor extractor = new XWPFWordExtractor(docx);
//            text.append(extractor.getText());
//        } else {
//            LOG.error("文件格式错误");
//        }
//
//        return text.toString();
//    }
//

    /**
     * 删除值班日志文件
     */
    @ResponseBody
    @RequestMapping(value = "/duty-file-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteDuty(String id) {

        Map<String, Object> map = new HashMap<>(2);
        try {
            //根据id查找值班日报信息
            DutyFile dutyFile = dutyFileService.get(id);
            //删除标志设为1
            dutyFile.setDelFlag("1");
            //保存数据
            dutyFileService.save(dutyFile);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("值班日报文件");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityId(dutyFile.getId());
            sysLogVo.setEntityName(dutyFile.getContent());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);

        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

}
