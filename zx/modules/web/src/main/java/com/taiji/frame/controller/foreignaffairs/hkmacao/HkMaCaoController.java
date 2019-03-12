package com.taiji.frame.controller.foreignaffairs.hkmacao;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.model.entity.foreignaffairs.hkmacao.HkMaCao;
import com.taiji.frame.model.entity.foreignaffairs.hkmacao.HkMaCaoFile;
import com.taiji.frame.model.entity.foreignaffairs.passportRecord.BorrowRecord;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.hkmacao.HkMaCaoVo;
import com.taiji.frame.model.vo.passportuser.PassportUserVo;
import com.taiji.frame.service.foreignaffairs.hkmacao.HkMaCaoFileService;
import com.taiji.frame.service.foreignaffairs.hkmacao.HkMaCaoService;
import com.taiji.frame.service.foreignaffairs.passportRecord.BorrowRecordService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.SysLogService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
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
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.*;

/**
 * @author qzp
 * @date 2018/08/01
 * 港澳通行证管理
 */
@Controller
@RequestMapping("/hk-macao")
public class HkMaCaoController extends BaseController {
    private static final Logger log = LoggerFactory.getLogger(HkMaCaoController.class);

    @Autowired
    private HkMaCaoService hkMaCaoService;

    @Autowired
    private HkMaCaoFileService hkMaCaoFileService;

    @Autowired
    private DicUserService dicUserService;

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private BorrowRecordService borrowRecordService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 页面跳转
     * @return
     */
    @RequestMapping(value = "/hk-macao-list",method = RequestMethod.GET)
    public String jumpPage(ModelMap modelMap) {
        DicUser dicUser = getCurUser();
        modelMap.addAttribute("curUser", dicUser);
        return "foreignaffairs/hkmacao/hk-macao-list";
    }

    @RequestMapping(value = "/hk-macao-add", method = RequestMethod.GET)
    public String addPage() {
        return "foreignaffairs/hkmacao/hk-macao-add";
    }

    /**
     * 港澳通行证管理数据列表
     * @param carrier
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-hk-macao-list.do",produces = "text/html;charset=UTF-8")
    public String list(Carrier<HkMaCao> carrier, String curUserId,
                    String empName,String permitCode,
                    String signDate,String validDate){
        HashMap<String, Object> map = new HashMap();
        Date currDate = DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT);
        try {
            if(StringUtils.isNotEmpty(curUserId)){
                map.put("curUserId", curUserId);
            }
            if(StringUtils.isNotEmpty(empName)){
                map.put("empName","%" + empName + "%");
            }
            if(StringUtils.isNotEmpty(permitCode)){
                map.put("permitCode","%" + permitCode + "%");
            }
            if(StringUtils.isNotEmpty(signDate)){
                map.put("signDate",signDate);
            }
            if(StringUtils.isNotEmpty(validDate)){
                map.put("validDate",validDate);
            }
            hkMaCaoService.load(carrier, map,currDate);
        }catch (Exception e){
            log.error(e.getMessage(),e);
        }
        return gridResult(carrier);
    }


    @ResponseBody
    @RequestMapping(value = "/load-user.do", produces = "text/html;charset=UTF-8")
    public String loadUser(Carrier<PassportUserVo> carrier, String searchDeptId, String empName, String searchUserId, String rankId) {
        Map<String, Object> map = new HashMap<>(3);
        try {

            if (null != empName && !"".equals(empName)) {
                map.put("empName", "%" + empName + "%");
            }
            if (null != searchUserId && !"".equals(searchUserId)) {
                map.put("searchUserId", "%" + searchUserId + "%");
            }

            if (null != rankId && !"".equals(rankId)) {
                map.put("rankId",rankId);
            }
            if (!StringUtils.isEmpty(searchDeptId)) {

                List<DicDept> deptList = dicDeptService.getBelongDept(searchDeptId);
                List<String> stringList = new ArrayList<>();
                if (deptList.size() > 0) {
                    for (DicDept dicDept : deptList) {
                        stringList.add(dicDept.getId());
                    }
                }
                map.put("stringList", stringList);
            }
            hkMaCaoService.loadUser(carrier, map);
        } catch (Exception e) {
            log.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 判断是否可以办理
     * @param userId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/hk-macao-is-can-transact.do", method = RequestMethod.POST)
    public Map<String, Object> isCanTransact(String userId) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(userId)) {
                Boolean isCanTransact = hkMaCaoService.isCanTransact(userId);
                //可以办理
                if (isCanTransact) {
                    map.put("result", true);
                }
                //已经办理过
                else {
                    map.put("result", false);
                }
            }
        } catch (Exception e) {
            log.debug(e.getMessage(), e);
        }
        return map;
    }


    /**
     * 跳转到新增页面
     * @param modelMap
     * @param userId
     * @return
     */
    @RequestMapping(value = "/hk-macao-transact",method = RequestMethod.GET)
    public String transact(ModelMap modelMap,String userId){
        if(StringUtils.isNotEmpty(userId)){
            DicUser dicUser = dicUserService.get(userId);
            DicDept dicDept = dicUser.getDicDept();

            modelMap.addAttribute("dicDept", dicDept.getJsonObject());
            modelMap.addAttribute("dicUser", dicUser);
        }
        return "foreignaffairs/hkmacao/hk-macao-transact";
    }

