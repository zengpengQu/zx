package com.taiji.frame.controller.foreignaffairs.abroad;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.rtf.RtfWriter2;
import com.lowagie.text.rtf.style.RtfFont;
import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.FileUtil;
import com.taiji.frame.common.util.StringUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadGroup;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadSchedule;
import com.taiji.frame.model.systempara.*;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.abroad.AbroadInfoVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadGroupService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadScheduleService;
import com.taiji.frame.service.systempara.*;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSON;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;
import java.util.List;

@Controller
@RequestMapping(value = "/abroad-info")
public class AbroadInfoController extends BaseController<AbroadInfo> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private AbroadGroupService abroadGroupService;

    @Autowired
    private AbroadScheduleService abroadScheduleService;

    @Autowired
    private SysLogService sysLogService;

    @Autowired
    private DicNationService dicNationService;

    @Autowired
    private DicUserService dicUserService;

    /**
     * 页面跳转
     */
    @RequestMapping(value = "/abroad-info-list", method = RequestMethod.GET)
    public String list(Map<String, Object> map) {
        //角色
        DicUser dicUser = getCurUser();
        StringBuilder roleStr = new StringBuilder();
        List<SecRole> secRoleList = dicUser.getRoleList();
        for (SecRole secRole : secRoleList) {
            roleStr.append(secRole.getId());
        }
        map.put("roleStr", roleStr.toString());

        //用户部门
        DicDept curDept = dicUser.getDicDept();
        map.put("curDept", curDept);

        return "foreignaffairs/abroad/abroad-info-list";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-abroad-list.do", produces = "text/html;charset=UTF-8")
    public String abroadListLoad(Carrier<AbroadInfo> carrier, AbroadInfoVo abroadInfoVo) {
        HashMap map = new HashMap(16);

        try {
            if (StringUtils.isNotEmpty(abroadInfoVo.getOrgId())) {

                /*List<DicDept> deptList = dicDeptService.getBelongDept(abroadInfoVo.getOrgId());
                List<String> stringList = new ArrayList<>();
                if (deptList.size() > 0) {
                    for (DicDept dicDept : deptList) {
                        stringList.add(dicDept.getId());
                    }
                }*/
                String deptId = abroadInfoVo.getOrgId();
                map.put("deptId", deptId);
            }
            if (StringUtils.isNotEmpty(abroadInfoVo.getGroupNumber())) {
                map.put("groupNumber", "%" + abroadInfoVo.getGroupNumber() + "%");
            }
            if (StringUtils.isNotEmpty(abroadInfoVo.getGroupName())) {
                map.put("groupName", "%" + abroadInfoVo.getGroupName() + "%");
            }
            if (StringUtils.isNotEmpty(abroadInfoVo.getBatchNumber())) {
                map.put("batchNumber", "%" + abroadInfoVo.getBatchNumber() + "%");
            }
            if (StringUtils.isNotEmpty(abroadInfoVo.getStartTime())) {
                map.put("startTime", abroadInfoVo.getStartTime());
            }
            if (StringUtils.isNotEmpty(abroadInfoVo.getEndTime())) {
                map.put("endTime", abroadInfoVo.getEndTime());
            }
            abroadInfoService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑页面跳转
     */
    @RequestMapping(value = "/load-abroad-edit.do", method = RequestMethod.GET)
    public String abroadInfoEdit(String id, ModelMap modelMap) {
        // 团组活动级别
        List<DicParam> groupLevelList = dicParamService.getParamByGroupId(8);
        modelMap.addAttribute("groupLevelList", groupLevelList);

        // 出访任务
        List<DicParam> abroadTaskList = dicParamService.getParamByGroupId(9);
        modelMap.addAttribute("abroadTaskList", abroadTaskList);

        // 费用来源
        List<DicParam> costSourceList = dicParamService.getParamByGroupId(11);
        modelMap.addAttribute("costSourceList", costSourceList);
        List<JSON> nationList = new ArrayList<>();

        AbroadInfo abroadInfo;
        DicUser groupLeader = null;
        if (StringUtils.isNotEmpty(id)) {
            abroadInfo = abroadInfoService.get(id);
            groupLeader = abroadInfo.getGroupLeader();

            if(StringUtils.isNotEmpty(abroadInfo.getCountry())) {
                String[] countries = abroadInfo.getCountry().split(",");
                for (String countryId : countries) {
                    DicNation nation = dicNationService.get(countryId);
                    nationList.add(nation.getJsonObject());
                }
            }
        } else {
            abroadInfo = new AbroadInfo();
        }
        modelMap.addAttribute("abroadInfo", abroadInfo);
        modelMap.addAttribute("savedCountry", nationList);
        if (null != groupLeader) {
            modelMap.addAttribute("leaderId", groupLeader.getId());
        }
        modelMap.addAttribute("leaderName", abroadInfo.getLeaderName());

        //部门信息
        DicDept dicDept = new DicDept();
        if (null != abroadInfo.getOrg()) {
            dicDept = abroadInfo.getOrg();
        }
        modelMap.addAttribute("dicDept", dicDept.getJsonObject());

        // 外单位团组主办单位
        modelMap.addAttribute("outDeptName", abroadInfo.getDeptName());

        return "foreignaffairs/abroad/abroad-info-edit";
    }

    /**
     * 更改团组名单时，即设置团组总人数
     *
     * @param totalNum
     * @param abroadInfoId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/set-totalNum.do", method = RequestMethod.POST)
    public Map<String, Object> setTotalNum(String totalNum, String abroadInfoId) {
        Map<String, Object> map = new HashMap<>();

        try {
            if (StringUtils.isNotEmpty(abroadInfoId)) {
                AbroadInfo abroadInfo = abroadInfoService.get(abroadInfoId);
                abroadInfo.setTotalNum(Long.parseLong(totalNum));
                abroadInfoService.save(abroadInfo);
            }
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 新增/编辑信息保存
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-info-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveAbroadInfo(AbroadInfoVo abroadInfoVo) {
        Map<String, Object> map = new HashMap<>(16);

        try {
            AbroadInfo abroadInfo;
            if (StringUtils.isEmpty(abroadInfoVo.getId())) {
                abroadInfo = new AbroadInfo();
                abroadInfo.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
            } else {
                abroadInfo = abroadInfoService.get(abroadInfoVo.getId());
            }

            String leaderId = abroadInfoVo.getLeaderId();
            if (StringUtils.isNotEmpty(leaderId)) {
                DicUser leader = dicUserService.get(leaderId);
                abroadInfo.setGroupLeader(leader);
            } else {
                abroadInfo.setGroupLeader(null);
            }
            String leaderName = abroadInfoVo.getLeaderName();
            abroadInfo.setLeaderName(leaderName);

            abroadInfo.setAbroadType(abroadInfoVo.getAbroadType());
            if (StringUtils.isNotEmpty(abroadInfoVo.getGroupLevelId())) {
                abroadInfo.setGroupLevel(dicParamService.get(abroadInfoVo.getGroupLevelId()));
            }
            // 外单位团组主办单位
            abroadInfo.setDeptName(abroadInfoVo.getOutDeptName());

            abroadInfo.setPlanFlag(abroadInfoVo.getPlanFlag());
            abroadInfo.setGroupNumber(abroadInfoVo.getGroupNumber());
            abroadInfo.setGroupName(abroadInfoVo.getGroupName());

            if (StringUtils.isNotEmpty(abroadInfoVo.getStartDateStr())) {
                abroadInfo.setStartDate(DateUtil.stringToDate(abroadInfoVo.getStartDateStr(), DateUtil.FORMAT_DAY));
            }
            if (StringUtils.isNotEmpty(abroadInfoVo.getEndDateStr())) {
                abroadInfo.setEndDate(DateUtil.stringToDate(abroadInfoVo.getEndDateStr(), DateUtil.FORMAT_DAY));
            }
            if (StringUtils.isNotEmpty(abroadInfoVo.getOrgId())) {
                abroadInfo.setOrg(dicDeptService.get(abroadInfoVo.getOrgId()));
            }
            abroadInfo.setBatchNumber(abroadInfoVo.getBatchNumber());
            if (StringUtils.isNotEmpty(abroadInfoVo.getAbroadTaskId())) {
                abroadInfo.setAbroadTask(dicParamService.get(abroadInfoVo.getAbroadTaskId()));
            }

            abroadInfo.setTaskDesc(abroadInfoVo.getTaskDesc());
            if (StringUtils.isNotEmpty(abroadInfoVo.getCostSourceId())) {
                abroadInfo.setCostSource(dicParamService.get(abroadInfoVo.getCostSourceId()));
            }
            abroadInfo.setAbroadDays(abroadInfoVo.getAbroadDays());
            abroadInfo.setCostInstruct(abroadInfoVo.getCostInstruct());
            abroadInfo.setRemark(abroadInfoVo.getRemark());
            abroadInfo.setCountry(abroadInfoVo.getCountry());
            abroadInfo.setDelFlag("0");
            abroadInfo.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));

            abroadInfoService.save(abroadInfo);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
            if(org.apache.commons.lang.StringUtils.isEmpty(abroadInfoVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(abroadInfo.getAbroadType());
            sysLogVo.setEntityId(abroadInfo.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);

        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 删除出访信息
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-info-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteAbroadInfo(String id) {

        Map<String, Object> map = new HashMap<>(1);
        try {
            AbroadInfo abroadInfo = abroadInfoService.get(id);
            abroadInfo.setDelFlag("1");
            abroadInfoService.save(abroadInfo);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(abroadInfo.getAbroadType());
            sysLogVo.setEntityId(abroadInfo.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 页面跳转
     */
    @RequestMapping(value = "/load-abroad-config.do", method = RequestMethod.GET)
    public String loadAbroadConfig(String id, ModelMap modelMap) {
        AbroadInfo abroadInfo = new AbroadInfo();
        if (!StringUtils.isEmpty(id)) {
            abroadInfo = abroadInfoService.get(id);
        }
        modelMap.addAttribute("abroadInfo", abroadInfo);
        return "foreignaffairs/abroad/abroad-info-config";
    }

    @RequestMapping(value = "/export-abroad.do", method = RequestMethod.POST)
    public void exportWord(String abroadInfoId, HttpServletRequest request, HttpServletResponse response) {
        if (StringUtils.isNotEmpty(abroadInfoId)) {
            //导出Word
            try {
                this.export(abroadInfoId, request, response);
            } catch (DocumentException e) {
                LOG.debug(e.getMessage(), e);
            } catch (IOException e) {
                LOG.debug(e.getMessage(), e);
            }
        }
    }

    private void export(String abroadInfoId, HttpServletRequest request, HttpServletResponse response)
            throws DocumentException, IOException {
        AbroadInfo abroadInfo = abroadInfoService.get(abroadInfoId);
        // 内部人员列表
        List<AbroadGroup> innerGroupList = abroadGroupService.findAbroadGroupByParams(abroadInfoId, "in");

        // 外部人员列表
        List<AbroadGroup> outGroupList = abroadGroupService.findAbroadGroupByParams(abroadInfoId, "out");

        // 日程列表
        List<AbroadSchedule> scheduleList = abroadScheduleService.findByInfoId(abroadInfoId);


        //设置纸张大小
        Document document = new Document(PageSize.A4, 90.0F, 90.0F, 72.0F, 72.0F);

        // 创建临时文件
        String uploadPath = request.getSession().getServletContext().getRealPath("upload");
        File f = new File(uploadPath);
        //文件夹不存在
        if (!f.exists()) {
            f.mkdirs();
        }
        String fileName = abroadInfo.getGroupName() + "小册子.doc";
        String temp = uploadPath + File.separator + fileName;
        File file = new File(temp);

        RtfWriter2.getInstance(document, new FileOutputStream(file));
        document.open();

        RtfFont font = new RtfFont("Times New Roman", 10);
        HeaderFooter pageNum = new HeaderFooter(new Phrase("-", font), new Phrase("-", font));
        pageNum.setAlignment(2);
        document.setFooter(pageNum);

        exportPeople(document, abroadInfo, innerGroupList, outGroupList);
        exportSchedule(document, abroadInfo, scheduleList);

        document.close();

        FileUtil.downOrPreview(fileName, temp, response, request, "0");

        file.delete();
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("出访信息");
        sysLogVo.setRecordType(7);
        sysLogVo.setEntityName(abroadInfo.getAbroadType());
        sysLogVo.setEntityId(abroadInfo.getId());
        sysLogVo.setResult("true");
        sysLogService.record(sysLogVo);
    }

    /**
     * 导出内部人员与外部人员
     *
     * @param document
     * @param innerGroupList
     * @param outGroupList
     */
    private void exportPeople(Document document, AbroadInfo abroadInfo,
                              List<AbroadGroup> innerGroupList, List<AbroadGroup> outGroupList)
            throws DocumentException {
        //设置标题字体风格
        RtfFont titleFont = new RtfFont("宋体", 22, Font.BOLD, Color.BLACK);

        //设置正文字体风格
        float contextFontSize = 12;
        RtfFont contextFont = new RtfFont("宋体", contextFontSize, Font.NORMAL);


        String titleStr = "全国政协代表团名单";
        Paragraph title = new Paragraph(titleStr);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setFont(titleFont);
        title.setSpacingAfter(contextFontSize * 3);
        document.add(title);

        Paragraph leader = new Paragraph("团长：");
        leader.setFont(contextFont);
        document.add(leader);

        DicUser groupLeader = abroadInfo.getGroupLeader();
        String leaderLineStr = "团长未知";
        String duty = "";
        if (groupLeader != null) {
            duty = null == groupLeader.getMainDuty() ? "" : groupLeader.getMainDuty();
        }
        //创建PdfTable对象
        PdfPTable table = new PdfPTable(2);

        //设置各列的列宽
        table.setTotalWidth(new float[]{40, 60});
        //添加表格内容
        table.addCell(getPDFCell(leaderLineStr, contextFont));
        table.addCell(getPDFCell(duty, contextFont));
        document.add(table);

        Paragraph member = new Paragraph("团员：");
        document.add(member);
        insertToTable(document, innerGroupList, contextFont);

        document.newPage();
        String titleStr2 = "外单位人员名单";
        Paragraph title2 = new Paragraph(titleStr2);
        title2.setAlignment(Element.ALIGN_CENTER);
        title2.setFont(titleFont);
        title2.setSpacingAfter(contextFontSize * 3);
        document.add(title2);

        Paragraph member2 = new Paragraph("团员：");
        document.add(member2);
        insertToTable(document, outGroupList, contextFont);
    }

    private static void insertToTable(Document document, List<AbroadGroup> groupList, Font font)
            throws DocumentException {
        //创建PdfTable对象
        PdfPTable table = new PdfPTable(2);

        //设置各列的列宽
        table.setTotalWidth(new float[]{40, 60});

        for (AbroadGroup ag : groupList) {
            String nameStr = ag.getName();
            String dutyStr = null == ag.getDuty() ? "" : ag.getDuty();

            //添加表格内容
            table.addCell(getPDFCell(nameStr, font));
            table.addCell(getPDFCell(dutyStr, font));
        }
        document.add(table);
    }

    /**
     * 获取指定内容与字体的单元格
     *
     * @param string
     * @param font
     * @return
     */
    private static PdfPCell getPDFCell(String string, Font font) {
        //创建单元格对象，将内容与字体放入段落中作为单元格内容
        PdfPCell cell = new PdfPCell(new Paragraph(string, font));

        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setBorderColor(Color.WHITE);

        //设置最小单元格高度
        cell.setMinimumHeight(100);
        return cell;
    }

    /**
     * 导出日程信息
     *
     * @param document
     * @param abroadInfo
     * @param scheduleList
     */
    private void exportSchedule(Document document, AbroadInfo abroadInfo, List<AbroadSchedule> scheduleList)
            throws DocumentException {
        document.newPage();

        //设置标题字体风格
        RtfFont titleFont = new RtfFont("华文中宋", 22, Font.BOLD, Color.BLACK);

        //设置正文字体风格
        float contextFontSize = 14;
        RtfFont contextFont = new RtfFont("宋体", contextFontSize, Font.NORMAL);

        // 标题
        String titleStr = "访问日程";
        Paragraph title = new Paragraph(titleStr);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setFont(titleFont);
        title.setSpacingAfter(36);
        document.add(title);

        List<Date> dateList = DateUtil.getDateList(abroadInfo.getStartDate(), abroadInfo.getEndDate());

        // 按日期排列日程信息
        for (Date date : dateList) {
            // 日期信息
            String activityDateStr = DateUtil.dateToString(date, DateUtil.FORMAT_DAY_CN_MD);
            String week = getWeekDay(date);
            String dateInfoStr = activityDateStr + "（" + week + "）";
            Paragraph dateInfo = new Paragraph(dateInfoStr);
            dateInfo.setFont(contextFont);

            document.add(dateInfo);

            for (AbroadSchedule as : scheduleList) {
                Date activityDate = as.getDay();
                if (DateUtil.compareDate(activityDate, date, 0) == 0) {
                    // 时间与日程
                    String activityTimeStr = as.getPeriod();
                    Paragraph schedule = new Paragraph(activityTimeStr + "     " + as.getContent());
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
