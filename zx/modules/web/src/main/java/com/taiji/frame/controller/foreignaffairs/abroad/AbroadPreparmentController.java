package com.taiji.frame.controller.foreignaffairs.abroad;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.FileUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadPreparment;
import com.taiji.frame.model.entity.foreignaffairs.abroad.PreparementFile;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.abroad.AbroadPreparmentVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadPreparmentService;
import com.taiji.frame.service.foreignaffairs.abroad.PreparementFileService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;

@Controller
@RequestMapping(value = "/abroad-preparment")
public class AbroadPreparmentController extends BaseController<AbroadPreparment> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private AbroadPreparmentService abroadPreparmentService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private PreparementFileService preparementFileService;

    @Autowired
    private SysLogService sysLogService;


    /**
     * 页面跳转
     */
    @RequestMapping(value = "/abroad-preparment-list", method = RequestMethod.GET)
    public String list(String abroadInfoId, ModelMap modelMap) {
        modelMap.addAttribute("abroadInfoId", abroadInfoId);
        AbroadInfo abroadInfo = abroadInfoService.get(abroadInfoId);
        modelMap.put("abroadInfo", abroadInfo);
        return "foreignaffairs/abroad/abroad-preparment-list";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-preparment-list.do", produces = "text/html;charset=UTF-8")
    public String preparmentListLoad(Carrier<AbroadPreparment> carrier, AbroadPreparmentVo abroadPreparmentVo) {
        HashMap map = new HashMap(16);
        try {
            if (StringUtils.isNotEmpty(abroadPreparmentVo.getAbroadInfoId())) {
                map.put("abroadInfoId", abroadPreparmentVo.getAbroadInfoId());
                abroadPreparmentService.load(carrier, map);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑弹窗
     */
    @RequestMapping(value = "/load-preparment-edit.do", method = RequestMethod.GET)
    public String abroadPreparmentEdit(ModelMap modelMap, String id) {
        AbroadPreparment abroadPreparment = null;
        if (StringUtils.isNotEmpty(id)) {
            abroadPreparment = abroadPreparmentService.get(id);

            List<PreparementFile> preparementFiles = new ArrayList<>();
            if (null != abroadPreparment) {
                List<PreparementFile> files = preparementFileService.findByPreparementId(abroadPreparment.getId());
                preparementFiles.addAll(files);
            }
            modelMap.addAttribute("abroadPreparment", abroadPreparment);
            List<JSONObject> preparmentFileList = getPreparementFileData(preparementFiles);
            modelMap.addAttribute("preparmentFileList", preparmentFileList);
        }

        return "foreignaffairs/abroad/abroad-preparment-edit";
    }


    /**
     * 新增/编辑保存
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-preparment-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveAbroadPreparment(HttpServletRequest request, AbroadPreparmentVo abroadPreparmentVo) {

        String dstDir = UploadConstant.preparement;

        Map<String, Object> map = new HashMap<>(2);

        AbroadPreparment abroadPreparment;
        // 编辑时删除旧文件
        String id = abroadPreparmentVo.getId();
        if (id != null) {
            abroadPreparment = abroadPreparmentService.get(id);
        } else {
            abroadPreparment = new AbroadPreparment();
            abroadPreparment.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
        }

        try {
            AbroadInfo abroadInfo = abroadInfoService.get(abroadPreparmentVo.getAbroadInfoId());
            abroadPreparment.setAbroadInfo(abroadInfo);

            abroadPreparment.setMeetingName(abroadPreparmentVo.getMeetingName());
            if (StringUtils.isNotEmpty(abroadPreparmentVo.getMeetingDateStr())) {
                Date meetingDate = DateUtil.stringToDate(abroadPreparmentVo.getMeetingDateStr(), DateUtil.FORMAT_DAY);
                abroadPreparment.setMeetingDate(meetingDate);
            }
            abroadPreparment.setMeetingTime(abroadPreparmentVo.getMeetingTime());
            abroadPreparment.setMeetingPlace(abroadPreparmentVo.getMeetingPlace());
            abroadPreparment.setAttendees(abroadPreparmentVo.getAttendees());

            abroadPreparment.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
            abroadPreparment.setDelFlag("0");

            abroadPreparmentService.save(abroadPreparment);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
            return map;
        }

        String fileIds = abroadPreparmentVo.getFileIds();
        if (StringUtils.isNotEmpty(fileIds)) {
            JSONArray jsonArray = JSONArray.fromObject(fileIds);
            for (int i = 0; i < jsonArray.size(); i++) {
                JSONObject jsonObject = JSONObject.fromObject(jsonArray.get(i));
                String fileId = String.valueOf(jsonObject.get("fileId"));
                DicUploadFile uploadFile = dicUploadFileService.get(fileId);

                // 转移筹备会议文件到正式文件夹
                try {
                    dicUploadFileService.transfer(uploadFile, dstDir);
                    abroadPreparmentService.savePreparementFile(abroadPreparment, uploadFile);
                } catch (Exception e) {
                    e.printStackTrace();
                    map.put("result", false);
                    return map;
                }
            }
        }
        map.put("result", true);
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("出访信息");
        if(org.apache.commons.lang.StringUtils.isEmpty(abroadPreparmentVo.getId())){
            sysLogVo.setRecordType(0);
        }else {
            sysLogVo.setRecordType(1);
        }
        sysLogVo.setEntityName(abroadPreparment.getAbroadInfo().getAbroadType());
        sysLogVo.setEntityId(abroadPreparment.getId());
        sysLogVo.setResult("true");
        sysLogService.record(sysLogVo);
        return map;
    }

    /**
     * 删除
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-preparment-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteAbroadPreparment(String id) {
        Map<String, Object> map = new HashMap<>(2);
        try {
            AbroadPreparment abroadPreparment = abroadPreparmentService.get(id);
            //abroadPreparment.setDelFlag("1");
            //abroadPreparmentService.save(abroadPreparment);
            abroadPreparmentService.delete(abroadPreparment);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(abroadPreparment.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(abroadPreparment.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 获取筹备会议的文件列表
     *
     * @param modelMap
     * @param id
     */
    @ResponseBody
    @RequestMapping(value = "/get-file-list.do", method = RequestMethod.POST)
    public Map<String, Object> getReceptionFileList(ModelMap modelMap, String id) {
        Map<String, Object> map = new HashMap<>(2);

        if (StringUtils.isNotEmpty(id)) {
            AbroadPreparment abroadPreparment = abroadPreparmentService.get(id);
            List<PreparementFile> preparementFiles = new ArrayList<>();
            if (null != abroadPreparment) {
                List<PreparementFile> files = preparementFileService.findByPreparementId(abroadPreparment.getId());
                preparementFiles.addAll(files);
            }

            List<JSONObject> preparementFileList = getPreparementFileData(preparementFiles);
            map.put("preparementFileList", preparementFileList);
            map.put("result", true);
        }

        return map;
    }

    /**
     * 获取筹备会议文件信息
     *
     * @param fileList
     * @return
     */
    private List<JSONObject> getPreparementFileData(List<PreparementFile> fileList) {

        if (null == fileList || fileList.size() == 0) {
            return null;
        }
        List<JSONObject> jsonObjectList = new ArrayList<>();
        for (PreparementFile file : fileList) {

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
