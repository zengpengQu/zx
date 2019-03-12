package com.taiji.frame.controller.foreignaffairs.taiwanCard;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.model.entity.foreignaffairs.passportRecord.AskReturnRecord;
import com.taiji.frame.model.entity.foreignaffairs.passportRecord.BorrowRecord;
import com.taiji.frame.model.entity.foreignaffairs.taiwanCard.TaiWanCard;
import com.taiji.frame.model.entity.foreignaffairs.taiwanCard.TaiWanCardFile;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.taiwanCard.TaiWanCardVo;
import com.taiji.frame.model.vo.passportuser.PassportUserVo;
import com.taiji.frame.service.foreignaffairs.passportRecord.AskReturnRecordService;
import com.taiji.frame.service.foreignaffairs.passportRecord.BorrowRecordService;
import com.taiji.frame.service.foreignaffairs.taiwanCard.TaiWanCardFileService;
import com.taiji.frame.service.foreignaffairs.taiwanCard.TaiWanCardService;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.text.ParseException;
import java.util.*;

/**
 * @author qzp
 * @date 2018/08/10
 * 赴台通行证控制器
 */
@Controller
@RequestMapping(value = "/taiwan-card")
public class TaiWanCardController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanCardController.class);

    @Autowired
    private TaiWanCardService taiWanCardService;

    @Autowired
    private TaiWanCardFileService taiWanCardFileService;

    @Autowired
    private DicUserService dicUserService;

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private BorrowRecordService borrowRecordService;

    @Autowired
    private AskReturnRecordService askReturnRecordService;

    @Autowired
    private SysLogService sysLogService;
    /**
     * 页面跳转
     * @return
     */
    @RequestMapping(value = "/taiwan-card-list",method = RequestMethod.GET)
    public String jumpPage(){
        return "foreignaffairs/taiwanCard/taiwan-card-list";
    }

    @RequestMapping(value = "/load-taiwan-card-add", method = RequestMethod.GET)
    public String addPage() {
        return "foreignaffairs/taiwanCard/taiwan-card-add";
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
            taiWanCardService.loadUser(carrier, map);
        } catch (Exception e) {
            LOGGER.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 赴台通行证列表
     * @param cardCarrier
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-taiwan-card-list.do",produces = "text/html;charset=UTF-8")
    public String list (Carrier<TaiWanCard> cardCarrier,
                    String empName,String permitCode,
                    String signDateStr,String validDateStr){
        Map<String, Object> map = new HashMap<>(3);
        try {
            if (StringUtils.isNotEmpty(empName)){
                map.put("empName","%" + empName + "%");
            }
            if (StringUtils.isNotEmpty(permitCode)){
                map.put("permitCode", "%" + permitCode + "%");
            }
            if (StringUtils.isNotEmpty(signDateStr)){
                map.put("signDateStr",signDateStr);
            }
            if (StringUtils.isNotEmpty(validDateStr)){
                map.put("validDateStr",validDateStr);
            }
            taiWanCardService.load(cardCarrier,map);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(),e);
        }
        return gridResult(cardCarrier);
    }


    /**
     * 判断是否可以办理
     * @param userId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/taiwan-card-is-can-transact.do", method = RequestMethod.POST)
    public Map<String, Object> isCanTransact(String userId) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(userId)) {
                Boolean isCanTransact = taiWanCardService.isCanTransact(userId);
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
            LOGGER.debug(e.getMessage(), e);
        }
        return map;
    }


    /**
     * 跳转到新增页面
     * @param modelMap
     * @param userId
     * @return
     */
    @RequestMapping(value = "/taiwan-card-transact",method = RequestMethod.GET)
    public String transact(ModelMap modelMap,String userId){
        if(StringUtils.isNotEmpty(userId)){
            DicUser dicUser = dicUserService.get(userId);
            DicDept dicDept = dicUser.getDicDept();

            modelMap.addAttribute("dicDept", dicDept.getJsonObject());
            modelMap.addAttribute("dicUser", dicUser);
        }
        return "foreignaffairs/taiwanCard/taiwan-card-transact";
    }

    /**
     * 跳转到新增或编辑页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-taiwan-card-edit",method = RequestMethod.GET)
    public String jumpToEditPage(ModelMap modelMap,String id){
        TaiWanCard taiWanCard = new TaiWanCard();
        if(StringUtils.isNotEmpty(id)){
            taiWanCard = taiWanCardService.get(id);
            modelMap.addAttribute("taiWanCard",taiWanCard);
            TaiWanCardFile taiWanCardFile = taiWanCard.getTaiWanCardFile();
            if (null != taiWanCardFile) {
                JSONObject jsonFileObject = this.getFileData(taiWanCardFile.getFileId());
                modelMap.put("jsonFileObject", jsonFileObject);
            } else {
                modelMap.put("jsonFileObject", null);
            }
        }else {
            modelMap.addAttribute("taiWanCard",null);
        }
        //人员信息
        List<DicUser> dicUserList = dicUserService.getAll();
        modelMap.addAttribute("dicUserList",dicUserList);

        //部门信息
        DicDept dicDept = new DicDept();
        if (null != taiWanCard.getDicDept()) {
            dicDept = taiWanCard.getDicDept();
        }
        modelMap.addAttribute("dicDept",dicDept.getJsonObject());

        return "foreignaffairs/taiwanCard/taiwan-card-edit";
    }

    /**
     * 新增或编辑---数据保存
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-taiwan-card-save.do",method = RequestMethod.POST)
    public Map<String,Object> saveOrUpdate(TaiWanCardVo taiWanCardVo, HttpServletRequest request) throws ParseException{
        String basePath = UploadConstant.uploadBaseDir;
        DicUser curUser = getCurUser();
        Map<String,Object> map = taiWanCardService.saveData(taiWanCardVo,basePath,curUser,getSysLogVo(),getCurDate());
        return map;
    }
    /**
     * 删除赴台通行证
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/taiwan-card-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteTaiwanInfo(String id) {
        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {
            try {
                TaiWanCard taiWanCard = taiWanCardService.get(id);
                taiWanCard.setDelFlag("1");
                taiWanCardService.save(taiWanCard);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("赴台通行证");
                sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(taiWanCard.getDicUser().getEmpName());
                sysLogVo.setEntityId(taiWanCard.getId());
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
     * 借出
     * @param id
     * @param borrowNotes
     * @param borrower
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/taiwan-card-borrow.do",method = RequestMethod.POST)
    public Map<String,Object> borrowed(String id, String borrowNotes,String borrower){
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)){
                TaiWanCard taiWanCard = taiWanCardService.get(id);
                taiWanCard.setUpdateTime(new Date());
                taiWanCard.setIsBorrow("1");
                taiWanCardService.save(taiWanCard);
                //流转记录
                BorrowRecord borrowRecord = new BorrowRecord();
                borrowRecord.setStatus("1");
                borrowRecord.setBorrower(borrower);
                borrowRecord.setBorrowTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                borrowRecord.setNotes(borrowNotes);
                borrowRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                borrowRecord.setDicUser(getCurUser());
                borrowRecord.setPermitId(id);
                borrowRecord.setPermitType("1");
                borrowRecordService.save(borrowRecord);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("赴台通行证");
                    sysLogVo.setRecordType(22);
                sysLogVo.setEntityName(borrowRecord.getDicUser().getEmpName());
                sysLogVo.setEntityId(borrowRecord.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOGGER.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 归还
     * @param id
     * @param returnPeople
     * @param returnNotes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/taiwan-card-return.do",method = RequestMethod.POST)
    public Map<String,Object> returned(String id,String returnPeople,String returnNotes){
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)){
                TaiWanCard taiWanCard = taiWanCardService.get(id);
                taiWanCard.setUpdateTime(new Date());
                taiWanCard.setIsBorrow("2");
                taiWanCardService.save(taiWanCard);
                //流转记录
                BorrowRecord borrowRecord = new BorrowRecord();
                borrowRecord.setStatus("2");
                borrowRecord.setReturnPeople(returnPeople);
                borrowRecord.setReturnTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                borrowRecord.setNotes(returnNotes);
                borrowRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                borrowRecord.setDicUser(getCurUser());
                borrowRecord.setPermitId(id);
                borrowRecord.setPermitType("1");
                borrowRecordService.save(borrowRecord);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("赴台通行证");
                sysLogVo.setRecordType(23);
                sysLogVo.setEntityName(borrowRecord.getDicUser().getEmpName());
                sysLogVo.setEntityId(borrowRecord.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        }catch (Exception e){
            LOGGER.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 催还
     * @param id
     * @param askContent
     * @param askReturnNotes
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/taiwan-card-ask-return.do",method = RequestMethod.POST)
    public Map<String,Object> askReturn(String id, String askContent, String askReturnNotes){
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)){
                TaiWanCard taiWanCard = taiWanCardService.get(id);
                AskReturnRecord askReturnRecord = new AskReturnRecord();
                askReturnRecord.setAskContent(askContent);
                askReturnRecord.setDelFlag("0");
                askReturnRecord.setDicUser(getCurUser());
                String permitCode = taiWanCard.getPermitCode();
                askReturnRecord.setDocumentCode(permitCode);
                askReturnRecord.setNotes(askReturnNotes);
                askReturnRecord.setPeopleName(taiWanCard.getDicUser().getEmpName());
                askReturnRecord.setPermitId(id);
                askReturnRecord.setPermitType("1");
                askReturnRecord.setAskTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                askReturnRecord.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                askReturnRecord.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                askReturnRecordService.save(askReturnRecord);
                map.put("result",true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("赴台通行证");
                sysLogVo.setRecordType(24);
                sysLogVo.setEntityName(askReturnRecord.getDicUser().getEmpName());
                sysLogVo.setEntityId(askReturnRecord.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        }catch (Exception e){
            LOGGER.debug(e.getMessage(), e);
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
    @RequestMapping(value = "/export-excel.do",method = RequestMethod.GET)
    public void exportExcel(HttpServletRequest request, HttpServletResponse response){
        try {
            String empName = new String((request.getParameter("empName")).getBytes("iso-8859-1"), "utf-8");
            String permitCode = request.getParameter("permitCode");
            String signDateStr = request.getParameter("signDateStr");
            String validDateStr = request.getParameter("validDateStr");
            List<TaiWanCard> list = taiWanCardService.findDataForExcel(empName,permitCode,signDateStr,validDateStr);
            String fileName = "赴台通行证详细信息.xls";
            //设置输入流参数
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("赴台通行证");
            sysLogVo.setRecordType(7);
            sysLogVo.setEntityName("赴台通行证详细信息");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            OutputStream os = OtherUtil.getOutputStream(fileName, request, response);
            String dateStr = DateUtil.getDateStr(getCurDate());
            String userName = getCurUser().getEmpName();
            taiWanCardService.createExcel(os,fileName,dateStr,userName,list);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(),e);
        }
    }


    /**
     * 详情查看
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/taiwan-card-view",method = RequestMethod.GET)
    public String view(ModelMap modelMap,String id){
        if (StringUtils.isNotEmpty(id)){
            TaiWanCard taiWanCard = taiWanCardService.get(id);
            modelMap.addAttribute("taiWanCard",taiWanCard);
            TaiWanCardFile taiWanCardFile = taiWanCardFileService.findByCardId(id);
            JSONObject jsonFileObject = new JSONObject();
            if (null != taiWanCardFile){
                String fileId = taiWanCardFile.getFileId();
                DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                jsonFileObject.put("id",fileId);
                jsonFileObject.put("fileName",uploadFile.getFileName());
                modelMap.put("jsonFileObject", jsonFileObject);
            }else {
                modelMap.put("jsonFileObject", null);
            }
            Map<String, List<BorrowRecord>> recordMap = borrowRecordService.findRecordByPermitId(id);
            if (recordMap.size() > 0) {
                modelMap.put("recordMap", recordMap);
            } else {
                modelMap.put("recordMap", null);
            }
        }
        return "foreignaffairs/taiwanCard/taiwan-card-view";
    }

    private JSONObject getFileData(String fileId) {
        JSONObject jsonFileObject = new JSONObject();
        DicUploadFile dicUploadFile = dicUploadFileService.get(fileId);
        jsonFileObject.put("id", fileId);
        jsonFileObject.put("fileName", dicUploadFile.getFileName());
        return jsonFileObject;
    }
}
