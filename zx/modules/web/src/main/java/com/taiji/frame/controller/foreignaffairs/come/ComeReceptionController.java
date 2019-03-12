package com.taiji.frame.controller.foreignaffairs.come;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.rtf.RtfWriter2;
import com.lowagie.text.rtf.style.RtfFont;
import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.FileUtil;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeReception;
import com.taiji.frame.model.entity.foreignaffairs.come.ReceptionFile;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeReceptionVo;
import com.taiji.frame.service.foreignaffairs.come.ComeInfoService;
import com.taiji.frame.service.foreignaffairs.come.ComeReceptionService;
import com.taiji.frame.service.foreignaffairs.come.ReceptionFileService;
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
import javax.servlet.http.HttpServletResponse;
import javax.swing.filechooser.FileSystemView;
import java.awt.*;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;
import java.util.List;

/**
 * 来访接待计划
 *
 * @author yx
 */
@Controller
@RequestMapping(value = "/come/come-reception")
public class ComeReceptionController extends BaseController<ComeReception> {

    private static final Logger LOG = LoggerFactory.getLogger(ComeReceptionController.class);

    @Autowired
    ComeReceptionService comeReceptionService;

    @Autowired
    ComeInfoService comeInfoService;

    @Autowired
    UtilService utilService;

    @Autowired
    DicUploadFileService dicUploadFileService;

