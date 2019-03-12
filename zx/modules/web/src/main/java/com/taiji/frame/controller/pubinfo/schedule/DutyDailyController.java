package com.taiji.frame.controller.pubinfo.schedule;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.*;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.pubinfo.schedule.DutyDaily;
import com.taiji.frame.model.entity.pubinfo.schedule.Section;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.SecRole;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.schedule.DutyDailyVo;
import com.taiji.frame.model.vo.pubinfo.schedule.SectionVo;
import com.taiji.frame.service.pubinfo.schedule.DutyDailyService;
import com.taiji.frame.service.pubinfo.schedule.SectionService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author admin
 * 值班日报
 */
@Controller
@RequestMapping(value = "/duty-daily")
public class DutyDailyController extends BaseController<DutyDaily> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private SectionService sectionService;

    @Autowired
    private DutyDailyService dutyDailyService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private DicDeptService dicDeptService;
    @Autowired
    private SysLogService sysLogService;


    /**
     * 页面跳转
     * id 主页传入的ID（孙毅）
     */
    @RequestMapping(value = "/duty-daily-list", method = RequestMethod.GET)
    public String list(Map<String, Object> map, String id) {

        //当前用户
        DicUser dicUser = getCurUser();
        //用户所在部门
        DicDept curDept = dicUser.getDicDept();
        map.put("curDept", curDept.getJsonObject());
        //系统日期
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        //板块名称
        List<Section> sectionList = sectionService.findSectionList();
        map.put("sysDate", sysDate);
        map.put("sectionList", sectionList);
        map.put("dutyDailyIndexMainId", id);

        return "pubinfo/schedule/duty-daily/duty-daily-list";
    }

    /**
     * load grid表格数据
     * dutyDailyIndexMainId 首页跳转 传入的ID
     */
    @ResponseBody
    @RequestMapping(value = "/load-duty-list.do", produces = "text/html;charset=UTF-8")
    public String dutyListLoad(Carrier<DutyDaily> carrier, DutyDailyVo dutyDailyVo, String dutyDailyIndexMainId) {

        HashMap map = new HashMap(16);
        try {
            if (!StringUtils.isEmpty(dutyDailyVo.getDeptId())) {

                List<DicDept> deptList = dicDeptService.getBelongDept(dutyDailyVo.getDeptId());
                List<String> stringList = new ArrayList<>();
                if (deptList.size() > 0) {
                    for (DicDept dicDept : deptList) {
                        stringList.add(dicDept.getId());
                    }
                }
                map.put("stringList", stringList);
            }
            if (!StringUtils.isEmpty(dutyDailyVo.getSectionId())) {
                map.put("sectionId", dutyDailyVo.getSectionId());
            }
            if (!StringUtils.isEmpty(dutyDailyVo.getCreateTimeStr())) {
                map.put("createTime", dutyDailyVo.getCreateTimeStr());
            }
         /*   孙毅修改，添加到 else下
            if (!StringUtils.isEmpty(dutyDailyVo.getStatus())) {
                List<String> statusList = OtherUtil.strToStringList(dutyDailyVo.getStatus());
                map.put("statusList", statusList);
            }*/
            //孙毅添加
            if (StringUtils.isNotEmpty(dutyDailyIndexMainId)) {
                map.put("dutyDailyIndexMainId", dutyDailyIndexMainId);
            } else {
                if (!StringUtils.isEmpty(dutyDailyVo.getStatus())) {
                    List<String> statusList = OtherUtil.strToStringList(dutyDailyVo.getStatus());
                    map.put("statusList", statusList);
                }
            }

            dutyDailyService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }


    /**
     * 新增/编辑页面跳转
     */
    @RequestMapping(value = "/load-duty-edit.do", method = RequestMethod.GET)
    public String dutyDailyEdit(String id, ModelMap modelMap) {

        //当前用户所在部门
        DicUser user = getCurUser();
        DicDept curDept = user.getDicDept();
        modelMap.addAttribute("curDept", curDept.getJsonObject());
        //板块信息
        List<Section> sectionList = sectionService.findSectionList();

        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        modelMap.addAttribute("sysDate", sysDate);

        DutyDaily dutyDaily = new DutyDaily();

        if (!StringUtils.isEmpty(id)) {
            //根据ID查找值班日报信息
            dutyDaily = dutyDailyService.get(id);
        }
        modelMap.addAttribute("model", dutyDaily);
        modelMap.put("sectionList", sectionList);
        return "pubinfo/schedule/duty-daily/duty-daily-edit";
    }

    /**
     * 新增/编辑值班日志保存
     */
    @ResponseBody
    @RequestMapping(value = "/duty-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveDuty(DutyDailyVo dutyDailyVo) {

        Map<String, Object> map = new HashMap<>(16);
        try {
            Date createTime = DateUtil.stringToDate(dutyDailyVo.getCreateTimeStr(), DateUtil.FORMAT_DAY);

            if (dutyDailyVo.getSectionVoList().size() > 0) {

                List<SectionVo> sectionVoList = dutyDailyVo.getSectionVoList();

                for (SectionVo sectionVo : sectionVoList) {

                    DutyDaily dutyDaily = new DutyDaily();
                    BeanUtils.copyProperties(dutyDailyVo, dutyDaily);
                    //设置时间
                    dutyDaily.setCreateTime(createTime);
                    //设置状态
                    if (StringUtils.isEmpty(dutyDailyVo.getStatus())) {
                        dutyDaily.setStatus("0");
                    }
                    //设置删除标志
                    if (StringUtils.isEmpty(dutyDailyVo.getDelFlag())) {
                        dutyDaily.setDelFlag("0");
                    }
                    //设置数据来源
                    if (StringUtils.isEmpty(dutyDailyVo.getDataSource())) {
                        dutyDaily.setDataSource("0");
                    }
                    //设置更新时间
                    dutyDaily.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN));

                    //设置板块信息
                    String sectionId = sectionVo.getSectionId();
                    Section section = sectionService.get(sectionId);
                    dutyDaily.setSection(section);
                    //设置板块内容
                    dutyDaily.setContent(sectionVo.getSectionContent());
                    //保存值班日报信息
                    dutyDailyService.save(dutyDaily);
                }
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("值班日志");
                if(org.apache.commons.lang.StringUtils.isEmpty(dutyDailyVo.getId())){
                    sysLogVo.setRecordType(0);
                }else {
                    sysLogVo.setRecordType(1);
                }
                sysLogVo.setEntityName(dutyDailyVo.getContent());
                sysLogVo.setEntityId("");
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);

                map.put("result", true);
            } else {
                map.put("result", false);
            }
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 上报/查收 值班日报
     */
    @ResponseBody
    @RequestMapping(value = "/handle-duty.do", method = RequestMethod.POST)
    public Map<String, Object> handleDuty(String id, String type) {

        Map<String, Object> map = new HashMap<>(16);

        try {
            //根据id查找值班日报信息
            DutyDaily dutyDaily = dutyDailyService.get(id);
            //更新状态
            dutyDaily.setStatus(type);
            //记录操作人
            dutyDaily.setDicUser(getCurUser());
            //记录操作时间
            Date sysDate = utilService.getSysTime();
            dutyDaily.setUpdateTime(DateUtil.dateToDateByFormat(sysDate, DateUtil.FORMAT));
            //保存数据
            dutyDailyService.save(dutyDaily);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("值班日报");
            if("1".equals(type)){
                sysLogVo.setRecordType(8);
            }else {
                sysLogVo.setRecordType(9);
            }
            sysLogVo.setEntityId("");
            sysLogVo.setEntityName(dutyDaily.getContent());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 删除值班日志
     */
    @ResponseBody
    @RequestMapping(value = "/duty-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteDuty(String id) {

        Map<String, Object> map = new HashMap<>(1);
        try {
            //根据id查找值班日报信息
            DutyDaily dutyDaily = dutyDailyService.get(id);
            //删除标志设为1
            dutyDaily.setDelFlag("1");
            //保存数据
            dutyDailyService.save(dutyDaily);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("值班日报");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityId(dutyDaily.getId());
            sysLogVo.setEntityName(dutyDaily.getContent());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);

        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 根据ID查找值班日报
     */
    @ResponseBody
    @RequestMapping(value = "/find-duty.do", method = RequestMethod.POST)
    public JSON findDutyById(String id) {

        try {
            if (null != id && !"".equals(id)) {
                DutyDaily dutyDaily = dutyDailyService.get(id);
                dutyDaily.getJsonObject();
                return dutyDaily.getJsonObject();
            } else {
                return null;
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            return null;
        }
    }

    /**
     * 根据IDs查找值班日报列表，值班日报预览
     */
    @RequestMapping(value = "/duty-daily-preview.do", method = RequestMethod.GET)
    public String findDuties(ModelMap modelMap, String data, String type) {

        List<DutyDaily> dutyDailyList = new ArrayList<>();

        Date sysDate = utilService.getSysTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(sysDate);
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);

        if ("part".equals(type)) {
            JSONArray array = JSONArray.fromObject(data);
            for (int i = 0; i < array.size(); i++) {
                DutyDaily dutyDaily = dutyDailyService.get((String) array.get(i));
                if ("2".equals(dutyDaily.getStatus())) {
                    dutyDailyList.add(dutyDaily);
                }
            }
        } else {
            JSONObject jsonObject = JSONObject.fromObject(data);
            String deptId = jsonObject.getString("deptId");
            String sectionId = jsonObject.getString("sectionId");
            String createTime = jsonObject.getString("createTime");
            //根据部门，板块，时间查询值班日报信息
            dutyDailyList = dutyDailyService.findDutyDailyByParams(deptId, sectionId, createTime, "2");
        }
        //相同板块的值班日报合并
        Map<String, List<DutyDaily>> sectionMap = new TreeMap<>();
        for (DutyDaily dutyDaily : dutyDailyList) {
            String sectionId = dutyDaily.getSection().getId();
            String sectionName = dutyDaily.getSection().getSectionName();
            String key = sectionId + "_" + sectionName;
            if (sectionMap.containsKey(key)) {
                sectionMap.get(key).add(dutyDaily);
            } else {
                List<DutyDaily> dailyList = new ArrayList<>();
                dailyList.add(dutyDaily);
                sectionMap.put(key, dailyList);
            }
        }
        modelMap.addAttribute("year", year);
        modelMap.addAttribute("month", month);
        modelMap.addAttribute("day", day);

        modelMap.addAttribute("sectionMap", sectionMap);
        return "pubinfo/schedule/duty-daily/duty-daily-preview";
    }

    /**
     * 获取用户部门列表
     */
    @ResponseBody
    @RequestMapping(value = "/find-dept-list.do", method = RequestMethod.POST)
    public List<DicDept> findDeptList() {

        JSONArray jsonArray = new JSONArray();
//        List<DicDept> deptList = dicDeptService.getBelongDept("01");
//        for (DicDept dicDept : deptList) {
//            JSON json = dicDept.getJsonObject();
//            jsonArray.add(json);
//        }
        return jsonArray;
    }

    /**
     * 获取板块信息
     */
    @ResponseBody
    @RequestMapping(value = "/find-section-list.do", method = RequestMethod.POST)
    public List<Section> findSectionList() {
        List<Section> sectionList = sectionService.findSectionList();
        return sectionList;
    }


    /**
     * 上传 Excel
     *
     * @param
     */
    @RequestMapping(value = "/upload-excel.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> importExcel(@RequestParam("uploadExcel") MultipartFile[] files) {
        Map<String, Object> map = new HashMap<>(5);

        // Excel 文件解析结果
        HashMap<String, HashMap<String, String>> resultMap = new HashMap<>(16);
        HashMap<String, String> result = new HashMap<>();

        // 解析上传的 Excel 文件
        try {
            for (MultipartFile file : files) {
                String originalFilename = file.getOriginalFilename();
                String ext = originalFilename.substring(originalFilename.lastIndexOf("."));

                InputStream inputStream = file.getInputStream();

                Workbook workbook;
                if (".xlsx".equals(ext)) {
                    workbook = new XSSFWorkbook(inputStream);
                } else if (".xls".equals(ext)) {
                    workbook = new HSSFWorkbook(inputStream);
                } else {
                    result.put("-2", "文件类型错误");
                    resultMap.put(originalFilename, result);
                    continue;
                }

                resultMap.putAll(parseExcel(originalFilename, workbook));

                // 关闭文件流
                inputStream.close();
            }
            map.put("result", resultMap);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("值班日报");
                sysLogVo.setRecordType(6);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId("");
            sysLogVo.setEntityName("");
            sysLogService.record(sysLogVo);

        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
        }
        return map;
    }


    /**
     * 解析 Excel 表格
     *
     * @param workbook
     */
    private HashMap<String, HashMap<String, String>> parseExcel(String filename, Workbook workbook) {

        String[] titles = {"单位编码", "单位名称", "签发领导", "信息员", "日期", "联系电话", "板块", "内容"};

        HashMap<String, HashMap<String, String>> map = new HashMap<>();
        HashMap<String, String> result = new HashMap<>();

        List<JSONObject> jsonObjectList = new ArrayList<>();

        // 模板第一个 Sheet 为值班日报
        Sheet sheet = workbook.getSheetAt(0);

        // 列数
        int rowCount = sheet.getPhysicalNumberOfRows();

        // 检查标题行是否正确
        Row titleRow = sheet.getRow(0);
        int columnCount = titleRow.getLastCellNum();

        for (int i = 0; i < columnCount; i++) {
            Cell cell = titleRow.getCell(i);
            String titleStr = String.valueOf(getCellValue(workbook, cell)).trim();

            if (!titleStr.equals(titles[i])) {
                result.put("-1", "标题栏错误，请检查 Excel 模板是否正确");
                map.put(filename, result);
            }
        }

        // 解析 Excel 内容
        for (int i = 1; i < rowCount; i++) {
            // 遍历行
            Row row = sheet.getRow(i);
            JSONObject jsonObject = new JSONObject();

            // 去除非日报记录的说明性 Cell
            if (row != null) {
                int firstCellIndex = row.getFirstCellNum();
                int lastCellIndex = row.getLastCellNum();

                // 遍历列，以表头为 key 组装表格内容
                for (int j = firstCellIndex; j < lastCellIndex; j++) {
                    Cell cell = row.getCell(j);
                    String cellValue = String.valueOf(getCellValue(workbook, cell));

                    if (StringUtils.isEmpty(cellValue)) {
                        continue;
                    }
                    jsonObject.put(titles[j], cellValue);
                }
                // 去除同单位、同日期的日报
                removeRepetition(jsonObject);

                jsonObjectList.add(jsonObject);
            }
        }

        int row = 1;
        for (JSONObject jsonObject : jsonObjectList) {
            if (jsonObject.size() < titles.length) {
                continue;
            }

            ImportExcelEnum checkResult = checkExcel(jsonObject);
            if (checkResult != ImportExcelEnum.SUCCESS) {
                HashMap<String, String> rowResult = new HashMap<>();
                rowResult.put(String.valueOf(row), getTipsString(row, checkResult));
                map.put(filename, rowResult);
                break;
            }

            ImportExcelEnum saveResult = saveExcel(jsonObject);
            if (saveResult == ImportExcelEnum.ERROR_ON_SAVE) {
                result.put("-1", "错误");
                map.put(filename, result);
            } else {
                result.put("0", "成功");
                map.put(filename, result);
            }

            row++;
        }

        return map;
    }

    /**
     * 检查导入的 Excel 字段
     *
     * @param jsonExcel
     */
    private ImportExcelEnum checkExcel(JSONObject jsonExcel) {
        String deptId = null;
        Date date = null;
        String sectionId = null;

        Iterator it;
        it = jsonExcel.keys();
        if (it.hasNext()) {
            deptId = String.valueOf(jsonExcel.get(it.next()));
            it.next();
            it.next();
            it.next();
            date = DateUtil.stringToDate(String.valueOf(jsonExcel.get(it.next())), DateUtil.FORMAT_DAY_CN);
            it.next();
            sectionId = String.valueOf(jsonExcel.get(it.next()));
        }
        // 部门
        DicDept dicDept;
        if (!StringUtils.isEmpty(deptId)) {
            dicDept = dicDeptService.get(deptId);
            if (null == dicDept) {
                return ImportExcelEnum.ERROR_WRONG_DEPT_NUM;
            }
        }
        // 板块
        Section section;
        if (!StringUtils.isEmpty(sectionId)) {
            section = sectionService.get(sectionId);
            if (null == section) {
                return ImportExcelEnum.ERROR_WRONG_SECTION;
            }
        }

        if (null == date) {
            return ImportExcelEnum.ERROR_WRONG_DATE;
        }
        return ImportExcelEnum.SUCCESS;
    }


    /**
     * 去除重复导入的日报
     *
     * @param excelRow
     */
    private void removeRepetition(JSONObject excelRow) {
        String deptId = null;
        String date;
        Date importDate = null;
        Iterator it = excelRow.keys();
        while (it.hasNext()) {
            Object key = it.next();
            if (((String) key).contains("单位编码")) {
                deptId = String.valueOf(excelRow.get(key));
            }
            if (((String) key).contains("日期")) {
                // Excel 中日期格式为 xx年xx月xx日
                date = String.valueOf(excelRow.get(key));
                importDate = DateUtil.stringToDate(date, DateUtil.FORMAT_DAY_CN);
            }
        }

        String d = DateUtil.dateToString(importDate, DateUtil.FORMAT_DAY);
        if (StringUtils.isNotEmpty(deptId) && StringUtils.isNotEmpty(d)) {
            List<DutyDaily> dutyDailyList = dutyDailyService.getDutyDailyByOrgAndDate(deptId, d);
            for (DutyDaily dutyDaily : dutyDailyList) {
                dutyDaily.setDelFlag("1");
                dutyDailyService.save(dutyDaily);
            }
        }
    }


    /**
     * 保存 Excel
     *
     * @param jsonExcel
     */
    private ImportExcelEnum saveExcel(JSONObject jsonExcel) {
        String deptId = null;
        String deptName = null;
        String signLeader = null;
        String creatorName = null;
        Date date = null;
        String tel = null;
        String sectionId = null;
        String content = null;

        Iterator it;
        it = jsonExcel.keys();
        while (it.hasNext()) {
            deptId = String.valueOf(jsonExcel.get(it.next())).trim();
            deptName = String.valueOf(jsonExcel.get(it.next()));
            signLeader = String.valueOf(jsonExcel.get(it.next())).trim();
            creatorName = String.valueOf(jsonExcel.get(it.next())).trim();
            date = DateUtil.stringToDate(String.valueOf(jsonExcel.get(it.next())), DateUtil.FORMAT_DAY_CN);
            tel = String.valueOf(jsonExcel.get(it.next())).trim();
            sectionId = String.valueOf(jsonExcel.get(it.next())).trim();
            content = String.valueOf(jsonExcel.get(it.next()));
        }

        // 部门
        DicDept dicDept = null;
        if (!StringUtils.isEmpty(deptId)) {
            dicDept = dicDeptService.get(deptId);
        }
        // 板块
        Section section = null;
        if (!StringUtils.isEmpty(sectionId)) {
            section = sectionService.get(sectionId);
        }
        // 操作人
        DicUser dicUser = getCurUser();
        // 设置更新时间,当前系统时间
        Date updateTime = utilService.getSysTime();

        try {
            DutyDaily dutyDaily = new DutyDaily();
            dutyDaily.setDicDept(dicDept);
            dutyDaily.setDicUser(dicUser);
            dutyDaily.setCreatorName(creatorName);
            dutyDaily.setSection(section);
            dutyDaily.setCreateTime(date);
            dutyDaily.setUpdateTime(updateTime);
            dutyDaily.setTel(tel);
            dutyDaily.setSignLeader(signLeader);
            dutyDaily.setContent(content);
            dutyDaily.setStatus("1");
            dutyDaily.setDelFlag("0");
            dutyDaily.setDataSource("1");
            dutyDailyService.save(dutyDaily);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            return ImportExcelEnum.ERROR_ON_SAVE;
        }
        return ImportExcelEnum.SUCCESS;
    }


    /**
     * 根据错误编码返回文字提示信息
     *
     * @param rowNum
     * @param excelEnum
     * @return
     */
    private String getTipsString(int rowNum, ImportExcelEnum excelEnum) {
        String tips = "";
        switch (excelEnum) {
            case ERROR_WRONG_DEPT_NUM:
                tips = "单位编码错误";
                break;
            case ERROR_WRONG_SECTION:
                tips = "板块编码错误";
                break;
            case ERROR_WRONG_DATE:
                tips = "日期格式错误，（请设置日期单元格为文本格式 xx年xx月xx日）";
                break;
            default:
                break;
        }

        return "第 " + rowNum + " 行" + tips;
    }


    /**
     * 获取 Excel 单元格的值
     *
     * @param workbook
     * @param cell
     * @return
     */
    private Object getCellValue(Workbook workbook, Cell cell) {
        Object columnValue = null;

        if (cell != null) {
            DecimalFormat df = new DecimalFormat("0");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

            switch (cell.getCellType()) {
                case Cell.CELL_TYPE_STRING:
                    columnValue = cell.getStringCellValue();
                    break;
                case Cell.CELL_TYPE_NUMERIC:
                    if ("@".equals(cell.getCellStyle().getDataFormatString()) ||
                            "General".equals(cell.getCellStyle().getDataFormatString())) {
                        columnValue = df.format(cell.getNumericCellValue());
                    } else {
                        columnValue = sdf.format(HSSFDateUtil.getJavaDate(cell.getNumericCellValue()));
                    }
                    break;
                case Cell.CELL_TYPE_BOOLEAN:
                    columnValue = cell.getBooleanCellValue();
                    break;
                case Cell.CELL_TYPE_BLANK:
                    columnValue = "";
                    break;
                case Cell.CELL_TYPE_FORMULA:
                    FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();
                    evaluator.evaluateFormulaCell(cell);
                    CellValue cellValue = evaluator.evaluate(cell);
                    columnValue = cellValue.getNumberValue();
                    break;
                default:
                    columnValue = cell.toString();
            }
        }
        return columnValue;
    }


    /**
     * 定时任务工作动态
     * */
    @ResponseBody
    @RequestMapping(value = "/duty-daily-time.do", method = RequestMethod.POST)
    public Map<String,Object> planTime() {

        Map<String, Object> map = new HashMap<>(3);
        try {
            List<DutyDaily> activityPlans = dutyDailyService.dutyListLoadIndexMain(1, null, "-1");

            List<HashMap<String,String>> list = dutyDailyService.loadIndexMainDate(activityPlans);

            String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT);
            map.put("indexMainSysTime",sysDate);
            map.put("activityPlans",list);
            map.put("result",true);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            map.put("result",false);
        }
        return map;
    }



}
