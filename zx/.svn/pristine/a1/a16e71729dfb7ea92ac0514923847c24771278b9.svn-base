package com.taiji.frame.controller.foreignaffairs.tempForeignAffairs;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.BeanCopyUtil;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.Chronicle;
import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.TempAffairs;
import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.TempAffairsFile;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.tempForeignAffairs.TempAffairsVo;
import com.taiji.frame.service.foreignaffairs.tempForeignAffairs.ChronicleService;
import com.taiji.frame.service.foreignaffairs.tempForeignAffairs.TempAffairsFileService;
import com.taiji.frame.service.foreignaffairs.tempForeignAffairs.TempAffairsService;
import com.taiji.frame.service.systempara.DicParamService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.SysLogService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.util.*;

/**
 * 临时外事活动
 * Created by yuLei on 2018/7/17.
 */
@Controller
@RequestMapping(value = "/temp-affairs")
public class tempAffairsController extends BaseController<TempAffairs> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private TempAffairsService tempAffairsService;

    @Autowired
    private ChronicleService chronicleService;

    @Autowired
    private TempAffairsFileService tempAffairsFileService;

    @Autowired
    DicUploadFileService dicUploadFileService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private SysLogService sysLogService;
    /**
     * 页面跳转
     * @param map
     * @return
     */
    @RequestMapping(value = "/temp-affairs-list", method = RequestMethod.GET)
    public String list(Map<String, Object> map) {

        //团组级别
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(2);
        map.put("dicParamList", dicParamList);

        return "foreignaffairs/tempForeignAffairs/temp-affairs-list";
    }

    /**
     * load grid表格数据
     * @param carrier
     * @param groupName
     * @param contacts
     * @param contactsTel
     * @param sponsor
     * @param groupLevel
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-temp-affairs-list.do", produces = "text/html;charset=UTF-8")
    public String dutyListLoad(Carrier<TempAffairs> carrier, String groupName, String contacts, String contactsTel, String sponsor, String groupLevel) {

        HashMap map = new HashMap();

        try {
            if (!StringUtils.isEmpty(groupName)) {
                map.put("groupName", "%" + groupName + "%");
            }
            if (!StringUtils.isEmpty(contacts)) {
                map.put("contacts", "%" + contacts + "%");
            }
            if (!StringUtils.isEmpty(contactsTel)) {
                map.put("contactsTel", "%" + contactsTel + "%");
            }
            if (!StringUtils.isEmpty(sponsor)) {
                map.put("sponsor", sponsor);
            }
            if (!StringUtils.isEmpty(groupLevel)) {
                map.put("groupLevel", groupLevel);
            }
            tempAffairsService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 页面跳转至编辑页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/temp-affairs-edit", method = RequestMethod.GET)
    public String edit(ModelMap modelMap, String id) {

        TempAffairs tempAffairs = new TempAffairs();

        if (!StringUtils.isEmpty(id)) {
            tempAffairs = tempAffairsService.get(id);
            List<Chronicle> chronicleList = chronicleService.findByTempAffairsId(id);

            TempAffairsVo tempAffairsVo = new TempAffairsVo();
            tempAffairsVo.setChronicleList(chronicleList);
            try {
                new BeanCopyUtil().copyNotNullProperties(tempAffairs, tempAffairsVo, true);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }

            modelMap.addAttribute("tempAffairs", tempAffairsVo);

            List<TempAffairsFile> tempAffairsFiles = new ArrayList<>();
            if (tempAffairs != null) {
                List<TempAffairsFile> files = tempAffairsFileService.findByAffairsId(tempAffairs.getId());
                tempAffairsFiles.addAll(files);
            }
            List<JSONObject> jsonFileObject = getFileDataTemp(tempAffairsFiles);
            modelMap.addAttribute("jsonFileObject",jsonFileObject);

        }
        //团组级别
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(2);
        modelMap.addAttribute("dicParamList", dicParamList);

        //部门信息
        DicDept dicDept = new DicDept();
        if (null != tempAffairs.getDicDept()) {
            dicDept = tempAffairs.getDicDept();
        }
        modelMap.addAttribute("dicDept",dicDept.getJsonObject());


        return "foreignaffairs/tempForeignAffairs/temp-affairs-edit";
    }

    /**
     * 详情查看
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/temp-affairs-view", method = RequestMethod.GET)
    public String view(ModelMap modelMap, String id) {
        if (!StringUtils.isEmpty(id)) {
            TempAffairs tempAffairs = tempAffairsService.get(id);
            tempAffairs.getJsonObject();
            List<Chronicle> chronicleList = chronicleService.findByTempAffairsId(id);
            for (Chronicle chronicle : chronicleList) {
                chronicle.getJsonObject();
            }
            modelMap.addAttribute("tempAffairs", tempAffairs);
            modelMap.addAttribute("chronicleList", chronicleList);

            List<TempAffairsFile> files = tempAffairsFileService.findByAffairsId(tempAffairs.getId());
            List<TempAffairsFile> tempAffairsFiles = new ArrayList<>(files);
            List<JSONObject> jsonFileObject = getFileDataTemp(tempAffairsFiles);
            modelMap.addAttribute("jsonFileObject",jsonFileObject);
        }
        return "foreignaffairs/tempForeignAffairs/temp-affairs-view";
    }

    /**
     * 临时外事活动删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/temp-affairs-delete.do", method = RequestMethod.POST)
    public Map<String, Object> delete(String id) {
        HashMap<String, Object> map = new HashMap<>(1);
        try {
            TempAffairs tempAffairs = tempAffairsService.get(id);
            List<Chronicle> chronicleList = chronicleService.findByTempAffairsId(id);
            if (null != chronicleList && chronicleList.size() > 0) {
                for (Chronicle chronicle : chronicleList) {
                    chronicle.setDelFlag("1");
                    chronicleService.save(chronicle);
                }
            }
            tempAffairs.setDelFlag("1");
            tempAffairsService.save(tempAffairs);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("临时外事活动");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(tempAffairs.getActivityType());
            sysLogVo.setEntityId(tempAffairs.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 保存临时外事活动
     * @param tempAffairsVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/temp-affairs-save.do", method = RequestMethod.POST)
    public Map<String, Object> save(@RequestBody TempAffairsVo tempAffairsVo, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>(2);

        String dstDir = UploadConstant.tempAffairs;

        try {
            String id = tempAffairsVo.getId();
            TempAffairs tempAffairs;

            //编辑
            if (StringUtils.isNotEmpty(id)) {
                tempAffairs = tempAffairsService.get(id);
                new BeanCopyUtil().copyNotNullProperties(tempAffairsVo, tempAffairs, true);
                //临时外事活动
                tempAffairs.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                tempAffairsService.save(tempAffairs);

                List<Chronicle> chronicleList = tempAffairsVo.getChronicleList();
                //大事记
                for (int i = 0; i < chronicleList.size(); i++) {
                    Chronicle chronicle = chronicleList.get(i);
                    String chronicleId = chronicle.getId();

                    Chronicle tempChronicle;
                    //已存在的
                    if (StringUtils.isNotEmpty(chronicleId)) {
                        tempChronicle = chronicleService.get(chronicleId);
                        if(StringUtils.isNotEmpty(chronicle.getNotes())){
                            tempChronicle.setNotes(chronicle.getNotes());
                        }
                        if(StringUtils.isNotEmpty(chronicle.getContent())){
                            tempChronicle.setContent(chronicle.getContent());
                        }
                        if(chronicle.getBeginTime()!=null){
                            tempChronicle.setBeginTime(chronicle.getBeginTime());
                        }
                        if(chronicle.getEndTime()!=null){
                            tempChronicle.setEndTime(chronicle.getEndTime());
                        }
                    //不存在的
                    } else {
                        tempChronicle = chronicle;
                        tempChronicle.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                        tempChronicle.setDelFlag("0");
                    }
                    tempChronicle.setGroupName(tempAffairs.getGroupName());
                    tempChronicle.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    tempChronicle.setDicParam(tempAffairs.getDicParam());

                    chronicleService.save(tempChronicle);
                }

                //附件上传
                String fileIds = tempAffairsVo.getFileIds();
                if (StringUtils.isNotEmpty(fileIds)) {
                    JSONArray jsonArray = JSONArray.fromObject(fileIds);

                    for (Object json : jsonArray) {
                        JSONObject jsonObject = JSONObject.fromObject(json);
                        String fileId = String.valueOf(jsonObject.get("fileId"));

                        Boolean isExist = tempAffairsFileService.findByAffairsIdAndFileId(id, fileId);
                        if (!isExist) {
                            //不存在
                            DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                            dicUploadFileService.transfer(uploadFile, dstDir);
                            TempAffairsFile file = tempAffairsFileService.findUniqueBy("fileId", fileId);
                            if (file != null) {
                                //之前上传过附件,更新
                                file.setFileId(fileId);
                                tempAffairsFileService.save(file);
                            } else {
                                //原本就不存在附件,新增
                                tempAffairsService.saveTempAffairsFile(tempAffairs, fileId);
                            }
                        }
                    }
                }
                map.put("result", true);
            } else {
                //新增
                tempAffairs = new TempAffairs();
                new BeanCopyUtil().copyNotNullProperties(tempAffairsVo, tempAffairs, true);
                //临时外事活动
                tempAffairs.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                tempAffairs.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                tempAffairs.setDelFlag("0");
                tempAffairsService.save(tempAffairs);

                List<Chronicle> tempList = tempAffairsVo.getChronicleList();
                //大事记
                for (int i = 0; i < tempList.size(); i ++) {
                    Chronicle chronicle = tempList.get(i);
                    chronicle.setTempAffairs(tempAffairs);
                    chronicle.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    chronicle.setDelFlag("0");
                    chronicle.setGroupName(tempAffairs.getGroupName());
                    chronicle.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    chronicle.setDicParam(tempAffairs.getDicParam());
                    chronicleService.save(chronicle);
                }

                //附件上传
                String fileIds = tempAffairsVo.getFileIds();
                if (StringUtils.isNotEmpty(fileIds)) {
                    JSONArray jsonArray = JSONArray.fromObject(fileIds);
                    for (Object json : jsonArray) {
                        JSONObject jsonObject = JSONObject.fromObject(json);
                        String fileId = String.valueOf(jsonObject.get("fileId"));

                        DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                        try {
                            dicUploadFileService.transfer(uploadFile, dstDir);
                            tempAffairsService.saveTempAffairsFile(tempAffairs, fileId);
                        } catch (Exception e) {
                            e.printStackTrace();
                            map.put("result",false);
                            return map;
                        }
                    }
                }
                map.put("result", true);

                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("临时外事活动");
                if(org.apache.commons.lang.StringUtils.isEmpty(id)){
                    sysLogVo.setRecordType(0);
                }else {
                    sysLogVo.setRecordType(1);
                }
                sysLogVo.setEntityName(tempAffairs.getActivityType());
                sysLogVo.setEntityId(tempAffairs.getId());
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
     * 删除大事记
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/chronicle-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteChronicle(String id) {
        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {
            Chronicle chronicle = chronicleService.get(id);
            chronicle.setDelFlag("1");
            try {
                chronicleService.save(chronicle);
                map.put("result", true);

                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("临时外事活动大事记");
                    sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(chronicle.getContent());
                sysLogVo.setEntityId(chronicle.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            } catch (Exception e) {
                LOG.debug(e.getMessage(), e);
                map.put("result", false);
            }
        }

        return map;
    }

    /**
     * 获取临时外事的文件列表
     *
     * @param modelMap
     * @param id
     */
    @ResponseBody
    @RequestMapping(value = "/get-temp-affairs-file-list.do", method = RequestMethod.POST)
    public Map<String, Object> getTempAffairsFileList(ModelMap modelMap, String id) {
        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {
            TempAffairs tempAffairs = tempAffairsService.get(id);
            List<TempAffairsFile> tempAffairsFiles = new ArrayList<>();
            if (null != tempAffairs) {
                List<TempAffairsFile> files = tempAffairsFileService.findByAffairsId(tempAffairs.getId());
                tempAffairsFiles.addAll(files);
            }

            List<JSONObject> fileList = getFileDataTemp(tempAffairsFiles);
            map.put("fileList", fileList);
        }

        return map;
    }

    /**
     * 获取文件信息
     * @param fileList
     * @return
     */
    private List<JSONObject> getFileDataTemp(List<TempAffairsFile> fileList) {

        if (null == fileList || fileList.size() == 0) {
            return null;
        }
        List<JSONObject> jsonObjectList = new ArrayList<>();
        for (TempAffairsFile file : fileList) {

            JSONObject jsonFileObject = new JSONObject();
            String fileId = file.getFileId();
            DicUploadFile dicUploadFile = dicUploadFileService.get(fileId);

            // 只显示状态为 1 的有效文件
            if (null != dicUploadFile && dicUploadFile.getStatus() == 1) {
                String fileName = dicUploadFile.getFileName();
                jsonFileObject.put("fileName", fileName);
                jsonFileObject.put("id", fileId);
                jsonObjectList.add(jsonFileObject);
            }
        }

        return jsonObjectList;
    }

    /**
     * 删除文件
     * @param id
     */
    @ResponseBody
    @RequestMapping(value = "/delete-file.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteFile(String id) {
        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {

            DicUploadFile dicUploadFile = dicUploadFileService.get(id);

            // 设置要删除的文件状态为2
            if (null != dicUploadFile) {
                dicUploadFile.setStatus(2);
                try {
                    dicUploadFileService.save(dicUploadFile);
                    map.put("result", true);
                } catch (Exception e) {
                    LOG.debug(e.getMessage(), e);
                    map.put("result", false);
                }
            }
        }

        return map;
    }

}
