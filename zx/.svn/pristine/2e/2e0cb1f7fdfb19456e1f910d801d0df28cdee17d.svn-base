package com.taiji.frame.controller.foreignaffairs.archivesData;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.archivesData.Document;
import com.taiji.frame.model.entity.foreignaffairs.archivesData.DocumentArchive;
import com.taiji.frame.model.entity.foreignaffairs.archivesData.DocumentFile;
import com.taiji.frame.model.entity.foreignaffairs.archivesData.DocumentTeam;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.archivesData.DocumentArchiveVo;
import com.taiji.frame.service.foreignaffairs.archivesData.DocumentArchiveService;
import com.taiji.frame.service.foreignaffairs.archivesData.DocumentService;
import com.taiji.frame.service.foreignaffairs.archivesData.DocumentTeamService;
import com.taiji.frame.service.systempara.DicDeptService;
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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 案卷分组
 * Created by yuLei on 2018/8/6.
 */
@Controller
@RequestMapping(value = "/document-archive")
public class DocumentArchiveController extends BaseController<DocumentArchive> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private DocumentArchiveService documentArchiveService;

    @Autowired
    private DocumentTeamService documentTeamService;

    @Autowired
    private DocumentService documentService;

    @Autowired
    private SysLogService sysLogService;


    /**
     * 跳转至列表页
     * @param map
     * @return
     */
    @RequestMapping(value = "/document-archive-list", method = RequestMethod.GET)
    public String list(Map<String, Object> map) {
        JSONArray zTreeData =new JSONArray();
        List<DocumentTeam> documentTeamList = documentTeamService.findDocumentTeamList();
        for (DocumentTeam team : documentTeamList) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", team.getId());
            jsonObject.put("pId", team.getParentId());
            jsonObject.put("name", team.getTeamName());
            jsonObject.put("open", true);
            zTreeData.add(jsonObject);
        }
        map.put("zTreeData", zTreeData);
        //案卷分类父类目录节点
        List<DocumentTeam> parentDocumentTeamList = documentTeamService.findDocumentTeamByNullParentId();
        map.put("parentDocumentTeamList", parentDocumentTeamList);
        return "foreignaffairs/archivesData/document-archive-list";
    }

    /**
     * 组装案卷表格数据
     * @param carrier
     * @param documentArchiveVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-document-archive-list.do", produces = "text/html;charset=UTF-8")
    public String documentArchiveListLoad(Carrier<DocumentArchive> carrier, DocumentArchiveVo documentArchiveVo) {
        HashMap<String, Object> map = new HashMap();
        carrier.setPageSize(5);
        try {
            if (null == documentArchiveVo.getType()) {//数据首次加载
                documentArchiveService.load(carrier, map);
            } else {
                if (documentArchiveVo.getType().equals("tree")) {//点击树状结构加载
                    if (StringUtils.isNotEmpty(documentArchiveVo.getTeamId())) {
                        if (StringUtils.isNotEmpty(documentArchiveVo.getParentId())) {//点击叶子节点
                            map.put("teamId", documentArchiveVo.getTeamId());
                        } else {//点击目录节点
                            List<String> ids = documentTeamService.findIdsByParentId(documentArchiveVo.getTeamId());
                            if (ids.size() > 0) {
                                map.put("teamId", ids);
                            } else {//当前节点没有案卷资料信息
                                map.put("teamId", null);
                            }
                        }
                    }
                } else {//点击搜索加载
                    if (StringUtils.isNotEmpty(documentArchiveVo.getParentId()) && StringUtils.isNotEmpty(documentArchiveVo.getTeamId())) {//既选择了分类又选择了叶子节点
                        map.put("teamId", documentArchiveVo.getTeamId());
                    } else if (StringUtils.isNotEmpty(documentArchiveVo.getParentId()) && StringUtils.isEmpty(documentArchiveVo.getTeamId())) {//只选择了分类
                        List<String> ids = documentTeamService.findIdsByParentId(documentArchiveVo.getParentId());
                        if (ids.size() > 0) {
                            map.put("teamId", ids);
                        } else {//没有案卷资料信息
                            map.put("teamId", null);
                        }
                    }
                    if (StringUtils.isNotEmpty(documentArchiveVo.getFondsNumber())) {
                        map.put("fondsNumber", documentArchiveVo.getFondsNumber());
                    }
                    if (StringUtils.isNotEmpty(documentArchiveVo.getFileNumber())) {
                        map.put("fileNumber", documentArchiveVo.getFileNumber());
                    }
                    if (StringUtils.isNotEmpty(documentArchiveVo.getArchiveNumber())) {
                        map.put("archiveNumber", documentArchiveVo.getArchiveNumber());
                    }
                    if (StringUtils.isNotEmpty(documentArchiveVo.getCatalogNumber())) {
                        map.put("catalogNumber", documentArchiveVo.getCatalogNumber());
                    }
                    if (StringUtils.isNotEmpty(documentArchiveVo.getSecretLevel())) {
                        map.put("secretLevel", documentArchiveVo.getSecretLevel());
                    }
                    if (StringUtils.isNotEmpty(documentArchiveVo.getFileName())) {
                        map.put("fileName", "%" + documentArchiveVo.getFileName() + "%");
                    }
                    if (StringUtils.isNotEmpty(documentArchiveVo.getRetentionPeriod())) {
                        map.put("retentionPeriod", documentArchiveVo.getRetentionPeriod());
                    }
                    if (StringUtils.isNotEmpty(documentArchiveVo.getStartTime()) && StringUtils.isNotEmpty(documentArchiveVo.getEndTime())) {
                        map.put("startTime", documentArchiveVo.getStartTime());
                        map.put("endTime", documentArchiveVo.getEndTime());
                    }
                }
                documentArchiveService.load(carrier, map);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 添加父节点
     * @param teamName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/add-parent-node.do", method = RequestMethod.POST)
    public Map<String, Object> addParentNode(String teamName) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(teamName)) {
                DocumentTeam documentTeam = new DocumentTeam();
                documentTeam.setTeamName(teamName);
                documentTeam.setDicUser(getCurUser());
                documentTeam.setIsLeaf("0");
                documentTeam.setDelFlag("0");
                documentTeam.setParentId(null);
                documentTeam.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                documentTeamService.save(documentTeam);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("案卷管理添加父节点");
                    sysLogVo.setRecordType(0);
                sysLogVo.setEntityName(teamName);
                sysLogVo.setEntityId(documentTeam.getId());
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
     * 添加子节点
     * @param parentId
     * @param teamName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/add-child-node.do", method = RequestMethod.POST)
    public Map<String, Object> addChildNode(String parentId, String teamName) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(parentId) && StringUtils.isNotEmpty(teamName)) {
                DocumentTeam documentTeam = new DocumentTeam();
                documentTeam.setTeamName(teamName);
                documentTeam.setDicUser(getCurUser());
                documentTeam.setIsLeaf("1");
                documentTeam.setDelFlag("0");
                documentTeam.setParentId(parentId);
                documentTeam.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                documentTeamService.save(documentTeam);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("案卷管理添加子节点");
                sysLogVo.setRecordType(0);
                sysLogVo.setEntityName(teamName);
                sysLogVo.setEntityId(documentTeam.getId());
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
     * 修改节点名称
     * @param nodeId
     * @param teamName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/update-node-name.do", method = RequestMethod.POST)
    public Map<String, Object> updateNodeName(String nodeId, String teamName) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(nodeId) && StringUtils.isNotEmpty(teamName)) {
                DocumentTeam documentTeam = documentTeamService.get(nodeId);
                String tempTeamName = documentTeam.getTeamName();
                if (teamName.equals(tempTeamName)) {
                    map.put("result", "noChange");
                } else {
                    documentTeam.setTeamName(teamName);
                    documentTeamService.save(documentTeam);
                    map.put("result", true);
                    SysLogVo sysLogVo = getSysLogVo();
                    sysLogVo.setTypeName("案卷管理");
                    sysLogVo.setRecordType(1);
                    sysLogVo.setEntityName(teamName);
                    sysLogVo.setEntityId(documentTeam.getId());
                    sysLogVo.setResult("true");
                    sysLogService.record(sysLogVo);
                }
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 删除节点
     * @param nodeId
     * @param nodeType
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete-node.do", method = RequestMethod.POST)
    public Map<String, Object> deleteNode(String nodeId, String nodeType) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(nodeId) && StringUtils.isNotEmpty(nodeType)) {
                if (nodeType.equals("parent")) {
                    Boolean isExistChildNode = documentTeamService.findDocumentTeamByParentId(nodeId);
                    if (isExistChildNode) {
                        map.put("result", "existChild");
                    } else {
                        DocumentTeam documentTeam = documentTeamService.get(nodeId);
                        documentTeam.setDelFlag("1");
                        documentTeamService.save(documentTeam);
                        map.put("result", true);
                        SysLogVo sysLogVo = getSysLogVo();
                        sysLogVo.setTypeName("案卷管理");
                        sysLogVo.setRecordType(2);
                        sysLogVo.setEntityName(documentTeam.getTeamName());
                        sysLogVo.setEntityId(documentTeam.getId());
                        sysLogVo.setResult("true");
                        sysLogService.record(sysLogVo);
                    }
                } else if (nodeType.equals("child")) {
                    Boolean isExistData = documentArchiveService.findDocumentArchiveByTeamId(nodeId);
                    if (isExistData) {
                        map.put("result", "existData");
                    } else {
                        DocumentTeam documentTeam = documentTeamService.get(nodeId);
                        documentTeam.setDelFlag("1");
                        documentTeamService.save(documentTeam);
                        map.put("result", true);
                        SysLogVo sysLogVo = getSysLogVo();
                        sysLogVo.setTypeName("案卷管理");
                        sysLogVo.setRecordType(2);
                        sysLogVo.setEntityName(documentTeam.getTeamName());
                        sysLogVo.setEntityId(documentTeam.getId());
                        sysLogVo.setResult("true");
                        sysLogService.record(sysLogVo);
                    }
                }

            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 详情查看
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/document-archive-view", method = RequestMethod.GET)
    public String view(ModelMap modelMap, String id) {
        if (StringUtils.isNotEmpty(id)) {
            DocumentArchive documentArchive = documentArchiveService.get(id);
            List<Document> tempDocumentList = documentArchive.getDocumentList();
            List<Document> documentList = new ArrayList<>();
            for (Document document : tempDocumentList) {
                if (document.getDelFlag().equals("0")) {
                    documentList.add(document);
                }
            }
            modelMap.put("documentArchive", documentArchive);
            modelMap.put("documentList", documentList);
            //附件信息
            JSONArray jsonFileList = this.getJsonFileList(documentList);
            if (jsonFileList.isEmpty()) {
                modelMap.put("jsonFileList", null);
            } else {
                modelMap.put("jsonFileList", jsonFileList);
            }
        }
        return "foreignaffairs/archivesData/document-archive-view";
    }

    /**
     * 跳转至编辑页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/document-archive-edit", method = RequestMethod.GET)
    public String edit(ModelMap modelMap, String id) {

        DocumentArchive documentArchive = new DocumentArchive();

        if (!StringUtils.isEmpty(id)) {
            documentArchive = documentArchiveService.get(id);
            modelMap.put("documentArchive", documentArchive);
        }
        //案卷分类父类目录节点
        List<DocumentTeam> parentDocumentTeamList = documentTeamService.findDocumentTeamByNullParentId();
        modelMap.put("parentDocumentTeamList", parentDocumentTeamList);

        //部门信息
        DicDept dicDept = new DicDept();
        if (null != documentArchive.getDicDept()) {
            dicDept = documentArchive.getDicDept();
        }
        modelMap.addAttribute("dicDept",dicDept.getJsonObject());

        return "foreignaffairs/archivesData/document-archive-edit";
    }

    /**
     * 选中父节点带出对应的子节点
     * @param parentId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/find-child-node.do", method = RequestMethod.POST)
    public Map<String, Object> findChildNodeByParentId(String parentId) {
        Map<String, Object> map = new HashMap<>();
        List<DocumentTeam> childDocumentTeamList;
        try {
            if (StringUtils.isNotEmpty(parentId)) {
                childDocumentTeamList = documentTeamService.findChildNodeByParentId(parentId);
                if (null != childDocumentTeamList && childDocumentTeamList.size() > 0) {
                    map.put("childDocumentTeamList", childDocumentTeamList);
                } else {
                    map.put("childDocumentTeamList", "empty");
                }
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return map;
    }

    /**
     * 保存
     * @param documentArchive
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/document-archive-save.do", method = RequestMethod.POST)
    public Map<String, Object> save(@RequestBody DocumentArchive documentArchive) {
        Map<String, Object> map = new HashMap<>();
        try {
            String id = documentArchive.getId();
            if (StringUtils.isNotEmpty(id)) {//编辑
                DocumentArchive tempDocumentArchive = documentArchiveService.get(id);
                tempDocumentArchive.setDocumentTeam(documentArchive.getDocumentTeam());
                tempDocumentArchive.setDicDept(documentArchive.getDicDept());
                tempDocumentArchive.setFondsNumber(documentArchive.getFondsNumber());
                tempDocumentArchive.setCatalogNumber(documentArchive.getCatalogNumber());
                tempDocumentArchive.setFileNumber(documentArchive.getFileNumber());
                tempDocumentArchive.setArchiveNumber(documentArchive.getArchiveNumber());
                tempDocumentArchive.setYear(documentArchive.getYear());
                tempDocumentArchive.setRetentionPeriod(documentArchive.getRetentionPeriod());
                tempDocumentArchive.setFileName(documentArchive.getFileName());
                tempDocumentArchive.setFileSum(documentArchive.getFileSum());
                tempDocumentArchive.setPageSum(documentArchive.getPageSum());
                tempDocumentArchive.setCompileDate(documentArchive.getCompileDate());
                tempDocumentArchive.setEndDate(documentArchive.getEndDate());
                tempDocumentArchive.setWriter(documentArchive.getWriter());
                tempDocumentArchive.setSecretLevel(documentArchive.getSecretLevel());
                tempDocumentArchive.setRummager(documentArchive.getRummager());
                tempDocumentArchive.setRummagerDate(documentArchive.getRummagerDate());
                tempDocumentArchive.setContent(documentArchive.getContent());
                tempDocumentArchive.setNotes(documentArchive.getNotes());
                tempDocumentArchive.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                documentArchiveService.save(tempDocumentArchive);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("案卷管理");
                    sysLogVo.setRecordType(1);
                sysLogVo.setEntityName(tempDocumentArchive.getFileName());
                sysLogVo.setEntityId(tempDocumentArchive.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            } else {//新增
                documentArchive.setDelFlag("0");
                documentArchive.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                documentArchive.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                documentArchiveService.save(documentArchive);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("案卷管理");
                    sysLogVo.setRecordType(0);
                sysLogVo.setEntityName(documentArchive.getFileName());
                sysLogVo.setEntityId(documentArchive.getId());
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
    @RequestMapping(value = "/document-archive-delete.do", method = RequestMethod.POST)
    public Map<String, Object> delete(String id) {
        HashMap<String, Object> map = new HashMap();
        try {
            if (StringUtils.isNotEmpty(id)) {
                DocumentArchive documentArchive = documentArchiveService.get(id);
                List<Document> documentList = documentService.findByArchiveId(id);
                if (null != documentList && documentList.size() > 0) {
                    map.put("result", "existDocument");
                } else {
                    documentArchive.setDelFlag("1");
                    documentArchiveService.save(documentArchive);
                    map.put("result", true);
                    SysLogVo sysLogVo = getSysLogVo();
                    sysLogVo.setTypeName("案卷管理");
                    sysLogVo.setRecordType(2);
                    sysLogVo.setEntityName(documentArchive.getFileName());
                    sysLogVo.setEntityId(documentArchive.getId());
                    sysLogVo.setResult("true");
                    sysLogService.record(sysLogVo);
                }
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    private JSONArray getJsonFileList(List<Document> documentList) {
        JSONArray jsonArray = new JSONArray();
        for (Document document : documentList) {
            List<DocumentFile> documentFileList = document.getDocumentFileList();
            if (!documentFileList.isEmpty()) {
                for (DocumentFile documentFile : documentFileList) {
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("id", documentFile.getFileId());
                    jsonObject.put("fileName", documentFile.getFileName());
                    jsonArray.add(jsonObject);
                }
            }
        }
        return jsonArray;
    }

}
