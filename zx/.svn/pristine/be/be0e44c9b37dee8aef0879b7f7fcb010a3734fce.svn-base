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
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadHousing;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.abroad.AbroadHousingVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadHousingService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/abroad-housing")
public class AbroadHousingController extends BaseController<AbroadHousing> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private AbroadHousingService abroadHousingService;

    @Autowired
    private UtilService utilService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 页面跳转
     */
    @RequestMapping(value = "/abroad-housing-list", method = RequestMethod.GET)
    public String list(String abroadInfoId, ModelMap modelMap) {
        modelMap.addAttribute("abroadInfoId", abroadInfoId);
        AbroadInfo abroadInfo = abroadInfoService.get(abroadInfoId);
        modelMap.put("abroadInfo", abroadInfo);
        return "foreignaffairs/abroad/abroad-housing-list";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-housing-list.do", produces = "text/html;charset=UTF-8")
    public String housingListLoad(Carrier<AbroadHousing> carrier, AbroadHousingVo abroadHousingVo) {
        HashMap map = new HashMap(16);
        try {
            if (StringUtils.isNotEmpty(abroadHousingVo.getAbroadInfoId())) {
                map.put("abroadInfoId", abroadHousingVo.getAbroadInfoId());
                abroadHousingService.load(carrier, map);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑弹窗
     */
    @RequestMapping(value = "/load-housing-edit.do", method = RequestMethod.GET)
    public String abroadHousingEdit(ModelMap modelMap, String id) {
        AbroadHousing abroadHousing = null;
        if (StringUtils.isNotEmpty(id)) {
            abroadHousing = abroadHousingService.get(id);
        }
        modelMap.addAttribute("abroadHousing", abroadHousing);
        return "foreignaffairs/abroad/abroad-housing-edit";
    }

    /**
     * 新增/编辑保存
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-housing-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveAbroadHousing(HttpServletRequest request, AbroadHousingVo abroadHousingVo) {
        Map<String, Object> map = new HashMap<>(2);

        AbroadHousing abroadHousing;
        String id = abroadHousingVo.getId();
        if (id != null) {
            abroadHousing = abroadHousingService.get(id);
        } else {
            abroadHousing = new AbroadHousing();
            abroadHousing.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
        }

        try {
            AbroadInfo abroadInfo = abroadInfoService.get(abroadHousingVo.getAbroadInfoId());
            abroadHousing.setAbroadInfo(abroadInfo);

            if (StringUtils.isNotEmpty(abroadHousingVo.getCheckinDateStr())) {
                Date checkinDate = DateUtil.stringToDate(abroadHousingVo.getCheckinDateStr(), DateUtil.FORMAT_DAY);
                abroadHousing.setCheckinDate(checkinDate);
            }
            abroadHousing.setHotelName(abroadHousingVo.getHotelName());
            abroadHousing.setRoomArrange(abroadHousingVo.getRoomArrange());

            abroadHousing.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
            abroadHousing.setDelFlag("0");

            abroadHousingService.save(abroadHousing);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
            if(org.apache.commons.lang.StringUtils.isEmpty(abroadHousingVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(abroadHousing.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(abroadHousing.getId());
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
    @RequestMapping(value = "/abroad-housing-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteAbroadHousing(String id) {
        Map<String, Object> map = new HashMap<>(2);
        try {
            AbroadHousing abroadHousing = abroadHousingService.get(id);
            abroadHousingService.delete(abroadHousing);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(abroadHousing.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(abroadHousing.getId());
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
    @ResponseBody
    @RequestMapping(value = "/export-housing.do", method = RequestMethod.POST)
    public Map<String, Object> exportWord(String abroadInfoId, HttpServletRequest request,
                                          HttpServletResponse response) {
        Map<String, Object> map = new HashMap<>(1);
        if (StringUtils.isNotEmpty(abroadInfoId)) {
            AbroadInfo abroadInfo = abroadInfoService.get(abroadInfoId);
            List<AbroadHousing> abroadHousingList = abroadHousingService.findHousing(abroadInfoId);
            //导出Word
            try {
                this.export(abroadInfo, abroadHousingList, request, response);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("导出Word文件");
                sysLogVo.setRecordType(7);
                sysLogVo.setEntityName(abroadInfo.getAbroadType());
                sysLogVo.setEntityId(abroadInfo.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            } catch (DocumentException e) {
                LOG.debug(e.getMessage(), e);
                map.put("result", false);
            } catch (IOException e) {
                LOG.debug(e.getMessage(), e);
                map.put("result", false);
            }
        }

        return map;
    }

    /**
     * 导出Word文件
     *
     * @param abroadInfo
     * @param abroadHousingList
     * @param request
     * @param response
     * @throws DocumentException
     * @throws IOException
     */
    private void export(AbroadInfo abroadInfo, List<AbroadHousing> abroadHousingList,
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
        String fileName = abroadInfo.getGroupName() + "住房信息.doc";
        String temp = uploadPath + File.separator + fileName;
        File file = new File(temp);

        RtfWriter2.getInstance(document, new FileOutputStream(file));
        document.open();

        //设置标题字体风格
        RtfFont titleFont = new RtfFont("华文中宋", 22, Font.BOLD, Color.BLACK);

        //设置正文字体风格
        float contextFontSize = 12;
        RtfFont contextFont = new RtfFont("宋体", contextFontSize, Font.NORMAL);

        String titleStr = abroadInfo.getGroupName() + "住房信息";
        Paragraph title = new Paragraph(titleStr);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setFont(titleFont);
        title.setSpacingAfter(contextFontSize * 3);

        document.add(title);

        for (AbroadHousing abroadHousing : abroadHousingList) {
            String dateStr = "入住日期： " + DateUtil.dateToString(abroadHousing.getCheckinDate(), DateUtil.FORMAT_DAY_CN);
            Paragraph date = new Paragraph(dateStr);
            document.add(date);

            String hotelStr = "酒店名称： " + abroadHousing.getHotelName();
            Paragraph hotel = new Paragraph(hotelStr);
            hotel.setSpacingBefore(contextFontSize * 2);
            document.add(hotel);

            Paragraph rooms = new Paragraph("房间安排： ");
            rooms.setSpacingBefore(contextFontSize * 2);
            document.add(rooms);

            String roomListStr = abroadHousing.getRoomArrange();
            Paragraph roomList = new Paragraph(roomListStr);
            roomList.setSpacingBefore(contextFontSize * 1);
            document.add(roomList);

            Paragraph blank = new Paragraph("");
            blank.setSpacingAfter(contextFontSize * 2);
            document.add(blank);

        }

        document.close();

        FileUtil.downOrPreview(fileName, temp, response, request,"0");

        file.delete();
    }

}
