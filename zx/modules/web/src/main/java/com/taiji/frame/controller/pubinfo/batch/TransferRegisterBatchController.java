package com.taiji.frame.controller.pubinfo.batch;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.hkmacao.HkMaCao;
import com.taiji.frame.model.entity.pubinfo.batch.DicReason;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatch;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatchOut;
import com.taiji.frame.model.entity.pubinfo.batch.RegisterBatch;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.vo.pubinfo.batch.DraftBatchOutVo;
import com.taiji.frame.model.vo.pubinfo.batch.DraftBatchVo;
import com.taiji.frame.model.vo.pubinfo.batch.RegisterBatchVo;
import com.taiji.frame.service.pubinfo.batch.*;
import com.taiji.frame.service.systempara.DicDeptService;
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
import org.springframework.beans.BeansException;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author admin
 * 呈批件登记
 */
@Controller
@RequestMapping(value = "/register-batch")
public class TransferRegisterBatchController extends BaseController<RegisterBatch> {

    @Autowired
    private DicDeptService dicDeptService;
    @Autowired
    private DicReasonService dicReasonService;
    @Autowired
    private SubmitBatchService submitBatchService;

    /**
     * 进入模块时内行文二维码页面跳转
     */
    @RequestMapping(value = "/batch-transfer-register", method = RequestMethod.GET)
    public String batchTransferCode(ModelMap modelMap,String id) {

        modelMap.addAttribute("result","nei");
        //部门名称
        List<DicDept> deptList = dicDeptService.getBelongDept("01");
        modelMap.addAttribute("deptList", deptList);
        //补录理由
        List<DicReason> dicReasonList = dicReasonService.getAllByStatus(1);
        modelMap.addAttribute("dicReasonList", dicReasonList);
        //编辑数据
        if (StringUtils.isNotEmpty(id)){
            DraftBatch draftBatch =  submitBatchService.get(id);
            modelMap.addAttribute("model", draftBatch);
        }
        return "pubinfo/batch/register-batch/batch-transfer-qcode";
    }

    /**
     * 进入模块时内行文二维码页面跳转
     */
    @RequestMapping(value = "/batch-transfer-wai-register", method = RequestMethod.GET)
    public String batchTransferCodeWai(ModelMap modelMap,String id) {

        modelMap.addAttribute("result","wai");
        //部门名称
        List<DicDept> deptList = dicDeptService.getBelongDept("01");
        modelMap.addAttribute("deptList", deptList);
        //补录理由
        List<DicReason> dicReasonList = dicReasonService.getAllByStatus(1);
        modelMap.addAttribute("dicReasonList", dicReasonList);
        //编辑数据
        if (StringUtils.isNotEmpty(id)){
            DraftBatch draftBatch =  submitBatchService.get(id);
            modelMap.addAttribute("model", draftBatch);
        }
        return "pubinfo/batch/register-batch/batch-transfer-qcode";
    }

    /**
     *  呈批件搜索跳转页面,暂时不用
     */
    @RequestMapping(value = "/batch-load-list",method = RequestMethod.GET)
    public String batchLoadView(ModelMap modelMap,String id) {
        return "pubinfo/batch/register-batch/batch-transfer-register-list";
    }

}
