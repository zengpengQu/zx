package com.taiji.frame.controller.foreignaffairs.privateAbroad;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.controller.excel.PrivateAbroadExcel;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.privateAbroad.PrivateAbroad;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.service.foreignaffairs.privateAbroad.PrivateAbroadService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.SysLogService;
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
 * 因私出国(境)
 * Created by yuLei on 2018/7/30.
 */
@Controller
@RequestMapping(value = "/private-abroad")
public class PrivateAbroadController extends BaseController<PrivateAbroad> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    private HashMap<String, HashMap<String, String>> hashMapHashMap = null;

    @Autowired
    private PrivateAbroadService privateAbroadService;

    @Autowired
    private DicUserService dicUserService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 跳转至列表页
     * @param map
     * @return
     */
    @RequestMapping(value = "/private-abroad-list", method = RequestMethod.GET)
    public String list(Map<String, Object> map) {
        return "foreignaffairs/privateAbroad/private-abroad-list";
    }

    /**
     * 组装表格数据
     * @param carrier
     * @param groupName
     * @param startTime
     * @param endTime
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-private-abroad-list.do", produces = "text/html;charset=UTF-8")
    public String load(Carrier<PrivateAbroad> carrier, String groupName, String startTime, String endTime) {
        HashMap<String, Object> map = new HashMap();
        try {
            if (StringUtils.isNotEmpty(groupName)) {
                map.put("groupName", "%" + groupName + "%");
            }
            if (StringUtils.isNotEmpty(startTime)) {
                map.put("startTime", startTime);
            }
            if (StringUtils.isNotEmpty(endTime)) {
                map.put("endTime", endTime);
            }
            privateAbroadService.load(carrier, map);
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
    @RequestMapping(value = "/private-abroad-view", method = RequestMethod.GET)
    public String view(ModelMap modelMap, String id) {
        if (StringUtils.isNotEmpty(id)) {
            PrivateAbroad privateAbroad = privateAbroadService.get(id);
            modelMap.put("privateAbroad", privateAbroad);
        }
        return "foreignaffairs/privateAbroad/private-abroad-view";
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/private-abroad-delete.do", method = RequestMethod.POST)
    public Map<String, Object> delete(String id) {
        HashMap<String, Object> map = new HashMap();
        try {
            if (StringUtils.isNotEmpty(id)) {
                PrivateAbroad privateAbroad = privateAbroadService.get(id);
                privateAbroad.setDelFlag("1");
                privateAbroadService.save(privateAbroad);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因私出国(境)");
                    sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(privateAbroad.getDicUser().getEmpName());
                sysLogVo.setEntityId(privateAbroad.getId());
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
     * 跳转至编辑页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/private-abroad-edit", method = RequestMethod.GET)
    public String edit(ModelMap modelMap, String id) {

        PrivateAbroad privateAbroad = new PrivateAbroad();

        if (!StringUtils.isEmpty(id)) {
            privateAbroad = privateAbroadService.get(id);
            modelMap.put("privateAbroad", privateAbroad);
        }
        //人员信息
        List<DicUser> dicUserList = dicUserService.getAll();
        modelMap.put("dicUserList", dicUserList);

        //部门信息
        DicDept dicDept = new DicDept();
        if (null != privateAbroad.getDicDept()) {
            dicDept = privateAbroad.getDicDept();
        }
        modelMap.addAttribute("dicDept",dicDept.getJsonObject());

        //组团部门
        DicDept dicDeptForGroup = new DicDept();

        if (null != privateAbroad.getDicDeptForGroup()) {
            dicDeptForGroup = privateAbroad.getDicDeptForGroup();
        }
        modelMap.addAttribute("dicDeptForGroup",dicDeptForGroup.getJsonObject());

        return "foreignaffairs/privateAbroad/private-abroad-edit";
    }

    /**
     * 保存
     * @param privateAbroad
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/private-abroad-save.do", method = RequestMethod.POST)
    public Map<String, Object> save(@RequestBody PrivateAbroad privateAbroad) {
        Map<String, Object> map = new HashMap<>();
        try {
            String id = privateAbroad.getId();
            if (StringUtils.isNotEmpty(id)) {//编辑
                PrivateAbroad tempPrivateAbroad = privateAbroadService.get(id);
                tempPrivateAbroad.setDicUser(privateAbroad.getDicUser());
                tempPrivateAbroad.setDicDept(privateAbroad.getDicDept());
                tempPrivateAbroad.setStartTime(privateAbroad.getStartTime());
                tempPrivateAbroad.setEndTime(privateAbroad.getEndTime());
                tempPrivateAbroad.setGroupName(privateAbroad.getGroupName());
                tempPrivateAbroad.setDicDeptForGroup(privateAbroad.getDicDeptForGroup());
                tempPrivateAbroad.setNotes(privateAbroad.getNotes());
                tempPrivateAbroad.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                privateAbroadService.save(tempPrivateAbroad);
                map.put("result", true);
            } else {//新增
                privateAbroad.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                privateAbroad.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                privateAbroad.setDelFlag("0");
                privateAbroadService.save(privateAbroad);
                map.put("result", true);
            }
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("因私出国(境)");
            if(org.apache.commons.lang.StringUtils.isEmpty(id)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(privateAbroad.getDicUser().getEmpName());
            sysLogVo.setEntityId(privateAbroad.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 导出
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping(value = "/export-excel.do", method = RequestMethod.GET)
    public void exportExcel(HttpServletRequest request, HttpServletResponse response) {
        try {

            String groupName = new String((request.getParameter("name")).getBytes("iso-8859-1"), "utf-8");
            String signDate = request.getParameter("date1");
            String validDate = request.getParameter("date2");
            SysLogVo sysLogVo = getSysLogVo();

            if("true".equals(groupName)){
                if(hashMapHashMap!=null) {
                    String fileName = "违规因私出国境详细信息.xls";
                    OutputStream os = OtherUtil.getOutputStream(fileName, request, response);
                    PrivateAbroadExcel.createExcel(os, fileName, null, hashMapHashMap);
                    hashMapHashMap=null;
                    sysLogVo.setRecordType(6);
                }
            }else {
                String fileName = "因私出国境详细信息.xls";
                OutputStream os = OtherUtil.getOutputStream(fileName, request, response);
                List<PrivateAbroad> privateAbroadList = privateAbroadService.findPeivateAbroadForExcel(groupName, signDate, validDate);
                PrivateAbroadExcel.createExcel(os, fileName, privateAbroadList,null);
                sysLogVo.setRecordType(7);
            }

            sysLogVo.setTypeName("因私出国(境)");

            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
    }



    /**
     * 上传 Excel
     *
     * @param
     */
    @RequestMapping(value = "/upload-excel.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> importExcel(
            HttpServletRequest request, HttpServletResponse response,
            @RequestParam("uploadExcel") MultipartFile[] files) {
        Map<String, Object> map = new HashMap<>(5);


        // 解析上传的 Excel 文件
        try {
            HashMap<String, HashMap<String, String>> hashMap = null;
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
                    map.put("result", "文件类型错误");
                    continue;
                }
                hashMapHashMap=null;
                hashMapHashMap = parseExcel(originalFilename, workbook);
                inputStream.close();
                if(hashMapHashMap.size()>0){
                    map.put("result", true);
                }else {
                    map.put("result", "导入成功，不存在违法出境人员");
                }
            }

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

        String[] titles = {"姓名"};

        HashMap<String, HashMap<String, String>> map = new HashMap<>();
        HashMap<String, String> result = new HashMap<>();

        Sheet sheet = workbook.getSheetAt(0);
        // 列数
        int rowCount = sheet.getPhysicalNumberOfRows();

        // 检查标题行是否正确
        Row titleRow = sheet.getRow(1);
            Cell cell = titleRow.getCell(0);
            String titleStr = String.valueOf(getCellValue(workbook, cell)).trim();
            if (!titleStr.equals(titles[0])) {
                result.put("-1", "标题栏错误，请检查 Excel 模板是否正确");
                map.put(filename, result);
            }

        List<PrivateAbroad> all = privateAbroadService.findAll();
        List<Integer> strings = new ArrayList<>();
        // 解析 Excel 内容
        for (int i = 2; i < rowCount; i++) {
            // 遍历行
            Row row = sheet.getRow(i);
            if (row != null) {
                Cell cell1 = row.getCell(0);
                Cell cell2 = row.getCell(1);
                String cellValue1 = String.valueOf(getCellValue(workbook, cell1));
                String cellValue2 = String.valueOf(getCellValue(workbook, cell2));
                for (PrivateAbroad o:all) {
                        if(cellValue1.equals(o.getDicUser().getEmpName())
                                && cellValue2.equals(o.getDicDept().getDeptName())){
                            sheet.removeRow(row);
                            break;
                        }
                    }
            }
        }
        int count =0;
        for (int i = 2; i < rowCount; i++) {
            Row row = sheet.getRow(i);
            if (row != null) {
                int firstCellIndex = row.getFirstCellNum();
                int lastCellIndex = row.getLastCellNum();
                HashMap<String, String> cellMap = new HashMap<>(lastCellIndex);
                for (int j = firstCellIndex; j < lastCellIndex; j++) {
                    Cell cell3 = row.getCell(j);
                    String cellValue = String.valueOf(getCellValue(workbook, cell3));
                    cellMap.put("cellValue"+j, cellValue);
                }
                map.put("cellResultMap"+count, cellMap);
                count++;
            }
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



}
