package com.taiji.frame.controller.foreignaffairs.archivesData;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.archivesData.Document;
import com.taiji.frame.model.entity.foreignaffairs.archivesData.DocumentArchive;
import com.taiji.frame.model.entity.foreignaffairs.archivesData.DocumentFile;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.archivesData.DocumentArchiveVo;
import com.taiji.frame.service.foreignaffairs.archivesData.DocumentArchiveService;
import com.taiji.frame.service.foreignaffairs.archivesData.DocumentFileService;
import com.taiji.frame.service.foreignaffairs.archivesData.DocumentService;
import com.taiji.frame.service.foreignaffairs.archivesData.DocumentTeamService;
import com.taiji.frame.service.systempara.DicDeptService;
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
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 文件管理
 * Created by yuLei on 2018/8/8.
 */
@Controller
@RequestMapping(value = "/document")
public class DocumentController extends BaseController<Document> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private DocumentService documentService;

    @Autowired
    private DocumentTeamService documentTeamService;

    @Autowired
    private DocumentArchiveService documentArchiveService;

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private DocumentFileService documentFileService;

    @Autowired
    private SysLogService sysLogService;


    /**
     * 组装文件表格数据
     * @param carrier
     * @param documentArchiveVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-document-list.do", produces = "text/html;charset=UTF-8")
    public String documentListLoad(Carrier<Document> carrier, DocumentArchiveVo documentArchiveVo) {
        HashMap<String, Object> map = new HashMap();
        carrier.setPageSize(5);
        List<String> teamIds = new ArrayList<>();
        List<String> dmIds;
        try {
            if (null == documentArchiveVo.getType()) {//数据首次加载
                documentService.load(carrier, map);
            } else {
                if (documentArchiveVo.getType().equals("tree")) {//点击树状结构加载
                    if (StringUtils.isNotEmpty(documentArchiveVo.getTeamId())) {
                        if (StringUtils.isNotEmpty(documentArchiveVo.getParentId())) {//点击叶子节点
                            teamIds.add(documentArchiveVo.getTeamId());
                            dmIds = documentArchiveService.findIdsByTeamIds(teamIds, null);
                            if (dmIds.size() > 0) {
                                map.put("dmIds", dmIds);
                            } else {//当前节点没有文件资料信息
                                map.put("dmIds", null);
                            }
                        } else {//点击目录节点
                            List<String> ids = documentTeamService.findIdsByParentId(documentArchiveVo.getTeamId());
                            if (ids.size() > 0) {//当前节点有案卷信息
                                teamIds.addAll(ids);
                                dmIds = documentArchiveService.findIdsByTeamIds(teamIds, null);
                                if (dmIds.size() > 0) {
                                    map.put("dmIds", dmIds);
                                } else {//当前节点没有文件资料信息
                                    map.put("dmIds", null);
                                }
                            } else {//当前节点没有案卷信息，就更不存在文件资料信息
                                map.put("dmIds", null);
                            }
                        }
                    }
                } else {//点击搜索加载
                    if (StringUtils.isNotEmpty(documentArchiveVo.getParentId()) && StringUtils.isNotEmpty(documentArchiveVo.getTeamId())) {//既选择了分类又选择了叶子节点
                        teamIds.add(documentArchiveVo.getTeamId());
                        dmIds = documentArchiveService.findIdsByTeamIds(teamIds, documentArchiveVo);
                        if (dmIds.size() > 0) {
                            map.put("dmIds", dmIds);
                        } else {//当前节点没有文件资料信息
                            map.put("dmIds", null);
                        }
                    } else if (StringUtils.isNotEmpty(documentArchiveVo.getParentId()) && StringUtils.isEmpty(documentArchiveVo.getTeamId())) {//只选择了分类
                        List<String> ids = documentTeamService.findIdsByParentId(documentArchiveVo.getParentId());
                        if (ids.size() > 0) {//有案卷信息
                            teamIds.addAll(ids);
                            dmIds = documentArchiveService.findIdsByTeamIds(teamIds, documentArchiveVo);
                            if (dmIds.size() > 0) {
                                map.put("dmIds", dmIds);
                            } else {//没有文件资料信息
                                map.put("dmIds", null);
                            }
                        } else {//没有案卷信息，就更不存在文件资料信息
                            map.put("dmIds", null);
                        }
                    } else {//既没有选择了分类又没有选择了叶子节点
                        dmIds = documentArchiveService.findIdsByTeamIds(null, documentArchiveVo);
                        if (dmIds.size() > 0) {
                            map.put("dmIds", dmIds);
                        } else {//没有文件资料信息
                            map.put("dmIds", null);
                        }
                    }
                }
                documentService.load(carrier, map);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 详情查看
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/document-view", method = RequestMethod.GET)
    public String view(ModelMap modelMap, String id) {
        if (StringUtils.isNotEmpty(id)) {
            Document document = documentService.get(id);
            modelMap.put("document", document);
            //附件信息
            List<DocumentFile> documentFileList = document.getDocumentFileList();
            if (documentFileList.isEmpty()) {
                modelMap.put("jsonFileList", null);
            } else {
                JSONArray jsonFileList = this.getJsonFileList(documentFileList);
                modelMap.put("jsonFileList", jsonFileList);
            }
        }
        return "foreignaffairs/archivesData/document-view";
    }

    /**
     * 跳转至编辑页面/录入文件
     * @param modelMap
     * @param id
     * @param dmId 档案资料ID
     * @return
     */
    @RequestMapping(value = "/document-edit", method = RequestMethod.GET)
    public String edit(ModelMap modelMap, String id, String dmId) {
        if (!StringUtils.isEmpty(id)) {
            Document document = documentService.get(id);
            DocumentArchive documentArchive = document.getDocumentArchive();
            //附件信息
            List<DocumentFile> documentFileList = document.getDocumentFileList();
            if (documentFileList.isEmpty()) {
                modelMap.put("jsonFileList", null);
            } else {
                JSONArray jsonFileList = this.getJsonFileList(documentFileList);
                modelMap.put("jsonFileList", jsonFileList);
            }
            modelMap.put("document", document);
            modelMap.put("documentArchive", documentArchive);
        }
        DocumentArchive documentArchive = new DocumentArchive();
        if (!StringUtils.isEmpty(dmId)) {
            documentArchive = documentArchiveService.get(dmId);
            modelMap.put("documentArchive", documentArchive);
        }
        //主办单位
        if (null != documentArchive.getDicDept()) {
            DicDept dicDept = documentArchive.getDicDept();
            modelMap.addAttribute("dicDept",dicDept.getJsonObject());
        }
        return "foreignaffairs/archivesData/document-edit";
    }

    /**
     * 保存
     * @param document
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/document-save.do", method = RequestMethod.POST)
    public Map<String, Object> save(@RequestBody Document document, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();

        String dstDir = UploadConstant.document;

        try {
            String id = document.getId();
            if (StringUtils.isNotEmpty(id)) {//编辑
                Document tempDocument = documentService.get(id);
                tempDocument.setDocumentNumber(document.getDocumentNumber());
                tempDocument.setDocumentName(document.getDocumentName());
                tempDocument.setDutyPerson(document.getDutyPerson());
                tempDocument.setFormationDate(document.getFormationDate());
                tempDocument.setPageNumber(document.getPageNumber());
                tempDocument.setDicDept(document.getDicDept());
                tempDocument.setNotes(document.getNotes());
                tempDocument.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                documentService.save(tempDocument);
                //附件上传
                List<DocumentFile> documentFileList = document.getDocumentFileList();
                if (null != documentFileList && documentFileList.size() > 0) {
                    for (DocumentFile documentFile : documentFileList) {
                        String fileId = documentFile.getFileId();
                        DicUploadFile dicUploadFile = dicUploadFileService.get(fileId);
                        dicUploadFileService.transfer(dicUploadFile, dstDir);
                        documentFile.setDocument(document);
                        documentFileService.save(documentFile);
                    }
                }
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("文件管理");
                    sysLogVo.setRecordType(1);
                sysLogVo.setEntityName(tempDocument.getDocumentName());
                sysLogVo.setEntityId(tempDocument.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            } else {//新增
                document.setDelFlag("0");
                document.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                document.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                documentService.save(document);
                //附件上传
                List<DocumentFile> documentFileList = document.getDocumentFileList();
                if (null != documentFileList && documentFileList.size() > 0) {
                    for (DocumentFile documentFile : documentFileList) {
                        String fileId = documentFile.getFileId();
                        DicUploadFile dicUploadFile = dicUploadFileService.get(fileId);
                        dicUploadFileService.transfer(dicUploadFile, dstDir);
                        documentFile.setDocument(document);
                        documentFileService.save(documentFile);
                    }
                }
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("文件管理");
                    sysLogVo.setRecordType(0);
                sysLogVo.setEntityName(document.getDocumentName());
                sysLogVo.setEntityId(document.getId());
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
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/document-delete.do", method = RequestMethod.POST)
    public Map<String, Object> delete(String id) {
        HashMap<String, Object> map = new HashMap();
        try {
            if (StringUtils.isNotEmpty(id)) {
                Document document = documentService.get(id);
                document.setDelFlag("1");
                documentService.save(document);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("文件管理");
                sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(document.getDocumentName());
                sysLogVo.setEntityId(document.getId());
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
     * 附件删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/document-file-delete.do", method = RequestMethod.POST)
    public Map<String, Object> documentFileDelete(String id) {
        HashMap<String, Object> map = new HashMap();
        try {
            if (StringUtils.isNotEmpty(id)) {
                DocumentFile documentFile = documentFileService.findDocumentFileByFileId(id);
                DicUploadFile dicUploadFile = dicUploadFileService.get(id);
                String path = dicUploadFile.getPath();
                documentFileService.delete(documentFile.getId());
                File file = new File(path);
                if(file.exists()) {
                    file.delete();
                    map.put("result", true);
                    SysLogVo sysLogVo = getSysLogVo();
                    sysLogVo.setTypeName("附件删除");
                    sysLogVo.setRecordType(2);
                    sysLogVo.setEntityName(documentFile.getFileName());
                    sysLogVo.setEntityId(documentFile.getId());
                    sysLogVo.setResult("true");
                    sysLogService.record(sysLogVo);
                }else{
                    map.put("result", false);
                }
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    private JSONArray getJsonFileList(List<DocumentFile> documentFileList) {
        JSONArray jsonArray = new JSONArray();
        for (DocumentFile documentFile : documentFileList) {
            JSONObject jsonObject = new JSONObject();
            String fileId = documentFile.getFileId();
            String fileName = documentFile.getFileName();
            jsonObject.put("id", fileId);
            jsonObject.put("fileName", fileName);
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

}
