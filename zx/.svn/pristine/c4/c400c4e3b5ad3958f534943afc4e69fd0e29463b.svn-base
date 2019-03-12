package com.taiji.frame.controller.foreignaffairs.privateAbroad;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.controller.excel.PrivatePassportExcel;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.passportRecord.AskReturnRecord;
import com.taiji.frame.model.entity.foreignaffairs.passportRecord.BorrowRecord;
import com.taiji.frame.model.entity.foreignaffairs.privateAbroad.PrivatePassport;
import com.taiji.frame.model.entity.foreignaffairs.privateAbroad.PrivatePassportFile;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.passportuser.PassportUserVo;
import com.taiji.frame.service.foreignaffairs.passportRecord.AskReturnRecordService;
import com.taiji.frame.service.foreignaffairs.passportRecord.BorrowRecordService;
import com.taiji.frame.service.foreignaffairs.privateAbroad.PrivatePassportFileService;
import com.taiji.frame.service.foreignaffairs.privateAbroad.PrivatePassportService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.SysLogService;
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 因私护照管理
 * Created by yuLei on 2018/7/31.
 */
@Controller
@RequestMapping(value = "/private-passport")
public class PrivatePassportController extends BaseController {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private PrivatePassportService privatePassportService;

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private DicUserService dicUserService;

    @Autowired
    private BorrowRecordService borrowRecordService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private PrivatePassportFileService privatePassportFileService;

    @Autowired
    private AskReturnRecordService askReturnRecordService;

    @Autowired
    private SysLogService sysLogService;
    /**
     * 跳转至列表页
     * @param map
     * @return
     */
    @RequestMapping(value = "/private-passport-list", method = RequestMethod.GET)
    public String list(Map<String, Object> map, ModelMap modelMap) {
        DicUser dicUser = getCurUser();
        modelMap.addAttribute("curUser", dicUser);
        return "foreignaffairs/privateAbroad/private-passport-list";
    }

    @RequestMapping(value = "/private-passport-add", method = RequestMethod.GET)
    public String addPage() {
        return "foreignaffairs/privateAbroad/private-passport-add";
    }

    /**
     * 组装表格数据
     * @param carrier
     * @param empName
     * @param cardNumber
     * @param signDate
     * @param validDate
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-private-passport-list.do", produces = "text/html;charset=UTF-8")
    public String load(Carrier<PrivatePassport> carrier, String curUserId, String empName,
                       String cardNumber, String signDate, String validDate) {
        HashMap<String, Object> map = new HashMap();
        try {
            if (StringUtils.isNotEmpty(curUserId)) {
                map.put("curUserId", curUserId);
            }
            if (StringUtils.isNotEmpty(empName)) {
                map.put("empName", "%" + empName + "%");
            }
            if (StringUtils.isNotEmpty(cardNumber)) {
                map.put("cardNumber", "%" + cardNumber + "%");
            }
            if (StringUtils.isNotEmpty(signDate)) {
                map.put("signDate", signDate);
            }
            if (StringUtils.isNotEmpty(validDate)) {
                map.put("validDate", validDate);
            }
            privatePassportService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
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
            privatePassportService.loadUser(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 判断是否可以办理
     * @param userId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/private-passport-is-can-transact.do", method = RequestMethod.POST)
    public Map<String, Object> isCanTransact(String userId) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(userId)) {
                Boolean isCanTransact = privatePassportService.isCanTransact(userId);
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
            LOG.debug(e.getMessage(), e);
        }
        return map;
    }


    /**
     * 跳转到新增页面
     * @param modelMap
     * @param userId
     * @return
     */
    @RequestMapping(value = "/private-passport-transact",method = RequestMethod.GET)
    public String transact(ModelMap modelMap,String userId){
        if(StringUtils.isNotEmpty(userId)){
            DicUser dicUser = dicUserService.get(userId);
            DicDept dicDept = dicUser.getDicDept();

            modelMap.addAttribute("dicDept", dicDept.getJsonObject());
            modelMap.addAttribute("dicUser", dicUser);
        }
        return "foreignaffairs/privateAbroad/private-passport-transact";
    }

