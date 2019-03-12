package com.taiji.frame.controller.foreignaffairs.come;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeReport;
import com.taiji.frame.model.entity.foreignaffairs.come.ReportFile;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeReportVo;
import com.taiji.frame.service.foreignaffairs.come.ComeInfoService;
import com.taiji.frame.service.foreignaffairs.come.ComeReportService;
import com.taiji.frame.service.foreignaffairs.come.ReportFileService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSONArray;
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
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 来访简报
 *
 * @author yx
 */
@Controller
@RequestMapping(value = "/come/come-report")
public class ComeReportController extends BaseController<ComeReport> {

    private static final Logger LOG = LoggerFactory.getLogger(ComeReportController.class);

    @Autowired
    ComeReportService comeReportService;

    @Autowired
    ComeInfoService comeInfoService;

    @Autowired
    UtilService utilService;

    @Autowired
    DicUploadFileService dicUploadFileService;

    @Autowired
    ReportFileService reportFileService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 加载来访简报页面
     * @param modelMap
     * @param comeInfoId
     * @return
     */
    @RequestMapping(value = "/load-come-report", method = RequestMethod.GET)
    public String loadReport(ModelMap modelMap, String comeInfoId) {

        if (StringUtils.isNotEmpty(comeInfoId)) {
            ComeInfo comeInfo = comeInfoService.get(comeInfoId);
            List<ComeReport> comeReports = comeReportService.findReport(comeInfoId);
            List<ReportFile> reportFiles = new ArrayList<>();

            if (comeReports != null && comeReports.size() > 0) {
                for (ComeReport report : comeReports) {
                    List<ReportFile> files = reportFileService.findByReportId(report.getId());
                    reportFiles.addAll(files);
                }
            }

            List<JSONObject> reportFileList = getReportFileData(reportFiles);

            modelMap.addAttribute("comeInfoId", comeInfoId);
            modelMap.addAttribute("reportFileList", reportFileList);
            modelMap.addAttribute("startDate", DateUtil.dateToString(comeInfo.getStartDate(), DateUtil.FORMAT_DAY));
            modelMap.addAttribute("endDate", DateUtil.dateToString(comeInfo.getEndDate(), DateUtil.FORMAT_DAY));
        }

        return "foreignaffairs/come/come-report-list";
    }

    /**
     * load grid 来访简报表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-report-list.do", produces = "text/html;charset=UTF-8")
    public String loadAccompanyList(Carrier<ComeReport> carrier, String comeInfoId) {
        HashMap map = new HashMap(1);
        try {
            if (!StringUtils.isEmpty(comeInfoId)) {
                map.put("comeInfoId", comeInfoId);
            }
            comeReportService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }


    /**
     * 加载简报编辑页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-report-edit", method = RequestMethod.GET)
    public String loadReportEdit(ModelMap modelMap, String id) {

        if (StringUtils.isNotEmpty(id)) {
            ComeReport comeReport = comeReportService.get(id);
            List<ReportFile> reportFiles = new ArrayList<>();

            String comeInfoId = null;
            if (comeReport != null) {
                List<ReportFile> files = reportFileService.findByReportId(comeReport.getId());
                reportFiles.addAll(files);
                comeInfoId = comeReport.getComeInfo().getId();
            }

            List<JSONObject> reportFileList = getReportFileData(reportFiles);

            modelMap.addAttribute("comeInfoId", comeInfoId);
            modelMap.addAttribute("comeReport", comeReport);
            modelMap.addAttribute("reportFileList", reportFileList);
        }

        return "foreignaffairs/come/come-report-edit";
    }

    /**
     * 新增/编辑
     */
    @ResponseBody
    @RequestMapping(value = "/report-edit.do", method = RequestMethod.POST)
    public Map<String, Object> saveReport(ComeReportVo comeReportVo, HttpServletRequest request) {

        Map<String, Object> map = new HashMap<>(1);

        String dstDir = UploadConstant.comeReport;

        ComeReport comeReport = null;
        try {
            comeReport = comeReportService.saveReport(comeReportVo,getSysLogVo());
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
            return map;
        }

        String fileIds = comeReportVo.getFileIds();

        if (!StringUtils.isEmpty(fileIds)) {
            JSONArray jsonArray = JSONArray.fromObject(fileIds);
            for (int i=0; i < jsonArray.size(); i++) {
                JSONObject jsonObject = JSONObject.fromObject(jsonArray.get(i));
                String fileId = String.valueOf(jsonObject.get("fileId"));
                DicUploadFile uploadFile = dicUploadFileService.get(fileId);

                // 转移来访简报文件到正式文件夹
                try {
                    dicUploadFileService.transfer(uploadFile, dstDir);
                    comeReportService.saveReportFile(comeReport, uploadFile);
                } catch (Exception e) {
                    LOG.debug(e.getMessage(), e);
                    map.put("result", false);
                    return map;
                }
            }
        }

        map.put("result", true);

        return map;
    }

    /**
     * 删除一条陪同人员记录
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/report-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteReport(String id) {
        Map<String, Object> map = new HashMap<>(1);

        try {
            ComeReport comeReport = comeReportService.get(id);
            comeReport.setDelFlag("1");
            comeReportService.save(comeReport);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("陪同人员记录");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(comeReport.getTitle());
            sysLogVo.setEntityId(comeReport.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 获取来访简报的文件列表
     *
     * @param modelMap
     * @param id
     */
    @ResponseBody
    @RequestMapping(value = "/get-report-file-list.do", method = RequestMethod.POST)
    public Map<String, Object> getReceptionFileList(ModelMap modelMap, String id) {
        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {
            ComeReport comeReport = comeReportService.get(id);
            List<ReportFile> receptionFiles = new ArrayList<>();
            if (null != comeReport) {
                List<ReportFile> files = reportFileService.findByReportId(comeReport.getId());
                receptionFiles.addAll(files);
            }

            List<JSONObject> reportFileList = getReportFileData(receptionFiles);
            map.put("reportFileList", reportFileList);
        }

        return map;
    }


    /**
     * 获取简报文件信息
     * @param fileList
     * @return
     */
    private List<JSONObject> getReportFileData(List<ReportFile> fileList) {

        if (null == fileList || fileList.size() == 0) {
            return null;
        }
        List<JSONObject> jsonObjectList = new ArrayList<>();
        for (ReportFile file : fileList) {

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
