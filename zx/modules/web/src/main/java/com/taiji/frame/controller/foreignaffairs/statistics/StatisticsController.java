package com.taiji.frame.controller.foreignaffairs.statistics;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadGroup;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadNation;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicNation;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadGroupService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadNationService;
import com.taiji.frame.service.foreignaffairs.statistics.StatisticsService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicNationService;
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
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/**
 * @author yx
 * 出访统计管理
 */

@Controller
@RequestMapping(value = "/statistics")
public class StatisticsController extends BaseController<AbroadInfo> {
    private static final Logger LOG = LoggerFactory.getLogger(StatisticsController.class);


    @Autowired
    StatisticsService statisticsService;

    @Autowired
    AbroadInfoService abroadInfoService;

    @Autowired
    AbroadNationService abroadNationService;

    @Autowired
    DicDeptService dicDeptService;

    @Autowired
    AbroadGroupService abroadGroupService;

    @Autowired
    private SysLogService sysLogService;

    @Autowired
    private DicNationService dicNationService;

    /**
     * 页面跳转
     */
    @RequestMapping(value = "/statistics-list", method = RequestMethod.GET)
    public String list(ModelMap modelMap) {
        Calendar calendar = Calendar.getInstance();
        Date date = DateUtil.getFirstDayOfYear(calendar.get(Calendar.YEAR));
        String startDate = DateUtil.dateToString(date, DateUtil.FORMAT_YYYY);

        modelMap.addAttribute("startDate", startDate);

        return "foreignaffairs/statistics/statistics-list";
    }

    @ResponseBody
    @RequestMapping(value = "/load-data.do", method = RequestMethod.POST)
    public Map<String, Object> loadDataByType(String searchParams, String type) {
        Map<String, Object> map = new HashMap<>(2);

        JSONObject dates = JSONObject.fromObject(searchParams);

        String startDate = String.valueOf(dates.get("startDate"));
        startDate += "-01-01";
        String endDate = "";

        switch (type) {
            case "avm":
                map = aboveViceMinister(startDate, endDate);
                break;
            case "ba":
                map = businessAbroad(startDate, endDate);
                break;
            case "ad":
                map = abroadDetails(startDate, endDate);
                break;
            case "zxVc":
                map = zxViceChairman(startDate, endDate);
                break;
            case "leaders":
                map = zxLeaders(startDate, endDate);
                break;
            case "commLeaders":
                map = committeeLeaders(startDate, endDate);
                break;
            case "esc":
                map = economySocietyCouncil(startDate, endDate);
                break;
            case "nineComm":
                map = nineCommittee(startDate, endDate);
                break;
            case "outerVc":
                map = outerViceChairman(startDate, endDate);
                break;
            case "rp":
                map = religionPeace(startDate, endDate);
                break;
            case "outerZx":
                map = outerZx(startDate, endDate);
                break;
            case "ps":
                map = planSummary(startDate, endDate);
                break;
            case "mini":
                map = minister(startDate, endDate);
                break;
            case "bm":
                map = belowMinister(startDate, endDate);
                break;
            case "cvc":
                map = chairmanAndViceChairman(startDate, endDate);
                break;
            default:
                break;
        }

        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("出访统计管理");
            sysLogVo.setRecordType(25);
        sysLogVo.setEntityName("");
        sysLogVo.setEntityId("");
        sysLogVo.setResult("true");
        sysLogService.record(sysLogVo);
        return map;

    }


