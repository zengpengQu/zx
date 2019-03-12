package com.taiji.frame.controller.foreignaffairs.come;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.rtf.RtfWriter2;
import com.lowagie.text.rtf.style.RtfFont;
import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.FileUtil;
import com.taiji.frame.model.entity.foreignaffairs.come.*;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeInfoVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeVisitorVo;
import com.taiji.frame.service.foreignaffairs.come.*;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicParamService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import java.awt.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;
import java.util.List;

/**
 * @author yx
 * 来访管理
 */
@Controller
@RequestMapping(value = "/come")
public class ComeInfoController extends BaseController<ComeInfo> {
    private static final Logger LOG = LoggerFactory.getLogger(ComeInfoController.class);

    @Autowired
    private ComeInfoService comeInfoService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    DicUploadFileService dicUploadFileService;

    @Autowired
    ReceptionFileService receptionFileService;

    @Autowired
    ComeReceptionService comeReceptionService;

    @Autowired
    ComeSchedulesService comeSchedulesService;

    @Autowired
    ComeAccompanyService comeAccompanyService;

    @Autowired
    ComeVisitorService comeVisitorService;

    @Autowired
    ComeReportService comeReportService;
    @Autowired
    private SysLogService sysLogService;
    /**
     * 页面跳转
     */
    @RequestMapping(value = "/come-info-list", method = RequestMethod.GET)
    public String list(Map<String, Object> map) {

        //系统时间
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        map.put("sysDate", sysDate);

        return "foreignaffairs/come/come-info-list";
    }

    /**
     * 页面跳转至编辑页面
     */
    @RequestMapping(value = "/load-come-info-edit", method = RequestMethod.GET)
    public String edit(ModelMap modelMap, String id) {

        // 邀请名义
        List<DicParam> inviteList = dicParamService.getParamByGroupId(1);
        modelMap.addAttribute("inviteList", inviteList);

        // 团组级别
        List<DicParam> levelList = dicParamService.getParamByGroupId(2);
        modelMap.addAttribute("levelList", levelList);

        ComeInfo comeInfo = null;
        //部门信息
        DicDept dicDept = new DicDept();
        if (!StringUtils.isEmpty(id)) {
            comeInfo = comeInfoService.get(id);
            if (null != comeInfo.getDicDept()) {
                dicDept = comeInfo.getDicDept();
            }
        }
        modelMap.addAttribute("comeInfo", comeInfo);
        modelMap.addAttribute("dicDept",dicDept.getJsonObject());

        return "foreignaffairs/come/come-info-edit";
    }

    /**
     * 页面跳转至来访详细信息编辑页面
     */
    @RequestMapping(value = "/load-come-info-edit-more", method = RequestMethod.GET)
    public String editMore(ModelMap modelMap, String id) {
        ComeInfo comeInfo = null;
        String startDateStr = "";
        String endDateStr = "";
        ComeReception comeReception = null;
        ComeReport comeReport = null;

        if (!StringUtils.isEmpty(id)) {
            comeInfo = comeInfoService.get(id);
            String comeInfoId = comeInfo.getId();

            startDateStr = DateUtil.dateToString(comeInfo.getStartDate(), DateUtil.FORMAT_DAY_CN);
            endDateStr = DateUtil.dateToString(comeInfo.getEndDate(), DateUtil.FORMAT_DAY_CN);

            List<ComeReception> comeReceptionList = comeReceptionService.findReception(comeInfoId);
            if (comeReceptionList.size() > 0) {
                comeReception = comeReceptionList.get(0);
            }
            List<ComeReport> comeReportList = comeReportService.findReport(comeInfoId);
            if (comeReportList.size() > 0) {
                comeReport = comeReportList.get(0);
            }
        }

        modelMap.addAttribute("startDateStr", startDateStr);
        modelMap.addAttribute("endDateStr", endDateStr);
        modelMap.addAttribute("comeInfo", comeInfo);
        modelMap.addAttribute("comeReception", comeReception);
        modelMap.addAttribute("comeReport", comeReport);

        return "foreignaffairs/come/come-info-config";
    }

