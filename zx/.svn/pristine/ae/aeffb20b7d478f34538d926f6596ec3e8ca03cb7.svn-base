package com.taiji.frame.controller.foreignaffairs.BusinessPassport;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.businessPassport.*;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.passportuser.PassportUserVo;
import com.taiji.frame.service.foreignaffairs.businessPassport.BorrowReturnRecordService;
import com.taiji.frame.service.foreignaffairs.businessPassport.BusinessPassportFileService;
import com.taiji.frame.service.foreignaffairs.businessPassport.BusinessPassportService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.SysLogService;
import net.sf.json.JSONArray;
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
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 因公护照管理
 * Created by yuLei on 2018/7/23.
 */
@Controller
@RequestMapping(value = "/business-passport")
public class BusinessPassportController extends BaseController {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private BusinessPassportService businessPassportService;

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private DicUserService dicUserService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private BusinessPassportFileService businessPassportFileService;

    @Autowired
    private BorrowReturnRecordService borrowReturnRecordService;
    @Autowired
    private SysLogService sysLogService;


    /**
     * 跳转至列表页
     * @param map
     * @return
     */
    @RequestMapping(value = "/business-passport-list", method = RequestMethod.GET)
    public String list(Map<String, Object> map, ModelMap modelMap) {
        DicUser dicUser = getCurUser();
        modelMap.addAttribute("curUser", dicUser);
        return "foreignaffairs/businessPassport/business-passport-list";
    }

    /**
     * 组装表格数据
     * @param carrier
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-business-passport-list.do", produces = "text/html;charset=UTF-8")
    public String dutyListLoad(Carrier<BusinessPassport> carrier, String curUserId, String userName,
                               String passportNo, String validDate, String batchNumber) {
        HashMap<String, Object> map = new HashMap();
        try {
            if (StringUtils.isNotEmpty(curUserId)) {
                map.put("curUserId", curUserId);
            }
            if (StringUtils.isNotEmpty(userName)) {
                map.put("userName", "%" + userName + "%");
            }
            if (StringUtils.isNotEmpty(passportNo)) {
                map.put("passportNo", "%" + passportNo + "%");
            }
            if (StringUtils.isNotEmpty(validDate)) {
                map.put("validDate", validDate);
            }
            if (StringUtils.isNotEmpty(batchNumber)) {
                map.put("batchNumber", batchNumber);
            }
            businessPassportService.load(carrier, map);
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
            businessPassportService.loadUser(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }


    /**
     * 跳转至新增页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/business-passport-add", method = RequestMethod.GET)
    public String edit(ModelMap modelMap, String id) {
        if (StringUtils.isNotEmpty(id)) {
            BusinessPassport businessPassport = businessPassportService.get(id);
            modelMap.put("businessPassport", businessPassport);
        }
        return "foreignaffairs/businessPassport/business-passport-add";
    }

    /**
     * 判断是否可以办理
     * @param userId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/business-passport-is-can-transact.do", method = RequestMethod.POST)
    public Map<String, Object> isCanTransact(String userId) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(userId)) {
                Boolean isCanTransact = businessPassportService.isCanTransact(userId);
                if (isCanTransact) {//可以办理
                    map.put("result", true);
                } else {//已经办理过
                    map.put("result", false);
                }
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return map;
    }

    /**
     * 跳转至办理页面
     * @param modelMap
     * @param userId
     * @return
     */
    @RequestMapping(value = "/business-passport-transact", method = RequestMethod.GET)
    public String toTransact(ModelMap modelMap, String userId) {
        if (StringUtils.isNotEmpty(userId)) {
            DicUser dicUser = dicUserService.get(userId);
            modelMap.put("dicUser", dicUser);
            DicDept dicDepts = dicUser.getDicDept();
            modelMap.put("dicDepts",dicDepts);
        }
        return "foreignaffairs/businessPassport/business-passport-transact";
    }