    @ResponseBody
    @RequestMapping(value = "/export-excel.do", method = RequestMethod.GET)
    public Map<String, Object> exportExcel(HttpServletRequest request, HttpServletResponse response,
                                           String year, String type) {
        Map<String, Object> map = new HashMap<>(2);

        String startDate = year + "-01-01";
        String endDate = "";

        String fileName; // 导出表格文件名
        String title; // 表格标题

        @SuppressWarnings("unchecked")
        List<JSONObject> jsonObjectList;
        List<String> headerList = new ArrayList<>();

        OutputStream os; // 输出流

        try {
            switch (type) {
                case "avm":
                    map = aboveViceMinister(startDate, endDate);
                    fileName = "副部级以上领导干部统计表.xls";
                    title = String.format("%s年中央和国家机关副部级以上领导干部因公出国（境）情况明细表", year);

                    os = OtherUtil.getOutputStream(fileName, request, response);

                    jsonObjectList = (List<JSONObject>) map.get("searchResult");

                    headerList.add("序号");
                    headerList.add("姓名");
                    headerList.add("职务");
                    headerList.add("出访国家（地区）");
                    headerList.add("经停国家（地区）");
                    headerList.add("离境日期");
                    headerList.add("抵境日期");
                    headerList.add("在外停留天数");
                    headerList.add("代表团人数");
                    headerList.add("委员人数");
                    headerList.add("备注");

                    statisticsService.createExcel(os, fileName, title, headerList, jsonObjectList);
                    break;
                case "ba":
                    map = businessAbroad(startDate, endDate);
                    fileName = String.format("%s年中央和国家机关各部门因公出国（境）情况汇总表.xls", year);
                    title = String.format("%s 年中央和国家机关各部门因公出国（境）情况汇总表", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    jsonObjectList = (List<JSONObject>) map.get("searchResult");
                    statisticsService.createBAExcel(os, fileName, year, title, jsonObjectList);
                    break;
                case "ad":
                    map = abroadDetails(startDate, endDate);
                    fileName = String.format("%s年出访情况详表.xls", year);
                    title = String.format("%s 年出访情况详表", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    // 前端导出Excel
                    break;
                case "zxVc":
                    map = zxViceChairman(startDate, endDate);
                    fileName = String.format("%s年副主席出访统计表（政协组团）.xls", year);
                    title = String.format("%s 年全国政协副主席率团出访情况表（政协组团）", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    jsonObjectList = (List<JSONObject>) map.get("searchResult");

                    headerList.add("序号");
                    headerList.add("日期");
                    headerList.add("组团单位");
                    headerList.add("团长");
                    headerList.add("邀请单位");
                    headerList.add("出访国家");
                    headerList.add("出访任务");
                    headerList.add("团组人数");
                    headerList.add("委员人数");
                    headerList.add("会见情况");
                    headerList.add("备注");

                    statisticsService.createExcel(os, fileName, title, headerList, jsonObjectList);
                    break;
                case "leaders":
                    map = zxLeaders(startDate, endDate);
                    fileName = String.format("%s年办公厅领导出访统计表.xls", year);
                    title = String.format("%s 年全国政协办公厅领导出访情况一览表", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    jsonObjectList = (List<JSONObject>) map.get("searchResult");

                    headerList.add("序号");
                    headerList.add("姓名");
                    headerList.add("职务");
                    headerList.add("日期");
                    headerList.add("团组名");
                    headerList.add("出访国家");

                    statisticsService.createExcel(os, fileName, title, headerList, jsonObjectList);
                    break;
                case "commLeaders":
                    map = committeeLeaders(startDate, endDate);
                    fileName = String.format("%s年专委会领导出访统计表.xls", year);
                    title = String.format("%s 年专委会负责人出访情况一览表（以委员会排序）", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    jsonObjectList = (List<JSONObject>) map.get("searchResult");

                    headerList.add("序号");
                    headerList.add("委员会名称");
                    headerList.add("姓名");
                    headerList.add("职务");
                    headerList.add("日期");
                    headerList.add("团组名");
                    headerList.add("访问国家");

                    statisticsService.createExcel(os, fileName, title, headerList, jsonObjectList);
                    break;
                case "esc":
                    map = economySocietyCouncil(startDate, endDate);
                    fileName = String.format("%s年经社理事会出访统计表.xls", year);
                    title = String.format("%s 年经社理事会出访团组统计", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    jsonObjectList = (List<JSONObject>) map.get("searchResult");

                    headerList.add("序号");
                    headerList.add("团长姓名");
                    headerList.add("对外身份");
                    headerList.add("级别");
                    headerList.add("代表团总人数");
                    headerList.add("代表团主要成员及工作人员");
                    headerList.add("启程时间");
                    headerList.add("回国时间");
                    headerList.add("访问国家（地区）");
                    headerList.add("访问目的");
                    headerList.add("邀请方");
                    headerList.add("备注");

                    statisticsService.createExcel(os, fileName, title, headerList, jsonObjectList);
                    break;
                case "nineComm":
                    map = nineCommittee(startDate, endDate);
                    fileName = String.format("%s年专委会出访情况统计表（综合处）.xls", year);
                    title = String.format("%s 年全国政协专门委员会出访情况一览表", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    jsonObjectList = (List<JSONObject>) map.get("searchResult");

                    headerList.add("序号");
                    headerList.add("团长姓名");
                    headerList.add("对外身份");
                    headerList.add("级别");
                    headerList.add("代表团总人数");
                    headerList.add("代表团主要成员及工作人员");
                    headerList.add("启程时间");
                    headerList.add("回国时间");
                    headerList.add("访问国家（地区）");
                    headerList.add("访问目的");
                    headerList.add("邀请方");
                    headerList.add("备注");

                    statisticsService.createExcel(os, fileName, title, headerList, jsonObjectList);
                    break;
                case "outerVc":
                    map = outerViceChairman(startDate, endDate);
                    fileName = String.format("%s年副主席出访统计表（外单位组团）.xls", year);
                    title = String.format("%s 年全国政协副主席率团出访情况一览表(外单位组团)", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    jsonObjectList = (List<JSONObject>) map.get("searchResult");

                    headerList.add("序号");
                    headerList.add("日期");
                    headerList.add("组团单位");
                    headerList.add("团长");
                    headerList.add("邀请单位");
                    headerList.add("对外名义");
                    headerList.add("人数");
                    headerList.add("出访国家");
                    headerList.add("出访任务");
                    headerList.add("会见情况");
                    headerList.add("备注");

                    statisticsService.createExcel(os, fileName, title, headerList, jsonObjectList);
                    break;

                case "rp":
                    map = religionPeace(startDate, endDate);
                    fileName = String.format("%s年“中宗和”出访情况统计表.xls", year);
                    title = String.format("%s 年“中宗和”出访情况一览表", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    jsonObjectList = (List<JSONObject>) map.get("searchResult");

                    headerList.add("序号");
                    headerList.add("日期");
                    headerList.add("组团单位");
                    headerList.add("团长");
                    headerList.add("团长职务");
                    headerList.add("邀请单位");
                    headerList.add("人数");
                    headerList.add("出访国家");
                    headerList.add("出访任务");
                    headerList.add("会见情况");
                    headerList.add("备注");

                    statisticsService.createExcel(os, fileName, title, headerList, jsonObjectList);
                    break;
                case "outerZx":
                    map = outerZx(startDate, endDate);
                    fileName = String.format("%s年政协人员参加外单位团组情况表.xls", year);
                    title = String.format("%s 年政协人员参加外单位组团", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    jsonObjectList = (List<JSONObject>) map.get("searchResult");

                    headerList.add("序号");
                    headerList.add("日期");
                    headerList.add("组团单位");
                    headerList.add("参加人员");
                    headerList.add("职务");
                    headerList.add("邀请单位");
                    headerList.add("对外名义");
                    headerList.add("人数");
                    headerList.add("出访国家");
                    headerList.add("出访任务");
                    headerList.add("会见情况");
                    headerList.add("备注");

                    statisticsService.createExcel(os, fileName, title, headerList, jsonObjectList);
                    break;
                case "ps":
                    map = planSummary(startDate, endDate);
                    fileName = String.format("%s年出访计划执行情况统计表.xls", year);
                    title = String.format("%s 年政协人员参加外单位组团", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    // 前端导出 Excel

                    break;
                case "mini":
                    map = minister(startDate, endDate);
                    fileName = String.format("%s年部级团组出访统计表.xls", year);
                    title = String.format("%s 年部级团组出访统计表", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    jsonObjectList = (List<JSONObject>) map.get("searchResult");

                    headerList.add("序号");
                    headerList.add("时间");
                    headerList.add("组团单位");
                    headerList.add("出访国家");
                    headerList.add("出访任务");
                    headerList.add("团长");
                    headerList.add("级别");
                    headerList.add("委员人数");
                    headerList.add("代表团人数");

                    statisticsService.createExcel(os, fileName, title, headerList, jsonObjectList);
                    break;
                case "bm":
                    map = belowMinister(startDate, endDate);
                    fileName = String.format("%s年部级以下团组出访情况统计表.xls", year);
                    title = String.format("%s 年部级以下团组出访统计表", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    jsonObjectList = (List<JSONObject>) map.get("searchResult");

                    headerList.add("序号");
                    headerList.add("时间");
                    headerList.add("组团单位");
                    headerList.add("出访国家");
                    headerList.add("出访任务");
                    headerList.add("团长");
                    headerList.add("级别");
                    headerList.add("委员人数");
                    headerList.add("代表团人数");

                    statisticsService.createExcel(os, fileName, title, headerList, jsonObjectList);
                    break;
                case "cvc":
                    map = chairmanAndViceChairman(startDate, endDate);
                    fileName = String.format("%s年主席、副主席出访情况统计表.xls", year);
                    title = String.format("%s 年主席、副主席出访情况", year);
                    os = OtherUtil.getOutputStream(fileName, request, response);
                    jsonObjectList = (List<JSONObject>) map.get("searchResult");

                    headerList.add("序号");
                    headerList.add("日期");
                    headerList.add("姓名");
                    headerList.add("党派/工商联");
                    headerList.add("出访国家");
                    headerList.add("主办单位");

                    statisticsService.createExcel(os, fileName, title, headerList, jsonObjectList);
                    break;
                default:
                    break;
            }
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访统计管理导出");
            sysLogVo.setRecordType(7);
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (IOException e) {
            e.printStackTrace();
        }
        map.get("searchResult");


        return map;
    }

    /**
     * 副部级以上领导干部因公出国（境）情况明细统计
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> aboveViceMinister(String startDate, String endDate) {
        Map<String, Object> map = new HashMap<>(2);

        List<AbroadGroup> abroadGroupList = statisticsService.findAboveViceMinister("0112", startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();

        for (AbroadGroup abroadGroup : abroadGroupList) {

            AbroadInfo abroadInfo = abroadGroup.getAbroadInfo();
            List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());
            List<String> trsCountryList = abroadNationService.findStopoverNationList(abroadInfo.getId());
            DicUser dicUser = abroadGroup.getDicUser();

            JSONObject result = new JSONObject();

            result.put("name", abroadGroup.getName());
            result.put("duty", dicUser.getMainDuty());
            result.put("dstCountry", StringUtils.join(abroadNationList, "、"));
            result.put("trsCountry", StringUtils.join(trsCountryList, "、"));

            Date leaveDate = abroadInfo.getStartDate();
            Date backDate = abroadInfo.getEndDate();
            result.put("leaveDate", DateUtil.dateToString(leaveDate, DateUtil.FORMAT_DAY_CN_MD));
            result.put("backDate", DateUtil.dateToString(backDate, DateUtil.FORMAT_DAY_CN_MD));
            result.put("outDate", (leaveDate == null || backDate == null) ? "" : DateUtil.getDayCountOfDate(leaveDate, backDate));
            result.put("peopleNum", abroadInfo.getTotalNum());

            // TODO: 计算委员人数
            result.put("committeeNum", abroadInfo.getTotalNum() - 1);


            DicUser groupLeader = abroadInfo.getGroupLeader();
            if (null == groupLeader) {
                result.put("notes", "");
            } else {
                String groupLeaderId = groupLeader.getId();
                String userId = abroadGroup.getDicUser() == null ? "" : abroadGroup.getDicUser().getId();
                if (groupLeaderId.equals(userId)) {
                    result.put("notes", "率团出访");
                } else {
                    String duty = "";
                    DicParam dicParam = abroadGroup.getDicUser().getDicParam();
                    String dicParamId = dicParam.getId();
                    if ("0102".equals(dicParamId)) {
                        duty = "副主席";
                    }
                    result.put("notes", "随" + groupLeader.getEmpName() + duty);
                }
            }

            jsonObjectList.add(result);
        }
        map.put("searchResult", jsonObjectList);

        return map;
    }


    /**
     * 中央和国家机关各部门因公出国（境）情况汇总表
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> businessAbroad(String startDate, String endDate) {
        Map<String, Object> map = new HashMap<>(2);


        JSONObject result = statisticsService.findBusinessAbroad(startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();
        jsonObjectList.add(result);

        map.put("searchResult", jsonObjectList);

        return map;
    }


    /**
     * XX 年出访情况详表
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> abroadDetails(String startDate, String endDate) {
        Map<String, Object> map = new HashMap<>(2);

        List<AbroadGroup> abroadGroupList = statisticsService.findAbroadDetails(startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();

        if (abroadGroupList != null && abroadGroupList.size() > 0) {

            AbroadGroup firstAbroadGroup = abroadGroupList.get(0);
            AbroadInfo firstAbroadInfo = firstAbroadGroup.getAbroadInfo();

            int rowSpan = 0;
            int index = 1;
            for (AbroadGroup abroadGroup : abroadGroupList) {

                JSONObject jsonObject = new JSONObject();
                AbroadInfo abroadInfo = abroadGroup.getAbroadInfo();

                // 按团组分开，排序（rowspan 合并同一团组的人员）
                if (abroadInfo.getId().equals(firstAbroadInfo.getId())) {
                    rowSpan += 1;
                } else {

                    jsonObjectList.get(jsonObjectList.size() - rowSpan).put("rowspan", rowSpan);
                    jsonObjectList.get(jsonObjectList.size() - rowSpan).put("index", index);

                    firstAbroadInfo = abroadInfo;
                    rowSpan = 1;
                    index += 1;
                }


                Date leaveDate = abroadInfo.getStartDate();
                Date backDate = abroadInfo.getEndDate();
                jsonObject.put("leaveDate", DateUtil.dateToString(leaveDate, DateUtil.FORMAT_DAY_CN_MD));
                jsonObject.put("backDate", DateUtil.dateToString(backDate, DateUtil.FORMAT_DAY_CN_MD));
                jsonObject.put("org", null == abroadInfo.getOrg()? "" : abroadInfo.getOrg().getDeptName());
                jsonObject.put("batchNumber", abroadInfo.getBatchNumber());

                // 途经国家与出访国家
                List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());
                List<String> trsCountryList = abroadNationService.findStopoverNationList(abroadInfo.getId());
                jsonObject.put("trsCountry", StringUtils.join(trsCountryList, "、"));
                jsonObject.put("dstCountry", StringUtils.join(abroadNationList, "、"));

                jsonObject.put("task", abroadInfo.getTaskDesc());
                jsonObject.put("taskType", abroadInfo.getAbroadTask().getName());
                jsonObject.put("groupLevel", abroadInfo.getGroupLevel().getName());
                jsonObject.put("peopleNum", abroadInfo.getTotalNum());
                // TODO: 计算委员人数
                jsonObject.put("committeeNum", abroadInfo.getTotalNum() - 1);
                jsonObject.put("name", abroadGroup.getName());

                // 政协内人员显示政协职务，非政协人员显示外单位职务
                jsonObject.put("duty", abroadGroup.getDicUser() != null ?
                        abroadGroup.getDicUser().getMainDuty() : abroadGroup.getDuty());

                // 政协内人员显示其政协单位，非政协人员显示其外单位名称
                jsonObject.put("personOrg", abroadGroup.getDicUser() != null ?
                        abroadGroup.getDicUser().getDicDept().getDeptName() : abroadGroup.getOrg());
                // 备注
                jsonObject.put("notes", "");
                jsonObjectList.add(jsonObject);
            }

            jsonObjectList.get(jsonObjectList.size() - rowSpan).put("rowspan", rowSpan);
            jsonObjectList.get(jsonObjectList.size() - rowSpan).put("index", index);
        }

        map.put("searchResult", jsonObjectList);

        return map;
    }


    /**
     * 副主席率团出访情况表（政协组团）
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> zxViceChairman(String startDate, String endDate) {
        Map<String, Object> map = new HashMap<>(2);

        List<AbroadGroup> abroadGroupList = statisticsService.findZxViceChairman("0102", startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();

        for (AbroadGroup abroadGroup : abroadGroupList) {
            JSONObject jsonObject = new JSONObject();
            AbroadInfo abroadInfo = abroadGroup.getAbroadInfo();

            String leaveDate = DateUtil.dateToString(abroadInfo.getStartDate(), DateUtil.FORMAT_DAY_CN_MD);
            String backDate = DateUtil.dateToString(abroadInfo.getEndDate(), DateUtil.FORMAT_DAY_CN_MD);
            jsonObject.put("date", leaveDate + "至" + backDate);

            jsonObject.put("org", "全国政协");
            DicUser groupLeader = abroadInfo.getGroupLeader();
            jsonObject.put("groupLeader", groupLeader == null ? "未知" : groupLeader.getEmpName());

            // 出访国家列表
            List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());

            // 邀请单位
            List<String> unitNameList = new ArrayList<>();
            for (AbroadNation abroadNation : abroadNationList) {
                unitNameList.add(abroadNation.getUnitName());
            }
            jsonObject.put("inviteOrg", StringUtils.join(unitNameList, "、"));

            // 出访国家
            jsonObject.put("dstCountry", StringUtils.join(abroadNationList, "、"));

            jsonObject.put("task", abroadInfo.getTaskDesc());
            jsonObject.put("peopleNum", abroadInfo.getTotalNum());
            // TODO: 计算委员人数
            jsonObject.put("committeeNum", " ");
            jsonObject.put("meeting", " ");
            jsonObject.put("notes", " ");

            jsonObjectList.add(jsonObject);
        }

        map.put("searchResult", jsonObjectList);

        return map;
    }


    /**
     * 全国政协办公厅领导出访情况
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> zxLeaders(String startDate, String endDate) {
        Map<String, Object> map = new HashMap<>(2);

        List<AbroadGroup> abroadGroupList = statisticsService.findZxLeaders(startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();

        for (AbroadGroup abroadGroup : abroadGroupList) {
            JSONObject jsonObject = new JSONObject();
            AbroadInfo abroadInfo = abroadGroup.getAbroadInfo();

            jsonObject.put("name", abroadGroup.getDicUser().getEmpName());
            jsonObject.put("duty", abroadGroup.getDicUser().getMainDuty());

            Date leaveDate = abroadInfo.getStartDate();
            Date backDate = abroadInfo.getEndDate();
            String leaveDateStr = DateUtil.dateToString(leaveDate, DateUtil.FORMAT_DAY_CN_MD);
            String backDateStr = DateUtil.dateToString(backDate, DateUtil.FORMAT_DAY_CN_MD);
            jsonObject.put("date", leaveDateStr + "至" + backDateStr);

            jsonObject.put("groupName", abroadInfo.getGroupName());

            List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());
            jsonObject.put("dstCountry", StringUtils.join(abroadNationList, "、"));

            jsonObjectList.add(jsonObject);
        }

        map.put("searchResult", jsonObjectList);

        return map;
    }


    /**
     * 全国政协专委会负责人出访情况
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> committeeLeaders(String startDate, String endDate) {
        Map<String, Object> map = new HashMap<>(2);

        List<AbroadGroup> abroadGroupList = statisticsService.findCommitteeLeaders(startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();

        for (AbroadGroup abroadGroup : abroadGroupList) {
            AbroadInfo abroadInfo = abroadGroup.getAbroadInfo();
            JSONObject jsonObject = new JSONObject();

            // 根据个人部门ID，获取其上级部门
            String deptId = abroadGroup.getDicUser().getDicDept().getId();
            String parentId = deptId.substring(0, 6);
            DicDept dept = dicDeptService.get(parentId);
            String deptName = "";

            // 部门名称取 办公室之前的部分
            // 如获取到部门为 提案委员会办公室（一局），只返回 提案委员会
            if (null != dept) {
                deptName = dept.getDeptName();
                deptName = deptName.substring(0, deptName.indexOf("办公室"));
            }
            jsonObject.put("committee", deptName);

            jsonObject.put("name", abroadGroup.getName());
            jsonObject.put("duty", abroadGroup.getDicUser() != null ?
                    abroadGroup.getDicUser().getMainDuty() : abroadGroup.getDuty());

            Date leaveDate = abroadInfo.getStartDate();
            Date backDate = abroadInfo.getEndDate();
            String leaveDateStr = DateUtil.dateToString(leaveDate, DateUtil.FORMAT_DAY_CN_MD);
            String backDateStr = DateUtil.dateToString(backDate, DateUtil.FORMAT_DAY_CN_MD);
            jsonObject.put("date", leaveDateStr + "至" + backDateStr);

            jsonObject.put("groupName", abroadInfo.getGroupName());

            // 出访国家
            List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());
            jsonObject.put("dstCountry", StringUtils.join(abroadNationList, "、"));

            jsonObjectList.add(jsonObject);
        }


        map.put("searchResult", jsonObjectList);

        return map;
    }


    /**
     * 经社理事会出访团组统计
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> economySocietyCouncil(String startDate, String endDate) {
        Map<String, Object> map = new HashMap<>(2);

        List<AbroadInfo> abroadInfoList = statisticsService.findEconomySocietyCouncil(startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();

        for (AbroadInfo abroadInfo : abroadInfoList) {
            JSONObject jsonObject = new JSONObject();

            DicUser groupLeader = abroadInfo.getGroupLeader();
            if (null == groupLeader) {
                jsonObject.put("leaderName", "未知");
                jsonObject.put("foreignIdentity", "");
                jsonObject.put("level", "");
            } else {
                AbroadGroup leader = abroadGroupService.findAbroadGroupByUserId(abroadInfo.getId(), groupLeader.getId());
                jsonObject.put("leaderName", groupLeader.getEmpName());
                jsonObject.put("foreignIdentity", leader.getIdentity());
                jsonObject.put("level", leader.getAdminLevel() == null ? "" : leader.getAdminLevel());
            }
            jsonObject.put("peopleNum", abroadInfo.getTotalNum());

            // 代表团成员
            List<AbroadGroup> memberList = statisticsService.findMembersByInfoId(abroadInfo.getId());
            jsonObject.put("members", StringUtils.join(memberList, "、"));

            Date leaveDate = abroadInfo.getStartDate();
            Date backDate = abroadInfo.getEndDate();
            jsonObject.put("leaveDate", DateUtil.dateToString(leaveDate, DateUtil.FORMAT_DAY_CN_MD));
            jsonObject.put("backDate", DateUtil.dateToString(backDate, DateUtil.FORMAT_DAY_CN_MD));

            // 出访国家
            List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());
            jsonObject.put("dstCountry", StringUtils.join(abroadNationList, "、"));

            // 访问目的
            jsonObject.put("task", abroadInfo.getAbroadTask().getName());

            // 邀请方
            List<String> unitNameList = new ArrayList<>();
            for (AbroadNation abroadNation : abroadNationList) {
                unitNameList.add(abroadNation.getUnitName());
            }
            jsonObject.put("inviteOrg", StringUtils.join(unitNameList, "、"));
            jsonObject.put("notes", "");

            jsonObjectList.add(jsonObject);
        }

        map.put("searchResult", jsonObjectList);

        return map;
    }


    /**
     * 全国政协专门委员会出访情况
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> nineCommittee(String startDate, String endDate) {
        Map<String, Object> map = new HashMap<>(2);

        List<AbroadInfo> abroadInfoList = statisticsService.findNineCommittee(startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();

        for (AbroadInfo abroadInfo : abroadInfoList) {
            JSONObject jsonObject = new JSONObject();

            Date leaveDate = abroadInfo.getStartDate();
            Date backDate = abroadInfo.getEndDate();
            String leaveDateStr = DateUtil.dateToString(leaveDate, DateUtil.FORMAT_DAY_CN_MD);
            String backDateStr = DateUtil.dateToString(backDate, DateUtil.FORMAT_DAY_CN_MD);
            jsonObject.put("date", leaveDateStr + "至" + backDateStr);

            DicDept org = abroadInfo.getOrg();
            if (org != null) {
                String orgStr = abroadInfo.getOrg().getDeptName();
                jsonObject.put("org", orgStr.substring(0, orgStr.indexOf("办公室")));
            } else {
                jsonObject.put("org", "");
            }
            DicUser groupLeader = abroadInfo.getGroupLeader();
            jsonObject.put("groupLeader", groupLeader == null? "未知" : groupLeader.getEmpName());
            jsonObject.put("leaderDuty", groupLeader == null? "未知" : groupLeader.getMainDuty());

            // 出访国家列表
            List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());
            // 邀请单位
            List<String> unitNameList = new ArrayList<>();
            for (AbroadNation abroadNation : abroadNationList) {
                unitNameList.add(abroadNation.getUnitName());
            }
            jsonObject.put("inviteOrg", StringUtils.join(unitNameList, "、"));
            jsonObject.put("peopleNum", abroadInfo.getTotalNum());
            jsonObject.put("dstCountry", StringUtils.join(abroadNationList, "、"));

            jsonObject.put("task", abroadInfo.getTaskDesc());

            List<AbroadGroup> memberList = statisticsService.findMembersByInfoId(abroadInfo.getId());
            jsonObject.put("members", StringUtils.join(memberList, "、"));
            // TODO: 计算委员人数
            jsonObject.put("committeeNum", " ");
            jsonObject.put("notes", "");

            jsonObjectList.add(jsonObject);
        }

        map.put("searchResult", jsonObjectList);

        return map;
    }


    /**
     * 副主席率团出访情况表（外单位组团）
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> outerViceChairman(String startDate, String endDate) {
        Map<String, Object> map = new HashMap<>(2);

        List<AbroadInfo> abroadInfoList = statisticsService.findOuterViceChairman("0102", startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();

        for (AbroadInfo abroadInfo : abroadInfoList) {
            JSONObject jsonObject = new JSONObject();

            String leaveDate = DateUtil.dateToString(abroadInfo.getStartDate(), DateUtil.FORMAT_DAY_CN_MD);
            String backDate = DateUtil.dateToString(abroadInfo.getEndDate(), DateUtil.FORMAT_DAY_CN_MD);
            jsonObject.put("date", leaveDate + "至" + backDate);

            jsonObject.put("org", null == abroadInfo.getOrg()? "" : abroadInfo.getOrg().getDeptName());
            DicUser groupLeader = abroadInfo.getGroupLeader();
            jsonObject.put("groupLeader", groupLeader == null ? "未知": groupLeader.getEmpName());

            // 出访国家列表
            List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());

            // 邀请单位
            List<String> unitNameList = new ArrayList<>();
            for (AbroadNation abroadNation : abroadNationList) {
                unitNameList.add(abroadNation.getUnitName());
            }
            jsonObject.put("inviteOrg", StringUtils.join(unitNameList, "、"));
            jsonObject.put("peopleNum", abroadInfo.getTotalNum());

            List<String> nationList = new ArrayList<>();
            if(StringUtils.isNotEmpty(abroadInfo.getCountry())) {
                String[] countries = abroadInfo.getCountry().split(",");
                for (String countryId : countries) {
                    DicNation nation = dicNationService.get(countryId);
                    nationList.add(nation.getNationName());
                }
            }
            jsonObject.put("dstCountry", StringUtils.join(nationList, "、"));

            jsonObject.put("task", abroadInfo.getTaskDesc());
            jsonObject.put("meeting", "");
            jsonObject.put("notes", abroadInfo.getRemark());

            jsonObjectList.add(jsonObject);
        }

        map.put("searchResult", jsonObjectList);
        return map;
    }


    /**
     * “中宗和”出访情况一览表
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> religionPeace(String startDate, String endDate) {
        Map<String, Object> map = new HashMap<>(2);

        List<AbroadInfo> abroadInfoList = statisticsService.findReligionPeace(startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();

        for (AbroadInfo abroadInfo : abroadInfoList) {
            JSONObject jsonObject = new JSONObject();

            String leaveDate = DateUtil.dateToString(abroadInfo.getStartDate(), DateUtil.FORMAT_DAY_CN_MD);
            String backDate = DateUtil.dateToString(abroadInfo.getEndDate(), DateUtil.FORMAT_DAY_CN_MD);
            jsonObject.put("date", leaveDate + "至" + backDate);

            jsonObject.put("org", null == abroadInfo.getOrg()? "" : abroadInfo.getOrg().getDeptName());
            DicUser groupLeader = abroadInfo.getGroupLeader();
            jsonObject.put("groupLeader", groupLeader == null? "未知" : groupLeader.getEmpName());
            jsonObject.put("leaderDuty", groupLeader == null? "未知" : groupLeader.getMainDuty());

            // 出访国家列表
            List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());

            // 邀请单位
            List<String> unitNameList = new ArrayList<>();
            for (AbroadNation abroadNation : abroadNationList) {
                unitNameList.add(abroadNation.getUnitName());
            }
            jsonObject.put("inviteOrg", StringUtils.join(unitNameList, "、"));
            jsonObject.put("peopleNum", abroadInfo.getTotalNum());
            jsonObject.put("dstCountry", StringUtils.join(abroadNationList, "、"));

            jsonObject.put("task", abroadInfo.getTaskDesc());
            jsonObject.put("meeting", "");
            jsonObject.put("notes", "");

            jsonObjectList.add(jsonObject);
        }

        map.put("searchResult", jsonObjectList);
        return map;
    }

    /**
     * 政协人员参加外单位组团
     *
     * @param startDate
     * @param endDate
     * @return
     */

    private Map<String, Object> outerZx(String startDate, String endDate) {
        Map<String, Object> map = new HashMap<>(2);

        List<AbroadGroup> abroadGroupList = statisticsService.findOuterZx(startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();

        for (AbroadGroup abroadGroup : abroadGroupList) {
            JSONObject jsonObject = new JSONObject();
            AbroadInfo abroadInfo = abroadGroup.getAbroadInfo();

            String leaveDate = DateUtil.dateToString(abroadInfo.getStartDate(), DateUtil.FORMAT_DAY_CN_MD);
            String backDate = DateUtil.dateToString(abroadInfo.getEndDate(), DateUtil.FORMAT_DAY_CN_MD);
            jsonObject.put("date", leaveDate + "至" + backDate);

            // 组团单位
            jsonObject.put("org", null == abroadInfo.getOrg()? "" : abroadInfo.getOrg().getDeptName());
            // 参加人员
            jsonObject.put("name", abroadGroup.getDicUser().getEmpName());
            jsonObject.put("duty", abroadGroup.getDicUser().getMainDuty() != null ?
                    abroadGroup.getDicUser().getMainDuty() : "");


            // 出访国家列表
            List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());

            // 邀请单位
            List<String> unitNameList = new ArrayList<>();
            for (AbroadNation abroadNation : abroadNationList) {
                unitNameList.add(abroadNation.getUnitName());
            }
            jsonObject.put("inviteOrg", StringUtils.join(unitNameList, "、"));
            jsonObject.put("foreignIdentity", abroadGroup.getIdentity() != null ? abroadGroup.getIdentity() :  "");
            jsonObject.put("peopleNum", abroadInfo.getTotalNum());
            // 出访国家
            jsonObject.put("dstCountry", StringUtils.join(abroadNationList, "、"));
            jsonObject.put("task", abroadInfo.getTaskDesc());
            jsonObject.put("meeting", "");
            jsonObject.put("notes", "");

            jsonObjectList.add(jsonObject);
        }

        map.put("searchResult", jsonObjectList);
        return map;
    }


    /**
     * 对外交往计划和执行情况对比表
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> planSummary(String startDate, String endDate) {
        return abroadInfoByLevel("0199", "0101", startDate, endDate);
    }


    /**
     * 部级团组出访统计表
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> minister(String startDate, String endDate) {
        return abroadInfoByLevel("0112", "0111", startDate, endDate);

    }


    /**
     * 部级以下团组出访统计表
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> belowMinister(String startDate, String endDate) {
        return abroadInfoByLevel("0199", "0121", startDate, endDate);
    }


    /**
     * 主席、副主席出访情况
     *
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> chairmanAndViceChairman(String startDate, String endDate) {
        Map<String, Object> map = new HashMap<>(2);

        List<AbroadInfo> abroadInfoList = statisticsService.findInfoByLevel("0102", "0101", startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();

        for (AbroadInfo abroadInfo : abroadInfoList) {
            JSONObject jsonObject = new JSONObject();

            String leaveDate = DateUtil.dateToString(abroadInfo.getStartDate(), DateUtil.FORMAT_DAY_CN_MD);
            String backDate = DateUtil.dateToString(abroadInfo.getEndDate(), DateUtil.FORMAT_DAY_CN_MD);
            jsonObject.put("date", leaveDate + "至" + backDate);

            DicUser groupLeader = abroadInfo.getGroupLeader();
            jsonObject.put("groupLeader", groupLeader == null? "未知" : groupLeader.getEmpName());
            // TODO: 党派未知
            jsonObject.put("party", " ");
            // 出访国家
            List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());
            jsonObject.put("dstCountry", StringUtils.join(abroadNationList, "、"));
            jsonObject.put("org", null == abroadInfo.getOrg()? "" : abroadInfo.getOrg().getDeptName());

            jsonObjectList.add(jsonObject);
        }

        map.put("searchResult", jsonObjectList);
        return map;
    }


    /**
     * 根据行政级别范围查找团组信息
     *
     * @param lowLevel
     * @param highLevel
     * @param startDate
     * @param endDate
     * @return
     */
    private Map<String, Object> abroadInfoByLevel(String lowLevel, String highLevel, String startDate, String
            endDate) {
        Map<String, Object> map = new HashMap<>(2);

        List<AbroadInfo> abroadInfoList = statisticsService.findInfoByLevel(lowLevel, highLevel, startDate, endDate);

        List<JSONObject> jsonObjectList = new ArrayList<>();

        for (AbroadInfo abroadInfo : abroadInfoList) {
            JSONObject jsonObject = new JSONObject();

            String leaveDate = DateUtil.dateToString(abroadInfo.getStartDate(), DateUtil.FORMAT_DAY_CN_MD);
            String backDate = DateUtil.dateToString(abroadInfo.getEndDate(), DateUtil.FORMAT_DAY_CN_MD);
            jsonObject.put("date", leaveDate + "至" + backDate);

            jsonObject.put("org", null == abroadInfo.getOrg()? "" : abroadInfo.getOrg().getDeptName());
            // 出访国家
            List<AbroadNation> abroadNationList = abroadNationService.findAbroadNationList(abroadInfo.getId());
            jsonObject.put("dstCountry", StringUtils.join(abroadNationList, "、"));
            jsonObject.put("task", abroadInfo.getTaskDesc());

            // 系统用户表团长信息
            DicUser groupLeader = abroadInfo.getGroupLeader();

            if (null == groupLeader) {
                jsonObject.put("groupLeader", "未知");
                jsonObject.put("level", "团长未知");
            } else {
                jsonObject.put("groupLeader", groupLeader.getEmpName());
                // 团组信息表中的团长信息
                AbroadGroup leader = abroadGroupService.findAbroadGroupByUserId(abroadInfo.getId(), groupLeader.getId());
                jsonObject.put("level", null == leader ? "" : leader.getAdminLevel());
            }
            jsonObject.put("committeeNum", " ");
            jsonObject.put("peopleNum", abroadInfo.getTotalNum());
            jsonObjectList.add(jsonObject);
        }

        map.put("searchResult", jsonObjectList);
        return map;
    }

}