    /**
     * load grid 表格数据
     */
    @ResponseBody
    @RequestMapping(value = "load-come-info-list.do", produces = "text/html; charset=UTF-8")
    public String loadComeInfoList(Carrier<ComeInfo> carrier, String groupName, String leaderName,
                                   String startDate, String endDate) {
        Map<String, Object> map = new HashMap(3);

        try {
            if (!StringUtils.isEmpty(groupName)) {
                map.put("groupName", "%" + groupName + "%");
            }
            if (!StringUtils.isEmpty(leaderName)) {
                // 中文 put cnName, 英文 put foreignName
                if (isChineseChar(leaderName)) {
                    map.put("cnName", "%" + leaderName + "%");
                } else {
                    map.put("foreignName", "%" + leaderName + "%");
                }
            }
            if (!StringUtils.isEmpty(startDate)) {
                map.put("startDate", startDate);
            }
            if (!StringUtils.isEmpty(endDate)) {
                map.put("endDate", endDate);
            }
            comeInfoService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }

        return gridResult(carrier);
    }

    /**
     * 检测字符串是否为中文
     */
    private boolean isChineseChar(String str) {
        char[] chars = str.toCharArray();
        for (char c : chars) {
            if (c >= 0x4e00 && c <= 0x9fbb) {
                return true;
            }
        }

        return false;
    }

