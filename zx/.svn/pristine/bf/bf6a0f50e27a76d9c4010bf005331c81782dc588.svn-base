package com.taiji.frame.controller.foreignaffairs.taiwanCard;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.ImportExcelEnum;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.model.entity.foreignaffairs.taiwanCard.TaiWanInfo;
import com.taiji.frame.model.entity.foreignaffairs.taiwanCard.TaiWanInfoUser;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.taiwanCard.TaiWanInfoUserVo;
import com.taiji.frame.model.vo.taiwanCard.TaiWanInfoVo;
import com.taiji.frame.service.foreignaffairs.taiwanCard.TaiWanInFoUserService;
import com.taiji.frame.service.foreignaffairs.taiwanCard.TaiWanInfoService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author qzp
 * @date 2018/08/10
 * 赴台信息控制器
 */
@Controller
@RequestMapping(value = "/taiwan-info")
public class TaiWanInfoController extends BaseController<TaiWanInfo> {
    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanInfoController.class);

    @Autowired
    private TaiWanInfoService taiWanInfoService;

    @Autowired
    private DicUserService dicUserService;

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private UtilService utilService;
    @Autowired
    private SysLogService sysLogService;

    @Autowired
    private TaiWanInFoUserService taiWanInFoUserService;

    /**
     * 页面跳转
     * @return
     */
    @RequestMapping(value = "/taiwan-info-list",method = RequestMethod.GET)
    public String jumpPage(){
        return "foreignaffairs/taiwanCard/taiwan-info-list";
    }

    /**
     * 数据表格
     * @param carrier
     * @param groupName
     * @param goTimeStr
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-taiwan-info-list.do",produces = "text/html;charset=UTF-8")
    public String taleList(Carrier<TaiWanInfo> carrier,String groupName,String goTimeStr){
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (StringUtils.isNotEmpty(groupName)){
                map.put("groupName","%" + groupName + "%");
            }
            if (StringUtils.isNotEmpty(goTimeStr)){
                map.put("goTimeStr",goTimeStr);
            }
            taiWanInfoService.load(carrier,map);
        }catch (Exception e){
            LOGGER.error(e.getMessage(),e);
        }
        System.out.println("ss: "+gridResult(carrier));
        return gridResult(carrier);
    }

    /**
     * 跳转到新增或编辑页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-taiwan-info-edit",method = RequestMethod.GET)
    public String jumpToEditPage(ModelMap modelMap,String id){
        TaiWanInfo taiWanInfo = new TaiWanInfo();
        if (StringUtils.isNotEmpty(id)){
            taiWanInfo = taiWanInfoService.get(id);
            modelMap.addAttribute("taiWanInfo",taiWanInfo);
        }else {
            modelMap.addAttribute("taiWanInfo",null);
        }
        //人员信息
        List<DicUser> dicUserList = dicUserService.getAll();
        modelMap.addAttribute("dicUserList",dicUserList);
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        modelMap.addAttribute("sysDate", sysDate);

        //部门信息
        DicDept dicDept = new DicDept();
        if (null != taiWanInfo.getDicDept()) {
            dicDept = taiWanInfo.getDicDept();
        }
        modelMap.addAttribute("dicDept",dicDept.getJsonObject());

        //组团部门
        DicDept dept = new DicDept();
        if (null != taiWanInfo.getDept()) {
            dept = taiWanInfo.getDept();
        }
        modelMap.addAttribute("dept",dept.getJsonObject());

        return "foreignaffairs/taiwanCard/taiwan-info-edit";
    }

    /**
     * 新增或编辑---数据保存
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-taiwan-info-save.do",method = RequestMethod.POST)
    public Map<String,Object> saveOrUpdate(@RequestBody TaiWanInfoVo taiWanInfoVo){

        Map<String, Object> map = new HashMap<>(2);

        String infoId = taiWanInfoVo.getInfoId();
        TaiWanInfo taiWanInfo = null;
        try {
            if (StringUtils.isNotEmpty(infoId)){
                //编辑
                taiWanInfo = taiWanInfoService.get(infoId);
                if(StringUtils.isEmpty(taiWanInfoVo.getGroupDepartment())){
                    map.put("result", false);
                    map.put("messageStr","请选择组团部门");
                    return map;
                }
                taiWanInfoService.setData(taiWanInfo,taiWanInfoVo);
                taiWanInfo.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                taiWanInfoService.save(taiWanInfo);

                List<TaiWanInfoUserVo> listVo = taiWanInfoVo.getTaiWanInfoUserListVo();
                for (TaiWanInfoUserVo vo:listVo) {
                    String id = vo.getUserInfoId();
                    TaiWanInfoUser userInfo;
                    if(StringUtils.isNotEmpty(id)){
                        userInfo = taiWanInFoUserService.get(id);
                    }else {
                        userInfo = new TaiWanInfoUser();
                        userInfo.setDelFlag("0");
                    }
                    if(StringUtils.isNotEmpty(vo.getUserPeopleId())){
                        DicUser user = new DicUser();
                        user.setId(vo.getUserPeopleId());
                        userInfo.setDicUser(user);
                    }
                    if(StringUtils.isNotEmpty(vo.getUserDeptId())){
                        DicDept dept = new DicDept();
                        dept.setId(vo.getUserDeptId());
                        userInfo.setDicDept(dept);
                    }
                    if(StringUtils.isNotEmpty(vo.getUserDegree())){
                        userInfo.setDegree(vo.getUserDegree());
                    }
                    if(StringUtils.isNotEmpty(vo.getUserNotes())){
                        userInfo.setNotes(vo.getUserNotes());
                    }
                    if(StringUtils.isNotEmpty(vo.getUserDuty())){
                        userInfo.setDuty(vo.getUserDuty());
                    }
                    if(StringUtils.isNotEmpty(vo.getUserDutyTai())){
                        userInfo.setDutyTai(vo.getUserDutyTai());
                    }
                    userInfo.setTaiWanInfo(taiWanInfo);
                    taiWanInFoUserService.save(userInfo);
                }
                map.put("result", true);
            }else {
                //新增
                taiWanInfo = new TaiWanInfo();
                taiWanInfo.setCreateTime(new Date());
                taiWanInfoService.setData(taiWanInfo,taiWanInfoVo);
                taiWanInfoService.save(taiWanInfo);

                List<TaiWanInfoUserVo> listVo = taiWanInfoVo.getTaiWanInfoUserListVo();
                for (TaiWanInfoUserVo vo:listVo) {
                    TaiWanInfoUser userInfo = new TaiWanInfoUser();
                    DicUser user = new DicUser();
                    user.setId(vo.getUserPeopleId());
                    userInfo.setDicUser(user);
                    DicDept dept = new DicDept();
                    dept.setId(vo.getUserDeptId());
                    userInfo.setDicDept(dept);
                    userInfo.setTaiWanInfo(taiWanInfo);
                    userInfo.setDelFlag("0");
                    userInfo.setDegree(vo.getUserDegree());
                    userInfo.setNotes(vo.getUserNotes());
                    userInfo.setDuty(vo.getUserDuty());
                    userInfo.setDutyTai(vo.getUserDutyTai());
                    taiWanInFoUserService.save(userInfo);
                }

                map.put("result", true);
            }
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("因公赴台");
            if(org.apache.commons.lang.StringUtils.isEmpty(infoId)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(taiWanInfo.getGroupName());
            sysLogVo.setEntityId(taiWanInfo.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            LOGGER.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }
    /**
     * 删除赴台信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/taiwan-info-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteTaiwanInfo(String id) {
        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {
            try {
                TaiWanInfo info = taiWanInfoService.get(id);
                info.setDelFlag("1");
                taiWanInfoService.save(info);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因公赴台");
                sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(info.getGroupName());
                sysLogVo.setEntityId(info.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            } catch (Exception e) {
                LOGGER.debug(e.getMessage(), e);
                map.put("result", false);
            }
        }
        return map;
    }


    /**
     * 删除赴台用户
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/taiWanInFoUser-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteChronicle(String id) {
        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {
            try {
                TaiWanInfoUser infoUser = taiWanInFoUserService.get(id);
                infoUser.setDelFlag("1");
                taiWanInFoUserService.save(infoUser);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("赴台用户信息");
                    sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(infoUser.getDicUser().getEmpName());
                sysLogVo.setEntityId(infoUser.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            } catch (Exception e) {
                LOGGER.debug(e.getMessage(), e);
                map.put("result", false);
            }
        }
        return map;
    }

    /**
     * 导出Excel
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping(value = "/export-excel.do",method = RequestMethod.GET)
    public void exportExcel(HttpServletRequest request, HttpServletResponse response){
        try {
            String groupName = new String((request.getParameter("groupName")).getBytes("iso-8859-1"), "utf-8");
            String goTimeStr = request.getParameter("goTimeStr");
            List<TaiWanInfo> list = taiWanInfoService.findDataExcel(groupName,goTimeStr);
            String fileName = "因公赴台详细信息.xls";
            //设置输入流参数
            OutputStream os = OtherUtil.getOutputStream(fileName, request, response);
            String dateStr = DateUtil.getDateStr(getCurDate());
            String userName = getCurUser().getEmpName();
            taiWanInfoService.createExcel(os,fileName,dateStr,userName,list);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("因公赴台");
                sysLogVo.setRecordType(7);
            sysLogVo.setEntityName("因公赴台详细信息");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            LOGGER.error(e.getMessage(),e);
        }
    }

    /**
     * 根据ID,预览赴台任务件
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/taiwan-info-preview.do",method = RequestMethod.GET)
    public String taskFile(ModelMap modelMap,String id,String type){
        Date sysDate = utilService.getSysTime();

        TaiWanInfo taiWanInfo = taiWanInfoService.get(id);
        modelMap.addAttribute("beginTime", DateUtil.dateToString(taiWanInfo.getGoTime(), DateUtil.FORMAT_DAY_CN));
        modelMap.addAttribute("endTime", DateUtil.dateToString(taiWanInfo.getEndTime(), DateUtil.FORMAT_DAY_CN));
        modelMap.addAttribute("time", DateUtil.compareDate(taiWanInfo.getGoTime(), taiWanInfo.getEndTime(), 0));
        modelMap.addAttribute("sysDate", DateUtil.dateToString(sysDate, DateUtil.FORMAT_DAY_CN));
        modelMap.addAttribute("taiWanInfo",taiWanInfo);
        if(taiWanInfo.getTaiWanInfoUserList().size()>0) {
            modelMap.addAttribute("taiWanInfoUserName", taiWanInfo.getTaiWanInfoUserList().get(0).getDicUser().getEmpName());
        }

        String str;
        if("file".equals(type)){
            str = "foreignaffairs/taiwanCard/taiwan-info-preview";
        }else if("book".equals(type)){
            str = "foreignaffairs/taiwanCard/taiwan-info-preview-book";
        }else {
            str = "foreignaffairs/taiwanCard/taiwan-info-preview-confirm";
        }
        return str;
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
            sysLogVo.setTypeName("因公赴台");
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

        String[] titles = {"团组名称", "开始时间", "结束时间", "台方接待单位", "费用来源", "备注"};

        HashMap<String, HashMap<String, String>> map = new HashMap<>();
        HashMap<String, String> result = new HashMap<>();

        List<JSONObject> jsonObjectList = new ArrayList<>();
        Sheet sheet = workbook.getSheetAt(0);

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

        // 行数
        int rowCount = sheet.getPhysicalNumberOfRows();
        // 解析 Excel 内容
        for (int i = 1; i < rowCount; i++) {
            // 遍历行
            Row row = sheet.getRow(i);
            JSONObject jsonObject = new JSONObject();

            // 去除非记录 Cell
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
     * 检查导入的 Excel 字段
     *
     * @param jsonExcel
     */
    private ImportExcelEnum checkExcel(JSONObject jsonExcel) {
        Date startDate = null;
        Date endDate = null;

        Iterator it;
        it = jsonExcel.keys();
        if (it.hasNext()) {
            // 团组名称
            it.next();
            // 开始时间
            String startDateStr = String.valueOf(jsonExcel.get(it.next()));
            startDate = dateByFormat(startDateStr);
            // 结束时间
            String endDateStr = String.valueOf(jsonExcel.get(it.next()));
            endDate = dateByFormat(endDateStr);
            // 台方接待单位
            it.next();
            // 费用来源
            it.next();
            // 备注
            it.next();
        }


        if (null == startDate || null == endDate) {
            return ImportExcelEnum.ERROR_WRONG_DATE;
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
            case ERROR_WRONG_DATE:
                tips = "日期格式错误，（请设置日期单元格为文本格式 xx年xx月xx日）";
                break;
            default:
                break;
        }

        return "第 " + rowNum + " 行" + tips;
    }

    /**
     * 保存 Excel
     *
     * @param jsonExcel
     */
    private ImportExcelEnum saveExcel(JSONObject jsonExcel) {
        String groupName = "";
        Date startDate = null;
        Date endDate = null;
        String taiDept = "";
        String taiCharge = "";
        String notes = "";

        Iterator it;
        it = jsonExcel.keys();
        while (it.hasNext()) {
            // 团组名称
            groupName = String.valueOf(jsonExcel.get(it.next()));
            // 开始时间
            String startDateStr = String.valueOf(jsonExcel.get(it.next()));
            startDate = dateByFormat(startDateStr);
            // 结束时间
            String endDateStr = String.valueOf(jsonExcel.get(it.next()));
            endDate = dateByFormat(endDateStr);
            // 台方接待单位
            taiDept = String.valueOf(jsonExcel.get(it.next()));
            // 费用来源
            taiCharge = String.valueOf(jsonExcel.get(it.next()));
            // 备注
            notes = String.valueOf(jsonExcel.get(it.next()));
        }

        // 设置更新时间,当前系统时间
        Date updateTime = utilService.getSysTime();

        try {
            TaiWanInfo taiWanInfo = new TaiWanInfo();
            taiWanInfo.setGroupName(groupName);
            taiWanInfo.setGoTime(startDate);
            taiWanInfo.setEndTime(endDate);
            taiWanInfo.setTaiDept(taiDept);
            taiWanInfo.setTaiCharge(taiCharge);
            taiWanInfo.setNotes(notes);
            taiWanInfo.setCreateTime(updateTime);
            taiWanInfo.setUpdateTime(updateTime);
            taiWanInfo.setDelFlag("0");

            taiWanInfoService.save(taiWanInfo);
        } catch (Exception e) {
            LOGGER.debug(e.getMessage(), e);
            return ImportExcelEnum.ERROR_ON_SAVE;
        }
        return ImportExcelEnum.SUCCESS;
    }


    /**
     * 根据日期格式格式化日期并返回
     *
     * @param dateStr
     * @return
     */
    private Date dateByFormat(String dateStr) {
        Date date;
        if (dateStr.contains("/")) {
            date = DateUtil.stringToDate(dateStr, DateUtil.FORMAT_DAY_SLASH);
        } else {
            date = DateUtil.stringToDate(dateStr, DateUtil.FORMAT_DAY_CN);
        }

        return date;
    }
}