    /**
     * 详情查看
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/private-passport-view", method = RequestMethod.GET)
    public String view(ModelMap modelMap, String id) {
        if (StringUtils.isNotEmpty(id)) {
            PrivatePassport privatePassport = privatePassportService.get(id);
            modelMap.put("privatePassport", privatePassport);

            PrivatePassportFile privatePassportFile = privatePassport.getPrivatePassportFile();
            if (null != privatePassportFile) {
                JSONObject jsonFileObject = this.getFileData(privatePassportFile.getFileId());
                modelMap.put("jsonFileObject", jsonFileObject);
            } else {
                modelMap.put("jsonFileObject", null);
            }

            Map<String, List<BorrowRecord>> recordMap = borrowRecordService.findRecordByPermitId(id);
            if (recordMap.size() > 0) {
                modelMap.put("recordMap", recordMap);
            } else {
                modelMap.put("recordMap", null);
            }
        }
        return "foreignaffairs/privateAbroad/private-passport-view";
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/private-passport-delete.do", method = RequestMethod.POST)
    public Map<String, Object> delete(String id) {
        HashMap<String, Object> map = new HashMap();
        try {
            if (StringUtils.isNotEmpty(id)) {
                PrivatePassport privatePassport = privatePassportService.get(id);
                privatePassport.setDelFlag("1");
                privatePassportService.save(privatePassport);
                //流转记录
                BorrowRecord borrowRecord = new BorrowRecord();
                borrowRecord.setStatus("4");
                borrowRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                borrowRecord.setDicUser(getCurUser());
                borrowRecord.setPermitId(id);
                borrowRecord.setPermitType("0");
                borrowRecordService.save(borrowRecord);
                map.put("result", true);

                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因私护照管理");
                    sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(privatePassport.getDicUser().getEmpName());
                sysLogVo.setEntityId(privatePassport.getId());
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
    @RequestMapping(value = "/private-passport-edit", method = RequestMethod.GET)
    public String edit(ModelMap modelMap, String id) {

        PrivatePassport privatePassport = new PrivatePassport();

        if (!StringUtils.isEmpty(id)) {
            privatePassport = privatePassportService.get(id);
            modelMap.put("privatePassport", privatePassport);

            PrivatePassportFile privatePassportFile = privatePassport.getPrivatePassportFile();

            if (null != privatePassportFile) {
                JSONObject jsonFileObject = this.getFileData(privatePassportFile.getFileId());
                modelMap.put("jsonFileObject", jsonFileObject);
            } else {
                modelMap.put("jsonFileObject", null);
            }
        }
        //人员信息
        List<DicUser> dicUserList = dicUserService.getAll();
        modelMap.put("dicUserList", dicUserList);

        //部门信息
        DicDept dicDept = new DicDept();
        if (null != privatePassport.getDicDept()) {
            dicDept = privatePassport.getDicDept();
        }
        modelMap.addAttribute("dicDept",dicDept.getJsonObject());

        return "foreignaffairs/privateAbroad/private-passport-edit";
    }

    /**
     * 保存
     * @param privatePassport
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/private-passport-save.do", method = RequestMethod.POST)
    public Map<String, Object> save(@RequestBody PrivatePassport privatePassport, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();

        String dstDir = UploadConstant.privatePassport;

        try {
            String id = privatePassport.getId();
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("因私护照管理");
            if (StringUtils.isNotEmpty(id)) {//编辑
                PrivatePassport tempPrivatePassport = privatePassportService.get(id);
                tempPrivatePassport.setDicUser(privatePassport.getDicUser());
                tempPrivatePassport.setDicDept(privatePassport.getDicDept());
                tempPrivatePassport.setPassportCode(privatePassport.getPassportCode());
                tempPrivatePassport.setSignOrg(privatePassport.getSignOrg());
                tempPrivatePassport.setSignDate(privatePassport.getSignDate());
                tempPrivatePassport.setValidDate(privatePassport.getValidDate());
                tempPrivatePassport.setNotes(privatePassport.getNotes());
                tempPrivatePassport.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                privatePassportService.save(tempPrivatePassport);
                //附件上传
                PrivatePassportFile privatePassportFile = privatePassport.getPrivatePassportFile();
                if (null != privatePassportFile) {
                    String fileId = privatePassportFile.getFileId();
                    Boolean isExist = privatePassportFileService.findByBPIdAndFileId(id, fileId);
                    //不存在--新上传的附件
                    if (!isExist) {
                        DicUploadFile dicUploadFile = dicUploadFileService.get(fileId);
                        dicUploadFileService.transfer(dicUploadFile, dstDir);
                        PrivatePassportFile file = privatePassportFileService.findBPId(id);
                        //之前上传过附件,更新
                        if (null != file) {
                            // 删除旧附件
                            dicUploadFileService.logicDeleteFile(file.getFileId());

                            file.setFileId(fileId);
                            privatePassportFileService.save(file);
                        } else {
                            //原本就不存在附件,新增
                            privatePassportFile.setPrivatePassport(privatePassport);
                            privatePassportFileService.save(privatePassportFile);
                        }
                    }
                }
                map.put("result", true);
                sysLogVo.setRecordType(1);
                sysLogVo.setEntityName(tempPrivatePassport.getDicUser().getEmpName());
                sysLogVo.setEntityId(tempPrivatePassport.getId());
            } else {//新增
                privatePassport.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                privatePassport.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                privatePassport.setDelFlag("0");
                privatePassport.setStoreStatus("0");
                privatePassportService.save(privatePassport);
                //流转记录
                BorrowRecord borrowRecord = new BorrowRecord();
                borrowRecord.setStatus("0");
                borrowRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                borrowRecord.setDicUser(getCurUser());
                borrowRecord.setPermitId(privatePassport.getId());
                borrowRecord.setPermitType("0");
                borrowRecordService.save(borrowRecord);
                //附件上传
                PrivatePassportFile privatePassportFile = privatePassport.getPrivatePassportFile();
                if (null != privatePassportFile) {
                    String fileId = privatePassportFile.getFileId();
                    DicUploadFile dicUploadFile = dicUploadFileService.get(fileId);
                    dicUploadFileService.transfer(dicUploadFile, dstDir);
                    privatePassportFile.setPrivatePassport(privatePassport);
                    privatePassportFileService.save(privatePassportFile);
                }
                map.put("result", true);
                sysLogVo.setRecordType(0);
                sysLogVo.setEntityName(borrowRecord.getDicUser().getEmpName());
                sysLogVo.setEntityId(borrowRecord.getId());
            }
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 借出
     * @param id
     * @param borrower
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/private-passport-borrow.do", method = RequestMethod.POST)
    public Map<String, Object> borrow(String id, String borrower, String borrowNotes) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)) {
                PrivatePassport privatePassport = privatePassportService.get(id);
                privatePassport.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                privatePassport.setStoreStatus("1");
                privatePassportService.save(privatePassport);
                //流转记录
                BorrowRecord borrowRecord = new BorrowRecord();
                borrowRecord.setStatus("1");
                borrowRecord.setBorrower(borrower);
                borrowRecord.setBorrowTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                borrowRecord.setNotes(borrowNotes);
                borrowRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                borrowRecord.setDicUser(getCurUser());
                borrowRecord.setPermitId(id);
                borrowRecord.setPermitType("0");
                borrowRecordService.save(borrowRecord);
                map.put("result", true);

                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因私护照管理");
                    sysLogVo.setRecordType(22);
                sysLogVo.setEntityName(borrowRecord.getDicUser().getEmpName());
                sysLogVo.setEntityId(borrowRecord.getId());
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
     * 归还
     * @param id
     * @param returnPeople
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/private-passport-return.do", method = RequestMethod.POST)
    public Map<String, Object> returnBack(String id, String returnPeople, String returnNotes) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)) {
                PrivatePassport privatePassport = privatePassportService.get(id);
                privatePassport.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                privatePassport.setStoreStatus("0");
                privatePassportService.save(privatePassport);
                //流转记录
                BorrowRecord borrowRecord = new BorrowRecord();
                borrowRecord.setStatus("2");
                borrowRecord.setReturnPeople(returnPeople);
                borrowRecord.setReturnTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                borrowRecord.setNotes(returnNotes);
                borrowRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                borrowRecord.setDicUser(getCurUser());
                borrowRecord.setPermitId(id);
                borrowRecord.setPermitType("0");
                borrowRecordService.save(borrowRecord);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因私护照管理");
                sysLogVo.setRecordType(23);
                sysLogVo.setEntityName(borrowRecord.getDicUser().getEmpName());
                sysLogVo.setEntityId(borrowRecord.getId());
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
     * 催还
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/private-passport-ask-return.do", method = RequestMethod.POST)
    public Map<String, Object> askReturn(String id, String askContent, String askReturnNotes) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)) {
                PrivatePassport privatePassport = privatePassportService.get(id);
                AskReturnRecord askReturnRecord = new AskReturnRecord();
                askReturnRecord.setAskContent(askContent);
                askReturnRecord.setDelFlag("0");
                askReturnRecord.setDicUser(getCurUser());
                askReturnRecord.setDocumentCode(privatePassport.getPassportCode());
                askReturnRecord.setNotes(askReturnNotes);
                askReturnRecord.setPeopleName(privatePassport.getDicUser().getEmpName());
                askReturnRecord.setPermitId(id);
                askReturnRecord.setPermitType("0");
                askReturnRecord.setAskTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                askReturnRecord.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                askReturnRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                askReturnRecordService.save(askReturnRecord);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因私护照管理");
                sysLogVo.setRecordType(24);
                sysLogVo.setEntityName(askReturnRecord.getDicUser().getEmpName());
                sysLogVo.setEntityId(askReturnRecord.getId());
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
     * 导出
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping(value = "/export-excel.do", method = RequestMethod.GET)
    public void exportExcel(HttpServletRequest request, HttpServletResponse response) {
        try {
            String empName = new String((request.getParameter("name")).getBytes("iso-8859-1"), "utf-8");
            String cardNumber = request.getParameter("number");
            String signDate = request.getParameter("date1");
            String validDate = request.getParameter("date2");
            List<PrivatePassport> privatePassportList = privatePassportService.findPrivatePassportForExcel(empName, cardNumber, signDate, validDate);
            String fileName = "因私护照详细信息.xls";
            //设置输入流参数
            OutputStream os = OtherUtil.getOutputStream(fileName, request, response);
            String dateStr = DateUtil.getDateStr(getCurDate());
            String userName = getCurUser().getEmpName();
            PrivatePassportExcel.createExcel(os, fileName, dateStr, userName, privatePassportList);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("因私护照管理");
            sysLogVo.setRecordType(7);
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
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