    /**
     * 新增/编辑来访管理信息
     */
    @ResponseBody
    @RequestMapping(value = "/come-info-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveComeInfo(ComeInfoVo comeInfoVo) {

        Map<String, Object> map = new HashMap<>(1);
        try {
            comeInfoService.saveInfo(comeInfoVo);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("来访管理");
            if(org.apache.commons.lang.StringUtils.isEmpty(comeInfoVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
        }


        return map;
    }


    /**
     * 删除来访管理记录
     */
    @ResponseBody
    @RequestMapping(value = "/come-info-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteInfo(String id) {

        Map<String, Object> map = new HashMap(3);
        try {
            // 根据 id 查找来访管理信息
            ComeInfo comeInfo = comeInfoService.get(id);
            // 删除标志设为 1
            comeInfo.setDelFlag("1");
            // 保存数据
            comeInfoService.save(comeInfo);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("来访管理");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(comeInfo.getGroupName());
            sysLogVo.setEntityId(comeInfo.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);

        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 上传来访文件
     */
    @ResponseBody
    @RequestMapping(value = "/upload-file.do", method = RequestMethod.POST)
    public Map<String, Object> uploadFile(@RequestParam("uploadFile") MultipartFile file,
                                            HttpServletRequest request) {

        Map<String, Object> map = new HashMap<>(5);
        String uploadPath = request.getSession().getServletContext().getRealPath("upload");

        try {
            map = dicUploadFileService.upload(file, uploadPath);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("上传来访文件");
            sysLogVo.setRecordType(6);
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
        }

        return map;
    }


    /**
     * 导出 Word 来访接待计划
     */
    @RequestMapping(value = "/come-reception-export.do", method = RequestMethod.POST)
    public void exportWord(String comeInfoId, HttpServletRequest request, HttpServletResponse response) {
        if (StringUtils.isNotEmpty(comeInfoId)) {
            //导出Word
            try {
                this.export(comeInfoId, request, response);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("导出 Word 来访接待计划");
                sysLogVo.setRecordType(7);
                sysLogVo.setEntityName("");
                sysLogVo.setEntityId("");
                sysLogVo.setResult("true");
            } catch (DocumentException e) {
                LOG.debug(e.getMessage(), e);
            } catch (IOException e) {
                LOG.debug(e.getMessage(), e);
            }
        }
    }

    /**
     * 导出 Word 文件
     *
     * @param comeInfoId
     * @param request
     * @param response
     * @throws DocumentException
     * @throws IOException
     */
    private void export(String comeInfoId, HttpServletRequest request, HttpServletResponse response)
            throws DocumentException, IOException {
        ComeInfo comeInfo = comeInfoService.get(comeInfoId);
        List<ComeReception> comeReceptionList = comeReceptionService.findReception(comeInfoId);
        List<ComeVisitorVo> comeVisitorList = comeVisitorService.findVisitorByComeInfoId(comeInfoId);
        List<ComeSchedule> comeScheduleList = comeSchedulesService.findSchedulesByComeInfoId(comeInfoId);

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
        String fileName = comeInfo.getGroupName() + "接待计划及名单日程.doc";
        String temp = uploadPath + File.separator + fileName;
        File file = new File(temp);

        RtfWriter2.getInstance(document, new FileOutputStream(file));
        document.open();

        RtfFont font = new RtfFont("Times New Roman", 10);
        HeaderFooter pageNum = new HeaderFooter(new Phrase("-", font), new Phrase("-", font));
        pageNum.setAlignment(2);
        document.setFooter(pageNum);


        exportReception(document, comeInfo, comeReceptionList);
        exportVisitor(document, comeInfo, comeVisitorList);
        exportSchedule(document, comeInfo, comeScheduleList);

        document.close();

        FileUtil.downOrPreview(fileName, temp, response, request, "0");

        file.delete();
    }

    /**
     * 导出接待计划
     *
     * @param document
     * @param comeInfo
     * @param comeReceptionList
     * @throws DocumentException
     */
    private void exportReception(Document document, ComeInfo comeInfo, List<ComeReception> comeReceptionList) throws DocumentException {
        String lineSeparator = System.getProperty("line.separator", "\n");

        //设置标题字体风格
        RtfFont titleFont = new RtfFont("华文中宋", 22, Font.BOLD, Color.BLACK);

        //设置正文字体风格
        float contextFontSize = 12;
        RtfFont contextFont = new RtfFont("宋体", contextFontSize, Font.NORMAL);

        // 角标
        String secretStr = "机密▲x个月";
        Paragraph secret = new Paragraph(secretStr);
        secret.setFont(contextFont);
        document.add(secret);

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

        Paragraph newLine = new Paragraph();
        newLine.setSpacingAfter(contextFontSize * 2);
        document.add(newLine);

        // 附件列表
        String attachmentStr = "附件：1. " + comeInfo.getGroupName() + "名单\n";
        attachmentStr += "      2. " + comeInfo.getGroupName() + "初步日程";

        Paragraph attachment = new Paragraph(attachmentStr);
        attachment.setFont(contextFont);
        attachment.setIndentationLeft(contextFontSize * 2);

        document.add(attachment);


        // 署名
        Paragraph signature = new Paragraph("政协全国委员会办公厅    ");
        signature.setFont(contextFont);
        signature.setAlignment("right");
        signature.setSpacingBefore(contextFontSize * 3);
        document.add(signature);

        Paragraph date = new Paragraph(DateUtil.dateToString(getCurDate(), DateUtil.FORMAT_DAY_CN));
        date.setSpacingBefore(contextFontSize / 2);
        date.setFont(contextFont);
        date.setAlignment("right");
        document.add(date);


    }

    private String num2Chinese(int num) {
        String chineseNum = "一二三四五六七八九十";

        String result;
        if (num <= chineseNum.length()) {
            result = String.valueOf(chineseNum.charAt(num - 1));
        } else {
            result = "十" + String.valueOf(chineseNum.charAt(num % 10 - 1));
        }

        return result;
    }

    /**
     * 导出来访人员名单
     *
     * @param document
     * @param comeInfo
     * @param comeVisitorList
     * @throws DocumentException
     */
    private void exportVisitor(Document document, ComeInfo comeInfo, List<ComeVisitorVo> comeVisitorList) throws DocumentException {

        document.newPage();

        //设置标题字体风格
        RtfFont titleFont = new RtfFont("华文中宋", 22, Font.BOLD, Color.BLACK);

        //设置正文字体风格
        float contextFontSize = 12;
        RtfFont contextFont = new RtfFont("宋体", contextFontSize, Font.NORMAL);

        //标题 --- 来访人员名单
        String titleStr = comeInfo.getGroupName() + "名单";
        Paragraph title = new Paragraph(titleStr);
        //设置标题格式对齐方式
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(24);
        title.setFont(titleFont);
        document.add(title);

        int count = 0;
        for (ComeVisitor visitor : comeVisitorList) {
            count += 1;

            // 中文名
            String cnNameStr = (visitor.getCnName() == null ? "" : visitor.getCnName());
            Paragraph cnName = new Paragraph(String.valueOf(count) + "、 " + cnNameStr);
            cnName.setSpacingAfter(6);
            cnName.setFont(contextFont);

            // 外文名
            String nameStr = (visitor.getName() == null ? "" : visitor.getName());
            Paragraph name = new Paragraph(nameStr);
            name.setFont(contextFont);
            name.setSpacingAfter(6);
            name.setIndentationLeft(contextFontSize * 2);

            // 职务信息等
            String sexStr;
            String sex = visitor.getSex();
            if ("0".equals(sex)) {
                sexStr = "男";
            } else if ("1".equals(sex)) {
                sexStr = "女";
            } else {
                sexStr = "未知";
            }
            String dutyStr = visitor.getDuty();
            String descriptionStr = sexStr + "，" + dutyStr;
            Paragraph description = new Paragraph(descriptionStr);
            description.setFont(contextFont);
            description.setSpacingAfter(6);
            description.setIndentationLeft(contextFontSize * 2);

            document.add(cnName);
            document.add(name);
            document.add(description);
        }
    }

    /**
     * 导出日程信息
     *
     * @param document
     * @param comeInfo
     * @param comeScheduleList
     * @throws DocumentException
     */
    private void exportSchedule(Document document, ComeInfo comeInfo, List<ComeSchedule> comeScheduleList) throws DocumentException {

        document.newPage();

        //设置标题字体风格
        RtfFont titleFont = new RtfFont("华文中宋", 22, Font.BOLD, Color.BLACK);

        //设置正文字体风格
        float contextFontSize = 14;
        RtfFont contextFont = new RtfFont("宋体", contextFontSize, Font.NORMAL);

        // 标题
        String titleStr = comeInfo.getGroupName() + "初步日程";
        Paragraph title = new Paragraph(titleStr);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setFont(titleFont);
        title.setSpacingAfter(36);
        document.add(title);

        List<Date> dateList = DateUtil.getDateList(comeInfo.getStartDate(), comeInfo.getEndDate());

        // 按日期排列日程信息
        for (Date date : dateList) {
            // 日期信息
            String activityDateStr = DateUtil.dateToString(date, DateUtil.FORMAT_DAY_CN_MD);
            String week = getWeekDay(date);
            String dateInfoStr = activityDateStr + "（" + week + "）";
            Paragraph dateInfo = new Paragraph(dateInfoStr);
            dateInfo.setFont(contextFont);

            document.add(dateInfo);

            for (ComeSchedule comeSchedule : comeScheduleList) {
                Date activityDate = comeSchedule.getActivityDate();
                if (DateUtil.compareDate(activityDate, date, 0) == 0) {
                    // 时间与日程
                    String activityTimeStr = DateUtil.dateToString(comeSchedule.getActivityTime(),
                            DateUtil.FORMAT_TIME_SHORT);
                    Paragraph schedule = new Paragraph(activityTimeStr + "     " + comeSchedule.getActivity());
                    schedule.setFirstLineIndent(contextFontSize * 2);
                    schedule.setSpacingBefore(contextFontSize / 2);
                    schedule.setSpacingAfter(contextFontSize / 2);
                    schedule.setFont(contextFont);

                    document.add(schedule);
                }
            }
        }
    }

    private String getWeekDay(Date date) {
        String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        Calendar c = Calendar.getInstance();
        c.setTime(date);

        int w = c.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0) {
            w = 0;
        }

        return weekDays[w];
    }
}