    @Autowired
    ReceptionFileService receptionFileService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 加载来访接待计划页面
     *
     * @param modelMap
     * @param comeInfoId
     * @return
     */
    @RequestMapping(value = "/load-come-reception", method = RequestMethod.GET)
    public String loadReceptionList(ModelMap modelMap, String comeInfoId) {
        if (StringUtils.isNotEmpty(comeInfoId)) {
            List<ComeReception> comeReceptions = comeReceptionService.findReception(comeInfoId);
            List<ReceptionFile> receptionFiles = new ArrayList<>();
            if (null != comeReceptions && comeReceptions.size() > 0) {
                for (ComeReception reception : comeReceptions) {
                    List<ReceptionFile> files = receptionFileService.findByReceptionId(reception.getId());
                    receptionFiles.addAll(files);
                }
            }
            List<JSONObject> receptionFileList = getReceptionFileData(receptionFiles);
            modelMap.addAttribute("receptionFileList", receptionFileList);
            modelMap.addAttribute("comeInfoId", comeInfoId);
        }

        return "foreignaffairs/come/come-reception-list";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-reception-list.do", produces = "text/html;charset=UTF-8")
    public String groupListLoad(Carrier<ComeReception> carrier, ComeReceptionVo comeReceptionVo) {
        HashMap map = new HashMap(1);
        try {
            if (!StringUtils.isEmpty(comeReceptionVo.getComeInfoId())) {
                map.put("comeInfoId", comeReceptionVo.getComeInfoId());
            }
            comeReceptionService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 加载来访接待计划编辑页面
     *
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-reception-edit", method = RequestMethod.GET)
    public String loadReceptionEdit(ModelMap modelMap, String id) {

        if (StringUtils.isNotEmpty(id)) {
            ComeReception comeReception = comeReceptionService.get(id);
            List<ReceptionFile> receptionFiles = new ArrayList<>();
            if (null != comeReception) {
                List<ReceptionFile> files = receptionFileService.findByReceptionId(comeReception.getId());
                receptionFiles.addAll(files);
            }

            modelMap.addAttribute("comeReception", comeReception);
            List<JSONObject> receptionFileList = getReceptionFileData(receptionFiles);
            modelMap.addAttribute("receptionFileList", receptionFileList);
        }

        return "foreignaffairs/come/come-reception-edit";
    }

    /**
     * 获取接待计划的文件列表
     *
     * @param modelMap
     * @param id
     */
    @ResponseBody
    @RequestMapping(value = "/get-reception-file-list.do", method = RequestMethod.POST)
    public Map<String, Object> getReceptionFileList(ModelMap modelMap, String id) {
        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {
            ComeReception comeReception = comeReceptionService.get(id);
            List<ReceptionFile> receptionFiles = new ArrayList<>();
            if (null != comeReception) {
                List<ReceptionFile> files = receptionFileService.findByReceptionId(comeReception.getId());
                receptionFiles.addAll(files);
            }

            List<JSONObject> receptionFileList = getReceptionFileData(receptionFiles);
            map.put("receptionFileList", receptionFileList);
        }

        return map;
    }


    /**
     * 新增/编辑
     */
    @ResponseBody
    @RequestMapping(value = "/reception-edit.do", method = RequestMethod.POST)
    public Map<String, Object> saveReception(ComeReceptionVo comeReceptionVo, HttpServletRequest request) {

        Map<String, Object> map = new HashMap<>(1);

        String dstDir = UploadConstant.comeReception;

        ComeReception comeReception = null;

        try {
            SysLogVo sysLogVo = getSysLogVo();
            comeReception = comeReceptionService.saveReception(comeReceptionVo,sysLogVo);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
            return map;
        }


        String fileIds = comeReceptionVo.getFileIds();
        if (!StringUtils.isEmpty(fileIds)) {
            JSONArray jsonArray = JSONArray.fromObject(fileIds);
            for (int i = 0; i < jsonArray.size(); i++) {
                JSONObject jsonObject = JSONObject.fromObject(jsonArray.get(i));
                String fileId = String.valueOf(jsonObject.get("fileId"));
                DicUploadFile uploadFile = dicUploadFileService.get(fileId);

                // 转移来访接待计划文件到正式文件夹
                try {
                    dicUploadFileService.transfer(uploadFile, dstDir);
                    comeReceptionService.saveReceptionFile(comeReception, uploadFile);
                } catch (Exception e) {
                    e.printStackTrace();
                    map.put("result", false);
                    return map;
                }
            }
        }

        map.put("result", true);

        return map;
    }


    /**
     * 删除接待计划
     */
    @ResponseBody
    @RequestMapping(value = "/reception-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteReception(String id) {
        Map<String, Object> map = new HashMap<>(1);

        try {
            ComeReception reception = comeReceptionService.get(id);
            reception.setDelFlag("1");
            comeReceptionService.save(reception);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("接待计划");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(reception.getReceptionTitle());
            sysLogVo.setEntityId(reception.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 获取接待计划文件信息
     *
     * @param fileList
     * @return
     */
    private List<JSONObject> getReceptionFileData(List<ReceptionFile> fileList) {

        if (null == fileList || fileList.size() == 0) {
            return null;
        }
        List<JSONObject> jsonObjectList = new ArrayList<>();
        for (ReceptionFile file : fileList) {

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

    /**
     * 导出Word文件
     */
    @ResponseBody
    @RequestMapping(value = "/come-reception-export.do", method = RequestMethod.POST)
    public Map<String, Object> exportWord(String comeInfoId, HttpServletRequest request,
                                          HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>(1);
        if (StringUtils.isNotEmpty(comeInfoId)) {
            ComeInfo comeInfo = comeInfoService.get(comeInfoId);
            List<ComeReception> comeReceptionList = comeReceptionService.findReception(comeInfoId);
            //导出Word
            try {
                this.export(comeInfo, comeReceptionList, request, response);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("接待计划");
                sysLogVo.setRecordType(7);
                sysLogVo.setEntityName("");
                sysLogVo.setEntityId("");
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            } catch (DocumentException e) {
                LOG.debug(e.getMessage(), e);
                map.put("result", false);
            } catch (IOException e) {
                LOG.debug(e.getMessage(), e);
                map.put("result", false);
            }
        }

        return map;
    }


    /**
     * 导出Word文件
     *
     * @param comeReceptionList
     * @param request
     * @throws DocumentException
     * @throws IOException
     */
    private void export(ComeInfo comeInfo, List<ComeReception> comeReceptionList,
                        HttpServletRequest request, HttpServletResponse response)
            throws DocumentException, IOException {
        String lineSeparator = System.getProperty("line.separator", "\n");

        //设置纸张大小
        Document document = new Document(PageSize.A4, 90.0F, 90.0F, 72.0F, 72.0F);

        // 创建临时文件
        String uploadPath = request.getSession().getServletContext().getRealPath("upload");
        File f = new File(uploadPath);
        //文件夹不存在
        if(!f.exists())
        {
            f.mkdirs();
        }
        String fileName =  comeInfo.getGroupName() + "接待计划.doc";
        String temp = uploadPath + File.separator + fileName;
        File file = new File(temp);

        RtfWriter2.getInstance(document, new FileOutputStream(file));
        document.open();


        //设置标题字体风格
        RtfFont titleFont = new RtfFont("华文中宋", 22, Font.BOLD, Color.BLACK);

        //设置正文字体风格
        float contextFontSize = 12;
        RtfFont contextFont = new RtfFont("宋体", contextFontSize, Font.NORMAL);

        String titleStr = comeInfo.getGroupName() + "接待计划";
        Paragraph title = new Paragraph(titleStr);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setFont(titleFont);
        title.setSpacingAfter(contextFontSize * 3);

        document.add(title);

        // 任务描述
        String taskDscrStr = comeInfo.getTaskDscr();

        String[] taskDscrPara = taskDscrStr.split(lineSeparator);
        for(String para : taskDscrPara) {
            if (StringUtils.isNotEmpty(para)) {
                Paragraph p = new Paragraph(para);
                p.setAlignment(Element.ALIGN_LEFT);
                p.setFont(contextFont);
                p.setFirstLineIndent(contextFontSize * 2);
                p.setSpacingBefore(contextFontSize / 2);

                document.add(p);
            }
        }

        int count = 0;
        for (ComeReception comeReception : comeReceptionList) {

            count += 1;
            String seq = num2Chinese(count);
            String childTitleStr = comeReception.getReceptionTitle();
            Paragraph childTitle = new Paragraph(seq + "、" + childTitleStr);
            childTitle.setFont(contextFont);
            childTitle.setFirstLineIndent(contextFontSize * 2);
            childTitle.setSpacingBefore(contextFontSize / 2);
            document.add(childTitle);

            String activityStr = comeReception.getActivityPlan();

            String[] activityPara = activityStr.split(lineSeparator);
            for (String para : activityPara) {
                Paragraph activity = new Paragraph(para);
                activity.setAlignment(Element.ALIGN_LEFT);
                activity.setFont(contextFont);
                activity.setFirstLineIndent(contextFontSize * 2);
                activity.setSpacingBefore(contextFontSize / 2);

                document.add(activity);
            }
        }

        document.close();

        FileUtil.downOrPreview(fileName, temp, response, request,"0");

        file.delete();
    }

    private String num2Chinese(int num) {
        String chineseNum = "一二三四五六七八九十";

        String result;
        if (num <= 10) {
            result = String.valueOf(chineseNum.charAt(num - 1));
        } else {
            result = "十" + String.valueOf(chineseNum.charAt(num % 10 - 1));
        }

        return result;
    }
}