    /**
     * 跳转到新增或编辑页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/hk-macao-edit",method = RequestMethod.GET)
    public String jumpSaveOrEdit(ModelMap modelMap,String id){
        HkMaCao hkMaCao = null;
        //部门信息
        DicDept dicDept = new DicDept();
        if(StringUtils.isNotEmpty(id)){
            hkMaCao = hkMaCaoService.get(id);
            HkMaCaoFile hkMaCaoFile = hkMaCaoFileService.getHkMacao(id);
            if (null != hkMaCaoFile){
                JSONObject jsonFileObject = this.getFileData(hkMaCaoFile.getDicUploadFile().getId());
                modelMap.put("jsonFileObject", jsonFileObject);
            } else {
                modelMap.put("jsonFileObject", null);
            }
            if (null != hkMaCao.getDicDept()) {
                dicDept = hkMaCao.getDicDept();
            }
        }
        //人员信息
        List<DicUser> dicUserList = dicUserService.getAll();
        modelMap.addAttribute("dicUserList",dicUserList);
        modelMap.addAttribute("hkMaCao",hkMaCao);

        modelMap.addAttribute("dicDept",dicDept.getJsonObject());

        return "foreignaffairs/hkmacao/hk-macao-edit";
    }

    /**
     * 新增或编辑数据保存
     * @param hkMaCaoVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-hk-macao-save.do",method = RequestMethod.POST)
    public Map<String,Object> saveOrUpdateData(HkMaCaoVo hkMaCaoVo, HttpServletRequest request) throws ParseException {
        String basePath = UploadConstant.uploadBaseDir;
        Map<String,Object> map = hkMaCaoService.saveData(hkMaCaoVo,basePath,getSysLogVo());
        return map;
    }

    /**
     * 删除港澳通行证某条信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-hk-macao-delete.do",method = RequestMethod.POST)
    public Map<String,Object> delHkMacao(String id){
        HashMap map = new HashMap(3);
        try {
            HkMaCao hkMaCao = hkMaCaoService.get(id);
            hkMaCao.setDelFlag("1");
            hkMaCaoService.save(hkMaCao);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("港澳通行证管理");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(hkMaCao.getDicUser().getEmpName());
            sysLogVo.setEntityId(hkMaCao.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            map.put("result",true);
        }catch (Exception e){
            log.error(e.getMessage(),e);
            map.put("result",false);
            return map;
        }
        return map;
    }

    /**
     * 查看详情
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/hk-macao-view",method = RequestMethod.GET)
    public String view (ModelMap modelMap,String id){
        if(StringUtils.isNotEmpty(id)){
            HkMaCao hkMaCao = hkMaCaoService.get(id);
            modelMap.addAttribute("hkMaCao",hkMaCao);
            HkMaCaoFile hkMaCaoFile = hkMaCaoFileService.getHkMacao(id);
            if (null != hkMaCaoFile) {
                JSONObject jsonFileObject = getFileData(hkMaCaoFile.getDicUploadFile().getId());
                modelMap.put("jsonFileObject", jsonFileObject);
            }
            Map<String, List<BorrowRecord>> recordMap = borrowRecordService.findRecordByPermitId(id);
            if (recordMap.size() > 0) {
                modelMap.put("recordMap", recordMap);
            } else {
                modelMap.put("recordMap", null);
            }
        }
        return "foreignaffairs/hkmacao/hk-macao-view";
    }

    /**
     * 判断选中的数据是否存在已注销、已销毁或者已借出的
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/is-exist-cancel.do", method = RequestMethod.POST)
    public Map<String, Object> isExistCancel(String ids) {
        Map<String, Object> map = new HashMap<>();
        Boolean destroyed = false;
        Boolean borrowed = false;
        Boolean overdue = false;
        try {
            if (StringUtils.isNotEmpty(ids)) {
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0; i < jsonArray.size(); i++) {
                    String id = (String) jsonArray.get(i);
                    HkMaCao hkMaCao = hkMaCaoService.get(id);
                    String isDestroy = hkMaCao.getDestroy();
                    String isBorrow = hkMaCao.getStoreStatus();
                    String useStatus = hkMaCao.getUseStatus();
                    if ("1".equals(isDestroy)) {
                        destroyed = true;
                    }
                    //使用状态(0正常、1临近逾期、2已逾期)
                    if ("2".equals(useStatus)) {
                        overdue = true;
                    }

                    if ("1".equals(isBorrow)) {
                        borrowed = true;
                    }
                }

                if (destroyed) {
                    //存在已销毁
                    map.put("result", "destroyed");
                } else if (overdue) {
                    map.put("result", "overdue");
                }  else if (borrowed) {
                    //存在已借出
                    map.put("result", "borrowed");
                } else {
                    map.put("result", true);
                }
            }
        } catch (Exception e) {
            log.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }
    /**
     * 借出--来往港澳通行证
     * @param ids
     * @param borrower
     * @param borrowTimeStr
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/hk-macao-borrow.do",method = RequestMethod.POST)
    public Map<String,Object> borrowHkMacao(
            String ids,String borrower,String borrowTimeStr){
        Date updteTime = DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT);
        Date createTime = DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT);
        DicUser curUser = getCurUser();
        Map<String, Object> map = hkMaCaoService.borrowHkMacao(ids,borrower,curUser,borrowTimeStr,updteTime,createTime,getSysLogVo());
        return map;
    }

    /**
     * 判断选中的数据是否存在已归还的
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/is-exist-return.do", method = RequestMethod.POST)
    public Map<String, Object> isExistReturn(String ids) {
        Map<String, Object> map = new HashMap<>();
        Boolean returned = false;
        try {
            if (StringUtils.isNotEmpty(ids)) {
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0; i < jsonArray.size(); i++) {
                    String id = (String) jsonArray.get(i);
                    HkMaCao hkMaCao = hkMaCaoService.get(id);
                    String isBorrow = hkMaCao.getStoreStatus();
                    if (isBorrow.equals("0")) {
                        returned = true;
                        break;
                    }
                }
                if (returned) {//存在已归还的
                    map.put("result", "returned");
                } else {
                    map.put("result", true);
                }
            }
        } catch (Exception e) {
            log.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


    /**
     * 归还--来往港澳通行证
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/business-hk-macao-back.do",method = RequestMethod.POST)
    public Map<String,Object> returnBack(
            String ids,String returnPeople,String returnTimeStr){
        Date updteTime = DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT);
        Date createTime = DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT);
        DicUser curUser = getCurUser();
        Map<String,Object> map = hkMaCaoService.returnBack(ids,returnPeople,returnTimeStr,updteTime,createTime,curUser,getSysLogVo());
        return map;
    }

    /**
     * 判断选中的数据是否存在已销毁或者已借出的
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/is-exist-destroy.do", method = RequestMethod.POST)
    public Map<String, Object> isExistDestroy(String ids) {
        Map<String, Object> map = new HashMap<>();
        Boolean destroyed = false;
        Boolean borrowed = false;
        try {
            if (StringUtils.isNotEmpty(ids)) {
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0; i < jsonArray.size(); i++) {
                    String id = (String) jsonArray.get(i);
                    HkMaCao hkMaCao = hkMaCaoService.get(id);
                    String isDestroy = hkMaCao.getDestroy();
                    String isBorrow = hkMaCao.getStoreStatus();
                    if (isDestroy.equals("1")) {
                        destroyed = true;
                    }
                    if (isBorrow.equals("1")) {
                        borrowed = true;
                    }
                }
                if (destroyed) {//存在已销毁
                    map.put("result", "destroyed");
                } else if (borrowed) {//存在已借出
                    map.put("result", "borrowed");
                } else {
                    map.put("result", true);
                }
            }
        } catch (Exception e) {
            log.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 销毁--来往港澳通行证
     * @param ids
     * @param destroyReason
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/hk-macao-destroy.do",method = RequestMethod.POST)
    public Map<String,Object> destroyHkMacao(String ids,String destroyReason){
        Date destroyDate = DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT);
        Date updateTime = DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT);
        Map<String,Object> map = hkMaCaoService.destroyHkMacao(ids,destroyReason,updateTime,destroyDate,getSysLogVo());
        return map;
    }

    /**
     * 导出报表
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping(value = "/export-excel.do",method = RequestMethod.GET)
    public void exportExcel(HttpServletRequest request, HttpServletResponse response){
        try {
            String signDate = request.getParameter("date1");
            String validDate = request.getParameter("date2");
            String permitCode = request.getParameter("permitCode");
            String empName = new String((request.getParameter("empName")).getBytes("iso-8859-1"),"utf-8");
            List<HkMaCao> list = hkMaCaoService.findList(empName,permitCode,signDate,validDate);
            String fileName = "港澳通行证信息.xls";
            //设置输入流参数

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("导出港澳通行证信息");
                sysLogVo.setRecordType(7);
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            OutputStream os = OtherUtil.getOutputStream(fileName, request, response);
            //导出报表
            createExcel(os, fileName, list);
        } catch (Exception e) {
            log.error(e.getMessage(),e);
        }
    }
    //导出报表
    public void createExcel(OutputStream os, String fileName,List<HkMaCao> list)
            throws IOException,IndexOutOfBoundsException{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        process(workbook, sheet, list);
        workbook.write(os);
    }

    /**
     * 将数据写入Excel中
     * @param workbook
     * @param sheet
     * @param list
     */
    private void process(HSSFWorkbook workbook, HSSFSheet sheet, List<HkMaCao> list) {
        int count = 0;
        //第一行 标题样式
        CellStyle sty = workbook.createCellStyle();
        //设置标题字体格式
        Font fon = workbook.createFont();
        //设置字体样式, 设置字体大小
        fon.setFontHeightInPoints((short) 18);
        // 设置字体，是什么类型例如：宋体
        fon.setFontName("宋体");
        //加粗,居中
        fon.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        sty.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        sty.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //表格边框
        sty.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        sty.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        sty.setBorderRight(HSSFCellStyle.BORDER_THIN);
        sty.setBorderTop(HSSFCellStyle.BORDER_THIN);
        // 将字体格式加入到style中
        sty.setFont(fon);
        Row titleRow = sheet.createRow(count);
        sheet.addMergedRegion(new CellRangeAddress(count, (short) count, 0, (short) 6));
        //创建一个单元格
        Cell cell1 = titleRow.createCell(count);
        cell1.setCellStyle(sty);
        cell1.setCellValue("港澳通行证信息");
        count++;

        //表头样式
        CellStyle style1 = workbook.createCellStyle();
        style1.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        style1.setFillForegroundColor(HSSFColor.WHITE.index);
        style1.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style1.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style1.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style1.setBorderTop(HSSFCellStyle.BORDER_THIN);
        //设置标题字体格式
        Font font1 = workbook.createFont();
        //设置字体样式
        font1.setFontHeightInPoints((short) 14);
        font1.setFontName("黑体");
        font1.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style1.setFont(font1);

        Row row4 = sheet.createRow(count);
        Cell cell5_0 = row4.createCell(0);
        cell5_0.setCellStyle(style1);
        cell5_0.setCellValue(" 姓名  ");
        Cell cell5_1 = row4.createCell(1);
        cell5_1.setCellStyle(style1);
        cell5_1.setCellValue(" 性别  ");
        Cell cell5_2 = row4.createCell(2);
        cell5_2.setCellStyle(style1);
        cell5_2.setCellValue("  证件号码   ");
        Cell cell5_3 = row4.createCell(3);
        cell5_3.setCellStyle(style1);
        cell5_3.setCellValue("  工作部门   ");
        Cell cell5_4 = row4.createCell(4);
        cell5_4.setCellStyle(style1);
        cell5_4.setCellValue("  签发日期   ");
        Cell cell5_5 = row4.createCell(5);
        cell5_5.setCellStyle(style1);
        cell5_5.setCellValue("  有效期至   ");
        Cell cell5_6 = row4.createCell(6);
        cell5_6.setCellStyle(style1);
        cell5_6.setCellValue("  签发机关   ");
        sheet.autoSizeColumn(0);
        sheet.autoSizeColumn(1);
        sheet.autoSizeColumn(2);
        sheet.autoSizeColumn(3);
        sheet.autoSizeColumn(4);
        sheet.autoSizeColumn(5);
        sheet.autoSizeColumn(6);
        count++;

        //样式对象 数据样式
        CellStyle style = workbook.createCellStyle();
        //设置标题字体格式
        Font font = workbook.createFont();
        //设置字体样式, 设置字体大小
        font.setFontHeightInPoints((short) 10);
        // 设置字体，是什么类型例如：宋体
        font.setFontName("黑体");
        //加粗,居中
        font.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //表格边框
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        //自动换行,不能设置 行高
        style.setFont(font);
        style.setWrapText(true);

        for (int i = 0; i < list.size(); i++) {
            HkMaCao hkMaCao = list.get(i);
            Row row = sheet.createRow(count + i);
            String userName = null == hkMaCao.getDicUser() ? "" : hkMaCao.getDicUser().getEmpName();
            String sex = null == hkMaCao.getDicUser() ? "" : hkMaCao.getDicUser().getSexStr();
            String permitCode = null == hkMaCao.getPermitCode() ? "" : hkMaCao.getPermitCode();
            String deptName = null == hkMaCao.getDicDept() ? "" : hkMaCao.getDicDept().getDeptName();
            String signDate = null == hkMaCao.getSignDate() ? "" : DateUtil.dateToString(hkMaCao.getSignDate(), DateUtil.FORMAT_DAY);
            String validDate = null == hkMaCao.getValidDate() ? "" : DateUtil.dateToString(hkMaCao.getValidDate(), DateUtil.FORMAT_DAY);
            String signOrg = null == hkMaCao.getSignOrg() ? "" : hkMaCao.getSignOrg();

            Cell cell_0 = row.createCell(0);
            cell_0.setCellValue(userName);
            cell_0.setCellStyle(style);

            Cell cell_1 = row.createCell(1);
            cell_1.setCellValue(sex);
            cell_1.setCellStyle(style);

            Cell cell_2 = row.createCell(2);
            cell_2.setCellValue(permitCode);
            cell_2.setCellStyle(style);

            Cell cell_3 = row.createCell(3);
            cell_3.setCellValue(deptName);
            cell_3.setCellStyle(style);

            Cell cell_4 = row.createCell(4);
            cell_4.setCellValue(signDate);
            cell_4.setCellStyle(style);

            Cell cell_5 = row.createCell(5);
            cell_5.setCellValue(validDate);
            cell_5.setCellStyle(style);

            Cell cell_6 = row.createCell(6);
            cell_6.setCellValue(signOrg);
            cell_6.setCellStyle(style);

        }
    }

    private JSONObject getFileData(String fileId) {
        JSONObject jsonFileObject = new JSONObject();
        DicUploadFile dicUploadFile = dicUploadFileService.get(fileId);
        jsonFileObject.put("id", fileId);
        jsonFileObject.put("fileName", dicUploadFile.getFileName());
        return jsonFileObject;
    }
}