    /**
     * 办理因公护照
     * @param businessPassport
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/business-passport-transact.do", method = RequestMethod.POST)
    public Map<String, Object> transact(@RequestBody BusinessPassport businessPassport, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();

        String dstDir = UploadConstant.businessPassport;

        try {
            String id = businessPassport.getId();
            //编辑
            if (StringUtils.isNotEmpty(id)) {
                BusinessPassport tempBusinessPassport = businessPassportService.get(id);
                tempBusinessPassport.setPassportNo(businessPassport.getPassportNo());
                tempBusinessPassport.setIssuePlace(businessPassport.getIssuePlace());
                tempBusinessPassport.setIssueDate(businessPassport.getIssueDate());
                tempBusinessPassport.setValidDate(businessPassport.getValidDate());
                tempBusinessPassport.setKeepUnit(businessPassport.getKeepUnit());
                tempBusinessPassport.setStoreAddress(businessPassport.getStoreAddress());
                tempBusinessPassport.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                businessPassportService.save(tempBusinessPassport);
                //附件上传
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因公护照");
                    sysLogVo.setRecordType(1);
                sysLogVo.setEntityName(tempBusinessPassport.getDicUser().getEmpName());
                sysLogVo.setEntityId(tempBusinessPassport.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
                BusinessPassportFile businessPassportFile = businessPassport.getBusinessPassportFile();
                if (null != businessPassportFile) {
                    String fileId = businessPassportFile.getFileId();
                    Boolean isExist = businessPassportFileService.findByBPIdAndFileId(id, fileId);
                    //不存在--新上传的附件
                    if (!isExist) {
                        DicUploadFile dicUploadFile = dicUploadFileService.get(fileId);
                        dicUploadFileService.transfer(dicUploadFile, dstDir);
                        BusinessPassportFile file = businessPassportFileService.findBPId(id);
                        // 之前上传过附件,更新
                        if (null != file) {
                            // 删除旧附件
                            dicUploadFileService.logicDeleteFile(file.getFileId());

                            file.setFileId(fileId);
                            businessPassportFileService.save(file);
                        } else {
                            //原本就不存在附件,新增
                            businessPassportFile.setBusinessPassport(businessPassport);
                            businessPassportFileService.save(businessPassportFile);
                        }
                    }
                }
            } else {//办理(新增)
                businessPassport.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                businessPassport.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                businessPassport.setDelFlag("0");
                businessPassport.setIsCancel("0");
                businessPassport.setIsDestroy("0");
                businessPassport.setIsBorrow("0");
                businessPassportService.save(businessPassport);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因公护照");
                sysLogVo.setRecordType(1);
                sysLogVo.setEntityName(businessPassport.getDicUser().getEmpName());
                sysLogVo.setEntityId(businessPassport.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
                //附件上传
                BusinessPassportFile businessPassportFile = businessPassport.getBusinessPassportFile();
                if (null != businessPassportFile) {
                    String fileId = businessPassportFile.getFileId();
                    DicUploadFile dicUploadFile = dicUploadFileService.get(fileId);
                    dicUploadFileService.transfer(dicUploadFile, dstDir);
                    businessPassportFile.setBusinessPassport(businessPassport);
                    businessPassportFileService.save(businessPassportFile);
                }
            }
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 详情查看
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/business-passport-view", method = RequestMethod.GET)
    public String view(ModelMap modelMap, String id) {
        if (StringUtils.isNotEmpty(id)) {
            BusinessPassport businessPassport = businessPassportService.get(id);
            businessPassport.getJsonObject();
            modelMap.put("businessPassport", businessPassport);

            BusinessPassportFile businessPassportFile = businessPassport.getBusinessPassportFile();
            if (null != businessPassportFile) {
                JSONObject jsonFileObject = this.getFileData(businessPassportFile.getFileId());
                modelMap.put("jsonFileObject", jsonFileObject);
            } else {
                modelMap.put("jsonFileObject", null);
            }

            Map<String, List<BorrowReturnRecord>> recordMap = borrowReturnRecordService.findRecordByBPId(id);
            if (recordMap.size() > 0) {
                modelMap.put("recordMap", recordMap);
            } else {
                modelMap.put("recordMap", null);
            }
        }
        return "foreignaffairs/businessPassport/business-passport-view";
    }

    /**
     * 因公护照删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/business-passport-delete.do", method = RequestMethod.POST)
    public Map<String, Object> delete(String id) {
        HashMap map = new HashMap();
        try {
            BusinessPassport businessPassport = businessPassportService.get(id);
            businessPassport.setDelFlag("1");
            businessPassportService.save(businessPassport);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("因公护照");
            sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(businessPassport.getDicUser().getEmpName());
            sysLogVo.setEntityId(businessPassport.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
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
    @RequestMapping(value = "/business-passport-edit", method = RequestMethod.GET)
    public String delete(ModelMap modelMap, String id) {
        if (StringUtils.isNotEmpty(id)) {
            BusinessPassport businessPassport = businessPassportService.get(id);
            businessPassport.getJsonObject();
            String userId = businessPassport.getDicUser().getId();
            if (StringUtils.isNotEmpty(userId)) {
                DicUser dicUser = dicUserService.get(userId);
                modelMap.put("dicUser", dicUser);
            }


            BusinessPassportFile businessPassportFile = businessPassport.getBusinessPassportFile();
            if (null != businessPassportFile) {
                JSONObject jsonFileObject = this.getFileData(businessPassportFile.getFileId());
                modelMap.put("jsonFileObject", jsonFileObject);
            } else {
                modelMap.put("jsonFileObject", null);
            }

            modelMap.put("businessPassport", businessPassport);
        }
        return "foreignaffairs/businessPassport/business-passport-edit";
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
        Boolean canceled = false;
        Boolean destroyed = false;
        Boolean borrowed = false;
        try {
            if (StringUtils.isNotEmpty(ids)) {
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0; i < jsonArray.size(); i++) {
                    String id = (String) jsonArray.get(i);
                    BusinessPassport businessPassport = businessPassportService.get(id);
                    String isCancel = businessPassport.getIsCancel();
                    String isDestroy = businessPassport.getIsDestroy();
                    String isBorrow = businessPassport.getIsBorrow();
                    if (isCancel.equals("1")) {
                        canceled = true;
                    }
                    if (isDestroy.equals("1")) {
                        destroyed = true;
                    }
                    if (isBorrow.equals("1")) {
                        borrowed = true;
                    }
                }

                if (canceled && destroyed) {//存在已注销并且已销毁
                    map.put("result", "canceledAndDestroyed");
                } else if (canceled && !destroyed) {//存在已注销
                    map.put("result", "canceled");
                } else if (!canceled && destroyed) {//存在已销毁
                    map.put("result", "destroyed");
                } else if (borrowed) {//存在已借出
                    map.put("result", "borrowed");
                } else {
                    map.put("result", true);
                }
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 注销
     * @param ids
     * @param cancelReason
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/business-passport-cancel.do", method = RequestMethod.POST)
    public Map<String, Object> cancel(String ids, String cancelReason) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(ids)) {
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0; i < jsonArray.size(); i ++) {
                    String id = (String) jsonArray.get(i);
                    BusinessPassport businessPassport = businessPassportService.get(id);
                    businessPassport.setIsCancel("1");
                    businessPassport.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    businessPassport.setCancelDate(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    businessPassport.setCancelReason(cancelReason);
                    businessPassportService.save(businessPassport);
                    //操作记录
                    BorrowReturnRecord borrowReturnRecord = new BorrowReturnRecord();
                    borrowReturnRecord.setStatus("0");
                    borrowReturnRecord.setCancelReason(cancelReason);
                    borrowReturnRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    borrowReturnRecord.setBusinessPassport(businessPassport);
                    borrowReturnRecordService.save(borrowReturnRecord);
                }
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因公护照");
                sysLogVo.setRecordType(19);
                sysLogVo.setEntityName(cancelReason);
                sysLogVo.setEntityId("");
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
                    BusinessPassport businessPassport = businessPassportService.get(id);
                    String isDestroy = businessPassport.getIsDestroy();
                    String isBorrow = businessPassport.getIsBorrow();
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
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 销毁
     * @param ids
     * @param destroyReason
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/business-passport-destroy.do", method = RequestMethod.POST)
    public Map<String, Object> destroy(String ids, String destroyReason) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(ids)) {
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0; i < jsonArray.size(); i ++) {
                    String id = (String) jsonArray.get(i);
                    BusinessPassport businessPassport = businessPassportService.get(id);
                    businessPassport.setIsDestroy("1");
                    businessPassport.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    businessPassport.setDestroyDate(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    businessPassport.setDestroyReason(destroyReason);
                    businessPassportService.save(businessPassport);
                    //操作记录
                    BorrowReturnRecord borrowReturnRecord = new BorrowReturnRecord();
                    borrowReturnRecord.setStatus("1");
                    borrowReturnRecord.setDestroyReason(destroyReason);
                    borrowReturnRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    borrowReturnRecord.setBusinessPassport(businessPassport);
                    borrowReturnRecordService.save(borrowReturnRecord);
                }
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因公护照");
                sysLogVo.setRecordType(20);
                sysLogVo.setEntityName(destroyReason);
                sysLogVo.setEntityId("");
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
     * 判断选中的数据是否存在注销并销毁或者已借出
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/is-exist-cancel-and-destroy.do", method = RequestMethod.POST)
    public Map<String, Object> isExistCancelAndDestroy(String ids) {
        Map<String, Object> map = new HashMap<>();
        Boolean canceledAndDestroyed = false;
        Boolean borrowed = false;
        try {
            if (StringUtils.isNotEmpty(ids)) {
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0; i < jsonArray.size(); i++) {
                    String id = (String) jsonArray.get(i);
                    BusinessPassport businessPassport = businessPassportService.get(id);
                    String isCancel = businessPassport.getIsCancel();
                    String isDestroy = businessPassport.getIsDestroy();
                    String isBorrow = businessPassport.getIsBorrow();
                    if (isCancel.equals("1") && isDestroy.equals("1")) {
                        canceledAndDestroyed = true;
                    }
                    if (isBorrow.equals("1")) {
                        borrowed = true;
                    }
                }
                if (canceledAndDestroyed) {//存在已注销并且已销毁
                    map.put("result", "canceledAndDestroyed");
                } else if (borrowed) {//存在已借出
                    map.put("result", "borrowed");
                } else {
                    map.put("result", true);
                }
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 注销并销毁
     * @param ids
     * @param cancelAndDestroyReason
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/business-passport-cancel-and-destroy.do", method = RequestMethod.POST)
    public Map<String, Object> cancelAndDestroy(String ids, String cancelAndDestroyReason) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(ids)) {
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0; i < jsonArray.size(); i ++) {
                    String id = (String) jsonArray.get(i);
                    BusinessPassport businessPassport = businessPassportService.get(id);
                    businessPassport.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    businessPassport.setIsCancel("1");
                    businessPassport.setIsDestroy("1");
                    businessPassport.setCancelDate(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    businessPassport.setDestroyDate(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    businessPassport.setCancelAndDestroyReason(cancelAndDestroyReason);
                    businessPassportService.save(businessPassport);
                    //操作记录
                    BorrowReturnRecord borrowReturnRecord = new BorrowReturnRecord();
                    borrowReturnRecord.setStatus("2");
                    borrowReturnRecord.setCancelAndDestroyReason(cancelAndDestroyReason);
                    borrowReturnRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    borrowReturnRecord.setBusinessPassport(businessPassport);
                    borrowReturnRecordService.save(borrowReturnRecord);
                }
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因公护照");
                sysLogVo.setRecordType(21);
                sysLogVo.setEntityName(cancelAndDestroyReason);
                sysLogVo.setEntityId("");
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
     * 借出
     * @param ids
     * @param borrowPerson
     * @param borrowPersonTel
     * @param returnDate
     * @param borrowAgent
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/business-passport-borrow.do", method = RequestMethod.POST)
    public Map<String, Object> borrow(String ids, String borrowPerson, String borrowPersonTel,
                                      String returnDate, String borrowAgent, String batchNumber) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(ids)) {
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0; i < jsonArray.size(); i ++) {
                    String id = (String) jsonArray.get(i);
                    BusinessPassport businessPassport = businessPassportService.get(id);
                    BorrowPassport borrowPassport = new BorrowPassport();
                    borrowPassport.setBorrowPerson(borrowPerson);
                    borrowPassport.setBorrowPersonTel(borrowPersonTel);
                    borrowPassport.setReturnDate(DateUtil.stringToDate(returnDate, DateUtil.FORMAT_DAY));
                    borrowPassport.setBorrowAgent(borrowAgent);
                    borrowPassport.setBatchNumber(batchNumber);
                    borrowPassport.setBusinessPassport(businessPassport);
                    businessPassport.setBorrowPassport(borrowPassport);
                    businessPassport.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    businessPassport.setIsBorrow("1");
                    businessPassportService.save(businessPassport);
                    //操作记录
                    BorrowReturnRecord borrowReturnRecord = new BorrowReturnRecord();
                    borrowReturnRecord.setStatus("3");
                    borrowReturnRecord.setBorrowAgent(borrowAgent);
                    borrowReturnRecord.setBorrowPerson(borrowPerson);
                    borrowReturnRecord.setBorrowPersonTel(borrowPersonTel);
                    borrowReturnRecord.setReturnDate(DateUtil.stringToDate(returnDate, DateUtil.FORMAT_DAY));
                    borrowReturnRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    borrowReturnRecord.setBusinessPassport(businessPassport);
                    borrowReturnRecordService.save(borrowReturnRecord);
                }
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因公护照");
                sysLogVo.setRecordType(22);
                sysLogVo.setEntityName(borrowPerson);
                sysLogVo.setEntityId("");
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
                    BusinessPassport businessPassport = businessPassportService.get(id);
                    String isBorrow = businessPassport.getIsBorrow();
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
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 归还
     * @param ids
     * @param returnAgent
     * @param actualReturnDate
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/business-passport-return-back.do", method = RequestMethod.POST)
    public Map<String, Object> returnBack(String ids, String returnAgent, String actualReturnDate) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(ids)) {
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0; i < jsonArray.size(); i ++) {
                    String id = (String) jsonArray.get(i);
                    BusinessPassport businessPassport = businessPassportService.get(id);
                    ReturnPassport returnPassport = new ReturnPassport();
                    returnPassport.setReturnAgent(returnAgent);
                    returnPassport.setActualReturnDate(DateUtil.stringToDate(actualReturnDate, DateUtil.FORMAT_DAY));
                    returnPassport.setBusinessPassport(businessPassport);
                    businessPassport.setReturnPassport(returnPassport);
                    businessPassport.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    businessPassport.setIsBorrow("0");
                    businessPassportService.save(businessPassport);
                    //操作记录
                    BorrowReturnRecord borrowReturnRecord = new BorrowReturnRecord();
                    borrowReturnRecord.setStatus("4");
                    borrowReturnRecord.setReturnAgent(returnAgent);
                    borrowReturnRecord.setActualReturnDate(DateUtil.stringToDate(actualReturnDate, DateUtil.FORMAT_DAY));
                    borrowReturnRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    borrowReturnRecord.setBusinessPassport(businessPassport);
                    borrowReturnRecordService.save(borrowReturnRecord);
                }
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("因公护照");
                sysLogVo.setRecordType(23);
                sysLogVo.setEntityName(returnAgent);
                sysLogVo.setEntityId("");
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    private JSONObject getFileData(String fileId) {
        JSONObject jsonFileObject = new JSONObject();
        DicUploadFile dicUploadFile = dicUploadFileService.get(fileId);
        String fileName = dicUploadFile.getFileName();
        jsonFileObject.put("id", fileId);
        jsonFileObject.put("fileName", fileName);
        return jsonFileObject;
    }

}
