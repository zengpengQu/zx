package com.taiji.frame.controller.foreignaffairs.abroad;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.rtf.RtfWriter2;
import com.lowagie.text.rtf.style.RtfFont;
import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.FileUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadVehicle;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.abroad.AbroadVehicleVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadVehicleService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/abroad-vehicle")
public class AbroadVehicleController extends BaseController<AbroadVehicle> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private AbroadVehicleService abroadVehicleService;

    @Autowired
    private UtilService utilService;


    @Autowired
    private SysLogService sysLogService;


    /**
     * 页面跳转
     */
    @RequestMapping(value = "/abroad-vehicle-list", method = RequestMethod.GET)
    public String list(String abroadInfoId, ModelMap modelMap) {
        modelMap.addAttribute("abroadInfoId", abroadInfoId);
        return "foreignaffairs/abroad/abroad-vehicle-list";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-vehicle-list.do", produces = "text/html;charset=UTF-8")
    public String vehicleListLoad(Carrier<AbroadVehicle> carrier, AbroadVehicleVo abroadVehicleVo) {
        HashMap map = new HashMap(16);
        try {
            if (StringUtils.isNotEmpty(abroadVehicleVo.getAbroadInfoId())) {
                map.put("abroadInfoId", abroadVehicleVo.getAbroadInfoId());
                abroadVehicleService.load(carrier, map);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑弹窗
     */
    @RequestMapping(value = "/load-vehicle-edit.do", method = RequestMethod.GET)
    public String abroadVehicleEdit(ModelMap modelMap, String id) {
        AbroadVehicle abroadVehicle = null;
        if (StringUtils.isNotEmpty(id)) {
            abroadVehicle = abroadVehicleService.get(id);
        }
        modelMap.addAttribute("abroadVehicle", abroadVehicle);
        return "foreignaffairs/abroad/abroad-vehicle-edit";
    }

    /**
     * 新增/编辑保存
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-vehicle-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveAbroadVehicle(HttpServletRequest request, AbroadVehicleVo abroadVehicleVo) {
        Map<String, Object> map = new HashMap<>(2);

        AbroadVehicle abroadVehicle;
        String id = abroadVehicleVo.getId();
        if (id != null) {
            abroadVehicle = abroadVehicleService.get(id);
        } else {
            abroadVehicle = new AbroadVehicle();
            abroadVehicle.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
        }

        try {
            AbroadInfo abroadInfo = abroadInfoService.get(abroadVehicleVo.getAbroadInfoId());
            abroadVehicle.setAbroadInfo(abroadInfo);

            abroadVehicle.setActivityRoute(abroadVehicleVo.getActivityRoute());
            abroadVehicle.setVehicleInfo(abroadVehicleVo.getVehicleInfo());
            abroadVehicle.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
            abroadVehicle.setDelFlag("0");

            abroadVehicleService.save(abroadVehicle);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
            if(org.apache.commons.lang.StringUtils.isEmpty(abroadVehicleVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(abroadVehicle.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(abroadVehicle.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 删除
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-vehicle-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteAbroadVehicle(String id) {
        Map<String, Object> map = new HashMap<>(2);
        try {
            AbroadVehicle abroadVehicle = abroadVehicleService.get(id);
            abroadVehicleService.delete(abroadVehicle);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(abroadVehicle.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(abroadVehicle.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 导出Word文件
     */
    @RequestMapping(value = "/export-vehicle.do", method = RequestMethod.GET)
    public Map<String, Object> exportWord(String abroadInfoId, HttpServletRequest request,
                                          HttpServletResponse response) {
        Map<String, Object> map = new HashMap<>(1);
        if (StringUtils.isNotEmpty(abroadInfoId)) {
            AbroadInfo abroadInfo = abroadInfoService.get(abroadInfoId);
            List<AbroadVehicle> abroadHousingList = abroadVehicleService.findVehicle(abroadInfoId);
            //导出Word
            try {
                this.export(abroadInfo, abroadHousingList, request, response);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("导出Word文件");
                    sysLogVo.setRecordType(7);
                sysLogVo.setEntityName(abroadInfo.getAbroadType());
                sysLogVo.setEntityId(abroadInfo.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            } catch (DocumentException e) {
                LOG.debug(e.getMessage(), e);
            } catch (IOException e) {
                LOG.debug(e.getMessage(), e);
            }
        }

        return map;
    }


    /**
     * 导出Word文件
     *
     * @param abroadInfo
     * @param abroadVehicleList
     * @param request
     * @param response
     * @throws DocumentException
     * @throws IOException
     */
    private void export(AbroadInfo abroadInfo, List<AbroadVehicle> abroadVehicleList,
                        HttpServletRequest request, HttpServletResponse response)
            throws DocumentException, IOException {
        //设置纸张大小
        Document document = new Document(PageSize.A4, 90.0F, 90.0F, 72.0F, 72.0F);

        // 创建临时文件
        String uploadPath = request.getSession().getServletContext().getRealPath("upload");
        File f = new File(uploadPath);
        //文件夹不存在
        if(!f.exists())
        {
            f.mkdirs();
        }
        String fileName = abroadInfo.getGroupName() + "乘车信息.doc";
        String temp = uploadPath + File.separator + fileName;
        File file = new File(temp);

        RtfWriter2.getInstance(document, new FileOutputStream(file));
        document.open();

        //设置标题字体风格
        RtfFont titleFont = new RtfFont("华文中宋", 22, Font.BOLD, Color.BLACK);

        //设置正文字体风格
        float contextFontSize = 12;
        RtfFont contextFont = new RtfFont("宋体", contextFontSize, Font.NORMAL);

        String titleStr = abroadInfo.getGroupName() + "乘车信息";
        Paragraph title = new Paragraph(titleStr);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setFont(titleFont);
        title.setSpacingAfter(contextFontSize * 3);

        document.add(title);

        for (AbroadVehicle abroadVehicle : abroadVehicleList) {

            Paragraph routeTitle = new Paragraph("活动路线： ");
            document.add(routeTitle);

            String routeStr = abroadVehicle.getActivityRoute();
            Paragraph route = new Paragraph(routeStr);
            route.setSpacingBefore(contextFontSize * 1);
            route.setFont(contextFont);
            document.add(route);

            Paragraph arrangeTitle = new Paragraph("乘车安排： ");
            arrangeTitle.setSpacingBefore(contextFontSize * 2);
            document.add(arrangeTitle);

            String arrangeStr = abroadVehicle.getVehicleInfo();
            Paragraph arrange = new Paragraph(arrangeStr);
            arrange.setSpacingBefore(contextFontSize * 1);
            arrange.setFont(contextFont);
            document.add(arrange);

            Paragraph blank = new Paragraph("");
            blank.setSpacingAfter(contextFontSize * 2);
            document.add(blank);
        }

        document.close();

        FileUtil.downOrPreview(fileName, temp, response, request,"0");

        file.delete();

    }

}
